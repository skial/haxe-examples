/**
 * TODO:
 * - decide on where to put this class and how to name it...
 * - make cross-target (it's currently a quick js port that uses some js-only code)
 * 
 * serialize and unserialize for the notation used in querystrings for instance.
 * the difference is that this serialize method loses all type info.
 * when unserializing, every value becomes a string.
 * 
 * @author Cref
 */

package hxtc.web;
import hxtc.ECMAObject;

class Data {
	public static function serialize(o:Dynamic,?seperator:String='&',?noEncoding:Bool):String{
		var arr = [];
		var pair = noEncoding
			?function(n,v:Dynamic) return n + '=' + (v == true?'1':v)
			:function(n, v) {
				return ES5.global.encodeURIComponent(n) + '=' + ((v == untyped true)?'1':ES5.global.encodeURIComponent(v));
			}
		;
		for (n in Reflect.fields(o)) {
			var v = Reflect.field(o, n);
			//TODO: decide on how to format dates
			//NOTE: '0'==false returns true!
			if (!(v==null||Std.is(v,Bool)&&v==cast false)) arr.push(pair(n,v));
		}
		return arr.join(seperator);
	}
	
	public static function unserialize(str:String,?seperator:String='&',?noEncoding:Bool):Dynamic {
		var arr=str.split(seperator);
		var r={};
		var pair = noEncoding
			?function(n, v) { Reflect.setField(r,n,v); }
			:function(n,v) { Reflect.setField(r,ES5.global.decodeURIComponent(n),ES5.global.decodeURIComponent(v)); }
		;
		for (v in arr) {
			var p=v.split('=');
			untyped pair(p.shift(),p.join('='));
		}
		return r;
	}
	
}