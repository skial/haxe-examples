/**
 * currently, this class is only used for the js target as it uses
 * untyped __js__ calls.
 * it should be possible to port the js code to haXe so it can also be
 * used for the flash target.
 * TODO: implement all static methods from standard Utf8 class.
 * 
 * haxe.io.Bytes also contains UTF-8 encoding and decoding functionality.
 * 
 * @author Cref
 */
package js;

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */
/*  Utf8 class: encode / decode between multi-byte Unicode characters and UTF-8 multiple          */
/*              single-byte character encoding (c) Chris Veness 2002-2010                         */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */

class Utf8 {
	/**
	 * Encode multi-byte Unicode string into utf-8 multiple single-byte characters 
	 * (BMP / basic multilingual plane only)
	 *
	 * Chars in range U+0080 - U+07FF are encoded in 2 chars, U+0800 - U+FFFF in 3 chars
	 *
	 * @param {String} strUni Unicode string to be encoded as UTF-8
	 * @returns {String} encoded string
	 */
	public static function encode(strUni:String):String {
		var strUtf = '';
		untyped __js__("
		// use regular expressions & String.replace callback function for better efficiency 
		// than procedural approaches
		strUtf = strUni.replace(
			/[\\u0080-\\u07ff]/g,  // U+0080 - U+07FF => 2 bytes 110yyyyy, 10zzzzzz
			function(c) { 
				var cc = c.charCodeAt(0);
				return String.fromCharCode(0xc0 | cc>>6, 0x80 | cc&0x3f); }
		);
		strUtf = strUtf.replace(
			/[\\u0800-\\uffff]/g,  // U+0800 - U+FFFF => 3 bytes 1110xxxx, 10yyyyyy, 10zzzzzz
			function(c) { 
				var cc = c.charCodeAt(0); 
				return String.fromCharCode(0xe0 | cc>>12, 0x80 | cc>>6&0x3F, 0x80 | cc&0x3f); }
		);
		");
		return strUtf;
	}
	/**
	 * Decode utf-8 encoded string back into multi-byte Unicode characters
	 *
	 * @param {String} strUtf UTF-8 string to be decoded back to Unicode
	 * @returns {String} decoded string
	 */
	public static function decode(strUtf:String):String {
		var strUni = '';
		untyped __js__("
		var strUni = strUtf.replace(
			/[\\u00c0-\\u00df][\\u0080-\\u00bf]/g,// 2-byte chars
			function(c) {  // (note parentheses for precence)
				return String.fromCharCode((c.charCodeAt(0)&0x1f)<<6 | c.charCodeAt(1)&0x3f);
			}
		);
		strUni = strUni.replace(
			/[\\u00e0-\\u00ef][\\u0080-\\u00bf][\\u0080-\\u00bf]/g,// 3-byte chars
			function(c) {  // (note parentheses for precence)
				return String.fromCharCode(((c.charCodeAt(0)&0x0f)<<12) | ((c.charCodeAt(1)&0x3f)<<6) | ( c.charCodeAt(2)&0x3f));
			}
		);
		");
		return strUni;
	}
}