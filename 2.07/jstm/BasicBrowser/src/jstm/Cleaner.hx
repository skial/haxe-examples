/**
 * contains all js cleaning logic
 * 
 * @author Cref
 */

package jstm;

using hxtc.use.ForString;

class Cleaner {
	
	//TODO: use stackVar
	static var exStack = ~/\n[\t ]*\$e = \[\];\n[\t ]*while\(\$s\.length >= \$spos\) \$e.unshift\(\$s\.pop\(\)\);\n[\t ]*\$s\.push\(\$e\[0\]\);/g;
	public static var callStack = ~/function\(([^\)\n]*)\) {\n[\t ]*\$s\.push\("[^\n]*@([0-9]*)"\);\n[^\n]*\n/;
	public static var callStackGlobal = ~/function\(([^\)\n]*)\) {\n[\t ]*\$s\.push\("[^\n]*@([0-9]*)"\);\n[^\n]*\n/g;
	static var extraLines = ~/(\$r = |\n\t*(var \$spos = \$s\.length|\$s\.pop\(\)|return \$(r|tmp)|var \$r);)/g;
	static var tmpReturns = ~/(\n\t*)(var )?\$(r|tmp) =/g;
	//also matches comment lines because comments within __js__ calls are still in the source
	static var whitespace = ~/(\/\/[^\n]*\n|\n|\t)/g;
	static var spaces1=~/ *([^a-zA-Z0-9_\$])/g;
	static var spaces2 = ~/([^a-zA-Z0-9_\$]) */g;
	static var switchOpen = ~/function\(\$this\)/g;
	static var switchClose = ~/}\(\$?this\)\)/g;
	static var switchThis = ~/\$this/g;
	
	//removes context wrapper function
	public static function cleanInit(src:String):String {
		//return src;//for debugging purposes
		if (!src.contains('\n')) return src;
		var s = src.split('\n');
		if (s[0] != '(function($this) {') return src;
		s.shift();
		s.shift();
		s.pop();
		s.pop();
		//s[s.length - 1] = ~/\$r = /.replace(s[s.length - 1], '');
		//return s.join('\n');
		return ~/\$r = /.replace(s.join('\n'), '');
	}
	
	public static function cleanUp(src:String){
		//return src;//for debugging purposes
		#if debug
		//exception stack and call stack moved to Runtime
		src = exStack.replace(src,'');
		src = callStackGlobal.replace(src, 'function $$$2($1){\n');
		#end
		src = tmpReturns.replace(src, '$1return');
		src = switchOpen.replace(src, 'function()');
		src = switchClose.replace(src,'}.call(this))');
		src = switchThis.replace(src,'this');
		src = extraLines.replace(src, '');
		#if !debug
		//src = SourceTools.minify(src);//minify is too slow for big projects, using following code instead:
		src = jstm.SourceTools.ignoreStringLiterals(src, function(src:String) {
			src = whitespace.replace(src, '');//TODO: fix comments cleanup! not within string literals!
			src = spaces1.replace(src,'$1');
			src = spaces2.replace(src, '$1');
			//We should also remove comment blocks here but that's kinda complicated without non-greedy matches
			src = jstm.SourceTools.fixLevel3(src);
			return src;
		});
		#end
		return src;
	}
}