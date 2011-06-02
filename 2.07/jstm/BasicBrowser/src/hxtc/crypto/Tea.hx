/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */
/*  Block TEA (xxtea) Tiny Encryption Algorithm implementation in JavaScript                      */
/*     (c) Chris Veness 2002-2010: http://www.movable-type.co.uk/tea-block.html                   */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */
/*  Algorithm: David Wheeler & Roger Needham, Cambridge University Computer Lab                   */
/*             http://www.cl.cam.ac.uk/ftp/papers/djw-rmn/djw-rmn-tea.html (1994)                 */
/*             http://www.cl.cam.ac.uk/ftp/users/djw3/xtea.ps (1997)                              */
/*             http://www.cl.cam.ac.uk/ftp/users/djw3/xxtea.ps (1998)                             */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */

/*
 * bij toeval ontdekt in browsers: resultaat klopt niet!!!
 * TEA.decrypt(TEA.encrypt('abc','defg'),'defg');
 * maar dit klopt wel:
 * TEA.decrypt(TEA.encrypt('abc','defgh'),'defgh');
 * TEA.decrypt(TEA.encrypt('abcd','defg'),'defg');
 */
	

//TODO: add target specific optimizations
package hxtc.crypto;
import haxe.Utf8;
import hxtc.Base64;

class TEA {
	/*
	 * encrypt text using Corrected Block TEA (xxtea) algorithm
	 *
	 * @param {string} plaintext String to be encrypted (multi-byte safe)
	 * @param {string} password  Password to be used for encryption (1st 16 chars)
	 * @returns {string} encrypted text
	 */
	public static function encrypt(plaintext:String, password:String):String {
		if (plaintext.length == 0) return '';  // nothing to encrypt
		// convert string to array of longs after converting any multi-byte chars to UTF-8
		var v = strToLongs(Utf8.encode(plaintext));
		if (v.length <= 1) v[1] = 0;  // algorithm doesn't work for n<2 so fudge by adding a null
		// simply convert first 16 chars of password as key
		var k = strToLongs(Utf8.encode(password).substr(0,16));  
		var n = v.length;
		// ---- <TEA coding> ----
		var z = v[n-1], y = v[0];
		var mx, e, q = Math.floor(6 + 52/n), sum = 0;
		while (q-- > 0) {  // 6 + 52/n operations gives between 6 & 32 mixes on each word
			sum += delta;
			e = sum>>>2 & 3;
			for (p in 0...n) {
				y = v[(p+1)%n];
				mx = (z>>>5 ^ y<<2) + (y>>>3 ^ z<<4) ^ (sum^y) + (k[p&3 ^ e] ^ z);
				z = v[p] += mx;
			}
		}
		// ---- </TEA> ----
		var ciphertext = longsToStr(v);
		return Base64.encode(ciphertext);
	}

	/*
	 * decrypt text using Corrected Block TEA (xxtea) algorithm
	 *
	 * @param {string} ciphertext String to be decrypted
	 * @param {string} password   Password to be used for decryption (1st 16 chars)
	 * @returns {string} decrypted text
	 */
	public static function decrypt(ciphertext:String, password:String):String {
		if (ciphertext.length == 0) return('');
		var v = strToLongs(Base64.decode(ciphertext));
		var k = strToLongs(Utf8.encode(password).substr(0,16)); 
		var n = v.length;
		// ---- <TEA decoding> ----
		var z = v[n-1], y = v[0];
		var mx, e, q = Math.floor(6 + 52/n), sum = q*delta;
		while (sum != 0) {
			e = sum >>> 2 & 3;
			var p = n - 1;
			while (p >= 0) {
				z = v[p>0 ? p-1 : n-1];
				mx = (z>>>5 ^ y<<2) + (y>>>3 ^ z<<4) ^ (sum^y) + (k[p&3 ^ e] ^ z);
				y = v[p] -= mx;
				p--;
			}
			sum -= delta;
		}
		// ---- </TEA> ----
		var plaintext = longsToStr(v);
		// strip trailing null chars resulting from filling 4-char blocks:
		//plaintext = plaintext.replace(/\0+$/, '');
		plaintext = ~/\0+$/.replace(plaintext, '');
		return Utf8.decode(plaintext);
	}
	//made delta a static because it never changes and it needs to be in Std.Int() in haXe in order to work
	private static var delta:Int = Std.int(2654435769);// 0x9E3779B9;
	/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */

	// supporting functions
	private static function strToLongs(s:String):Array<Int> {  // convert string to array of longs, each containing 4 chars
		// note chars must be within ISO-8859-1 (with Unicode code-point < 256) to fit 4/long
		//var l = new Array(Math.ceil(s.length/4));
		var l = [];
		for (i in 0...Math.ceil(s.length/4)) {
				// note little-endian encoding - endianness is irrelevant as long as 
				// it is the same in longsToStr() 
				l[i] = s.charCodeAt(i*4) + (s.charCodeAt(i*4+1)<<8) + 
							 (s.charCodeAt(i*4+2)<<16) + (s.charCodeAt(i*4+3)<<24);
		}
		return l;  // note running off the end of the string generates nulls since 
	}              // bitwise operators treat NaN as 0

	private static function longsToStr(l:Array<Int>):String {  // convert array of longs back to string
		var a = [];
		for (i in 0...l.length) {
			a[i] = String.fromCharCode(l[i] & 0xFF)+String.fromCharCode(l[i]>>>8 & 0xFF)+
				String.fromCharCode(l[i]>>>16 & 0xFF)+String.fromCharCode(l[i]>>>24 & 0xFF);
		}
		return a.join('');  // use Array.join() rather than repeated string appends for efficiency in IE
	}
	
}