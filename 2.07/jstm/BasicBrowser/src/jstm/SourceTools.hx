/**
 * ...
 * @author Cref
 */

package jstm;

/**
 * Uses JSMin haxelib by Andy Li
 * http://lib.haxe.org/p/jsmin
 * which in turn was based on Douglas Crockford's JSMin script.
 * http://www.crockford.com/javascript/jsmin.html
 * 
 * Added some extra measures for preventing syntax errors.
 * 
 * @author Cref
 */
class SourceTools {
	
	//NOTE:
	//Non capturing groups '(?:' are not supported in macros
	//Ungreedy *? are not supported in macros
	//static var stringsRE = ~/"[^"\\\r\n]*(?:\\.[^"\\\r\n]*)*"/g;
	static var stringsRE = ~/"[^"\\\r\n]*(\\.[^"\\\r\n]*)*"/g;
	//static var stringsRE = ~/("[^"\\\r\n]*(\\.[^"\\\r\n]*)*"|'[^'\\\r\n]*(\\.[^'\\\r\n]*)*')/g;
	static var replacedStringsRE = ~/\$STR([0-9]*)/g;
	
	//safely run a function on javascript sourcecode with any string literals filtered out
	public static function ignoreStringLiterals(src:String, fn:String->String):String {
		//remove string values from sourcecode and store them in an array
		var strings = [];
		src = stringsRE.customReplace(src, function(re) {
			strings.push(re.matched(0));
			return '$STR'+strings.length;
		});
		//run the function on the source with emty strings
		//src = usedTypesRE.customReplace(src, fn);
		src=fn(src);
		//return the source with the strings restored
		return replacedStringsRE.customReplace(src, function(re) {
			return strings[Std.parseInt(re.matched(1))-1];
		});
	}
	
	private static var fix1 = ~/}else/g;
	//unsupported \w in macro's and non-capturing groups (negative lookahead) don't work!
	//private static var fix2 = ~/}(?!else|catch|[^\w\$\{])/g;
	private static var fix2 = ~/}([a-zA-Z0-9_${]....)/g;
	
	
	public static function fixLevel3(src:String):String {
		//remove redundant ';' characters
		src = StringTools.replace(src,';}', '}');
		//inserting new line between '}' and 'else'. wouldn't be necessary if I could identify:
		//if (x){}else - which should remain untouched
		//and:
		//if (x) return {}else - which should become: if (x) return {};else
		src = fix1.replace(src,'}\nelse');
		//fix syntax errors resulting from alphanumeric characters directly following '}'
		src = fix2.customReplace(src, function(er) {
			var m = er.matched(1);
			return '}'+(m=='while'||m=='catch'?'':';')+m;
		});
		return src;
	}
	/*
	public static function minify(src:String, level:Int=3) {
		src = new jsmin.JSMin(src, level).output;
		//make JsMin level 3 work
		if (level == 3) src=ignoreStringLiterals(src, fixLevel3);
		//Cref: jsmin adds a new line that we don't want, should be fixed in jsmin itself
		src = src.substr(1);
		return src;
	}
	*/
	
}