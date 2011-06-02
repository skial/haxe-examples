/*
 * Spec: http://www.ecma-international.org/publications/standards/Ecma-262.htm
 */
class ES5 extends Object<ES5> {
	
	
	public var undefined(getUndefined, never):Void;
	public var NaN(getNaN, never):Float;
	public var Infinity(getInfinity, never):Float;
	/*
	public function escape(s:String):String;
	public function unescape(s:String):String;
	public function encodeURI(s:String):String;
	public function encodeURIComponent(s:String):String;
	public function decodeURI(s:String):String;
	public function decodeURIComponent(s:String):String;
	
	public function isFinite(x:Dynamic):Bool;
	public function isNaN(x:Dynamic):Bool;
	
	//differences with Std.parseFloat: returns NaN instead of null when parsing failed (NaN IS a Number)
	public function parseFloat(x:Dynamic):Float;
	
	//differences with Std.parseInt: has radix argument and returns NaN instead of null when parsing failed (NaN IS a Number)
	public function parseInt(x:Dynamic, ?radix:Int):Int;
	
	//not available in Flash and JScript.NET but it is part of the ECMAScript standard
	//for more info, see ECMAScript Compact Profile (http://www.ecma-international.org/publications/files/ECMA-ST/Ecma-327.pdf)
	//so should throw an EvalError
	public function eval(s:String):Dynamic;
	*/
	
	
	#if js
	
	public static inline var global:ES5=untyped jstm.Runtime.global;//TODO: test 
	public static inline var arguments:Arguments<Dynamic> = untyped __js__("arguments");
	
	//keywords
	public static inline function typeof(o:Dynamic):String return untyped __js__("typeof")(o)
	public static inline function instanceof(o:Dynamic,c:Class<Dynamic>):Bool return _instanceof(o,c)
	static function _instanceof(o:Dynamic, c:Class<Dynamic>):Bool return untyped __js__("o instanceof c")
	//Object helper functions
	public static inline function set(o:Dynamic,key:String, value:Dynamic):Void untyped o[key] = value
	public static inline function get(o:Dynamic,key:String):Dynamic return untyped o[key]
	public static inline function delete(pointer:Dynamic):Bool return untyped __js__("delete")(pointer)
	//Object for loop functions. These belong here but since jstm.Runtime needs them we define them there
	public static inline function has(o:Dynamic,n:String):Bool return untyped jstm.Runtime.has(o,n)
	public static inline function forEach(o:Dynamic, f:String->(Void->Void)->Void):Void untyped jstm.Runtime.forEach(o,f)
	public static inline function first(o:Dynamic):String return untyped jstm.Runtime.first(o)
	//like Reflect.fields but more basic
	public static function getKeys(o:Dynamic):Array<String> {
		var a = [];
		untyped __js__("for (var k in o) a.push(k)");
		return a;
	}
	//getters
	private inline function getUndefined():Void return untyped __js__("undefined")
	private inline function getNaN():Float return untyped __js__("NaN")
	private inline function getInfinity():Float return untyped __js__("Infinity")
	
	public inline function escape(s:String):String return untyped __js__("escape")(s)
	public inline function unescape(s:String):String return untyped __js__("unescape")(s)
	public inline function encodeURI(s:String):String return untyped __js__("encodeURI")(s)
	public inline function encodeURIComponent(s:String):String return untyped __js__("encodeURIComponent")(s)
	public inline function decodeURI(s:String):String return untyped __js__("decodeURI")(s)
	public inline function decodeURIComponent(s:String):String return untyped __js__("decodeURIComponent")(s)
	
	public inline function isFinite(x:Dynamic):Bool return untyped __js__("isFinite")(x)
	public inline function isNaN(x:Dynamic):Bool return untyped __js__("isNaN")(x)
	
	public inline function parseFloat(x:Dynamic):Float return untyped __js__("parseFloat")(x)
	public inline function parseInt(x:Dynamic, ?radix:Int):Int return untyped __js__("parseInt")(x,radix)
	
	public inline function eval(s:String):Dynamic return untyped __js__("eval")(s)
	
	#elseif flash
	
	public static inline var global:ECMAScript=untyped __global__;//not tested
	public static inline var arguments = untyped __arguments__;
	
	private inline function getUndefined():Void return untyped __global__("undefined")
	private inline function getNaN():Float return untyped __global__("NaN")
	private inline function getInfinity():Float return untyped __global__("Infinity")
	
	public inline function escape(s:String):String return untyped __global__("escape")(s)
	public inline function unescape(s:String):String return untyped __global__("unescape")(s)
	public inline function encodeURI(s:String):String return untyped __global__("encodeURI")(s)
	public inline function encodeURIComponent(s:String):String return untyped __global__("encodeURIComponent")(s)
	public inline function decodeURI(s:String):String return untyped __global__("decodeURI")(s)
	public inline function decodeURIComponent(s:String):String return untyped __global__("decodeURIComponent")(s)
	
	public inline function isFinite(x:Dynamic):Bool return untyped __global__("isFinite")(x)
	public inline function isNaN(x:Dynamic):Bool return untyped __global__("isNaN")(x)
	
	public inline function parseFloat(x:Dynamic):Float return untyped __global__("parseFloat")(x)
	public inline function parseInt(x:Dynamic, ?radix:Int):Int return untyped __global__("parseInt")(x,radix)
	
	public inline function eval(s:String):Dynamic return untyped __global__("eval")(s)//not tested. if Flash doesn't have this native function, do: throw new EvalError('not supported')
	
	#end
	
	//native object functions
	#if (js || flash)
	//Date
	public static inline function toGMTString(date:Date):String return untyped date.toGMTString()
	public static inline function getUTCFullYear(date:Date):Int return untyped date.getUTCFullYear()
	public static inline function getUTCMonth(date:Date):Int return untyped date.getUTCMonth()
	public static inline function getUTCDate(date:Date):Int return untyped date.getUTCDate()
	public static inline function getUTCHours(date:Date):Int return untyped date.getUTCHours()
	public static inline function getUTCMinutes(date:Date):Int return untyped date.getUTCMinutes()
	public static inline function getUTCSeconds(date:Date):Int return untyped date.getUTCFullYear()
	public static inline function getUTCMilliseconds(date:Date):Int return untyped date.getUTCMilliseconds()
	public static inline function getTimezoneOffset(date:Date):Int return untyped date.getTimezoneOffset()
	//Number
	public static inline function toString(n:Int,?radix:Int):String return untyped n.toString(radix)
	//TODO: implement radix on other targets, see StringTools.hex for inspiration, also:
	// http://stackoverflow.com/questions/57803/how-to-convert-decimal-to-hex-in-javascript
	// http://haxe.org/forum/thread/1997
	#end
	//String
	public static inline function match(s:String, r:RegExp) return untyped s.match(r)
	//TODO: use multitype metadata (RegExp/String) once it is available also for functions that need more than one argument
	public static inline function replace(s:String, r:RegExp, ?by:String=''):String return untyped s.replace(r,by)
	public static inline function stringFromCharCodes(arr:Array<Int> ) : String return untyped String.fromCharCode.apply(String, cast arr)
	//Class
	public static inline function getPrototype<T>(c:Class<T>):T return c.prototype
}
