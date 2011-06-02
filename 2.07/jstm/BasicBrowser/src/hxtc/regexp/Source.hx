/**
 * ...
 * @author Cref
 */

package hxtc.regexp;

class Source {
	
	public static var stringLiteralRE = ~/("(?:[^"\\]|(?:\\\\)|(?:\\\\)*\\.{1})*")/g;
	
	//leaves string literals intact!
	//should really be a little bit faster...
	public static function doWithCode(src:String, f:String->String):String {
		var sep = String.fromCharCode(31);
		var code = f(stringLiteralRE.split(src).join(sep)).split(sep);
		var r = '',n=0;
		stringLiteralRE.customReplace(src,function(re) {
			r+=code[n++]+re.matched(1);
			return '';
		});
		return r+code[n];
	}
	
}