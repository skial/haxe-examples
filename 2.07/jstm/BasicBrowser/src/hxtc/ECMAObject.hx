/**
 * should be renamed and placed in ECMA lib!
 * some functions for working with anonymous objects in javascript.
 * temporary class for fast translation of javascript functions to haxe.
 * should eventually be phased out.
 * 
 * @author Cref
 */

package hxtc;

class ECMAObject {
	//allows iteration of anonymous objects
	public static function forEach(o:Dynamic, f:String -> Dynamic -> Void):Void {
		untyped __js__('for (var n in o) f(n,o[n])');
	}
	public static function getFirstKey(o:Dynamic):String {
		untyped __js__('for (var n in o) break');
		return untyped n;
	}
	public static function getValue(o:Dynamic,key:String):Dynamic {
		return untyped o[key];
	}
	public static function hasField(o:Dynamic, field:String):Bool {
		return untyped __js__('field in o');
	}
	/*
	public static function iterator<T>(o:Dynamic<T>):Iterator<Null<T>> {
		return {
			hasNext:function(){},
			next:function(){}
		}
	}
	*/
}