/**
 * TODO: use more target specific optimizations
 * An optimized AS3 solution: http://jpauclair.net/2010/01/09/base64-optimized-as3-lib/
 * An optimized haXe (Flash) solution: http://code.google.com/p/e4xu/source/browse/trunk/haxe/src/org/wvxvws/encoding/Base64.hx
 * @author Cref
 */

package hxtc;

#if jscript
//use an optimized Base64 solution for ActiveX targets
typedef Base64 = Base64_activex__;
#else
using haxe.BaseCode;
using hxtc.use.ForString;

class Base64 {
	private static var chars:String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
	public static function encode(str:String):String {
		var r = str.encode(chars);//also does utf-8 encoding
		//add padding:
		switch(r.length%4) {
			case 2: r += '==';
			case 3:  r += '=';
		}
		return r;
	}
	public static function decode(str:String):String {
		return str.replaceEnd('=').replaceEnd('=').decode(chars);//remove padding, also does utf-8 decoding
	}
}
#end

/* solution that doesn't use haxe.BaseCode: (encoding and decoding are both slower)

class Base64 {
	private static var chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	public static function encode(input:String) {
		var output:String = "",chr1:Int,chr2:Int,chr3:Int,enc1:Int,enc2:Int,enc3:Int,enc4:Int,i:Int = 0;
		input = Utf8.encode(input);
		while (i < input.length) {
			chr1 = input.charCodeAt(i++);
			chr2 = input.charCodeAt(i++);
			chr3 = input.charCodeAt(i++);
			enc1 = chr1 >> 2;
			enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
			enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
			enc4 = chr3 & 63;
			if (chr2 == null) enc3 = enc4 = 64;
			else if (chr3 == null) enc4 = 64;
			output = output + chars.charAt(enc1) + chars.charAt(enc2) + chars.charAt(enc3) + chars.charAt(enc4);
		}
		return output;
	}
	public static function decode(input:String) {
		var output:String = "",chr1:Int,chr2:Int,chr3:Int,enc1:Int,enc2:Int,enc3:Int,enc4:Int,i:Int = 0,r = ~/[^A-Za-z0-9\+\/\=]/g;
		input = r.replace(input, "");
		while (i < input.length) {
			enc1 = chars.indexOf(input.charAt(i++));
			enc2 = chars.indexOf(input.charAt(i++));
			enc3 = chars.indexOf(input.charAt(i++));
			enc4 = chars.indexOf(input.charAt(i++));
			chr1 = (enc1 << 2) | (enc2 >> 4);
			chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
			chr3 = ((enc3 & 3) << 6) | enc4;
			output = output + String.fromCharCode(chr1);
			if (enc3 != 64) output = output + String.fromCharCode(chr2);
			if (enc4 != 64) output = output + String.fromCharCode(chr3);
		}
		output = Utf8.decode(output);
		return output;
	}
}
*/