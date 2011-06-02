/**
 * Extern classes for ECMAScript-based targets (javascript and flash).
 * Also adds inlined functions on std classes through using.
 * 
 * http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-262.pdf
 * 
 * @author Cref
 */

extern class Object<T> implements Dynamic<Dynamic>, implements ArrayAccess<Dynamic> {
	static var prototype:Object<Dynamic>;
	static var length:Int;
	static function getPrototypeOf<T>(o:T):T;
	static function getOwnPropertyDescriptor(o:Dynamic,p:String):Dynamic;
	static function getOwnPropertyNames(o:Dynamic):Dynamic;
	static function create(o:Dynamic,?properties:Dynamic):Dynamic;
	static function defineProperty(o:Dynamic,p:String,attributes:Dynamic):Dynamic;
	static function defineProperties(o:Dynamic,properties:Dynamic):Dynamic;
	static function seal(o:Dynamic):Dynamic;
	static function freeze(o:Dynamic):Dynamic;
	static function preventExtensions(o:Dynamic):Dynamic;
	static function isSealed(o:Dynamic):Bool;
	static function isFrozen(o:Dynamic):Bool;
	static function isExtensible(o:Dynamic):Bool;
	static function keys(o:Dynamic):Array<String>;

	
	function new():Void;
	var constructor:Class<T>;
	function toString():String;
	function toLocaleString():String;
	function valueOf():Dynamic;
	function hasOwnProperty(name:String):Bool;
	function isPrototypeOf(o:Dynamic):Bool;
	function propertyIsEnumerable(name:String):Bool;
	//TODO: inline iterator
}