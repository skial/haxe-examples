/*
 * Copyright (c) 2005, The haXe Project Contributors
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE HAXE PROJECT CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE HAXE PROJECT CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */
/**
 * This class replaces the standard haXe Std class.
 * Unfortunately, this class can not be overridden without breaking macro's
 * so that's why we use the type accessor in the generator to use this class instead.
 * 
 * Patches:
 * - moved __interfLoop from js.Boot to Std
 * - moved __instanceof from js.Boot to Std and renamed to is
 * - moved __string_rec from js.Boot to Std
 * - only use __string_rec in debug mode
 * - made parseFloat inline
 * - moved __init__ to jstm.Runtime
 * - 
 */

class Std__ {
	
	public static function string( s : Dynamic ) : String {
		#if debug
		//__string_rec moved from js.Boot to Std and only used when debug is active
		return __string_rec(s, "");
		#else
		return s + '';
		#end
	}

	public static function int( x : Float ) : Int {
		return x<0?Math.ceil(x):Math.floor(x);
	}

	public static function parseInt( x : String ) : Null<Int> {
		var v = ES5.global.parseInt(x, 10);
		// parse again if hexadecimal
		if( v == 0 && x.charCodeAt(1) == 'x'.code )
			v = ES5.global.parseInt(x);
		if( ES5.global.isNaN(v) )
			return null;
		return cast v;
	}

	//inline reduces download but since we can't overwrite the Std class, this has no effect yet
	public static inline function parseFloat( x : String ) : Float {
		return ES5.global.parseFloat(x);
	}

	public static function random( x : Int ) : Int {
		return Math.floor(Math.random()*x);
	}

	/* moved to jstm.Runtime
	static function __init__() : Void untyped {
		String.prototype.__class__ = String;
		String.__name__ = ["String"];
		Array.prototype.__class__ = Array;
		Array.__name__ = ["Array"];
		Int = { __name__ : ["Int"] };
		Dynamic = { __name__ : ["Dynamic"] };
		Float = __js__("Number");
		Float.__name__ = ["Float"];
		Bool = { __ename__ : ["Bool"] };
		Class = { __name__ : ["Class"] };
		Enum = {};
		Void = { __ename__ : ["Void"] };
	}
	*/

	
	/**
	 * All functions under this comment came from js.Boot:
	 */
	#if debug
	private static function __string_rec(o:Dynamic,s:String):String {
		untyped {
			if( o == null )
			    return "null";
			if( s.length >= 5 )
				return "<...>"; // too much deep recursion
			var t = __js__("typeof(o)");
			if( t == "function" && (o.__name__ != null || o.__ename__ != null) )
				t = "object";
			switch( t ) {
			case "object":
				if( __js__("o instanceof Array") ) {
					if( o.__enum__ != null ) {
						if( o.length == 2 )
							return o[0];
						var str = o[0]+"(";
						s += "\t";
						for( i in 2...o.length ) {
							if( i != 2 )
								str += "," + __string_rec(o[i],s);
							else
								str += __string_rec(o[i],s);
						}
						return str + ")";
					}
					var l = o.length;
					var i;
					var str = "[";
					s += "\t";
					for( i in 0...l )
						str += (if (i > 0) "," else "")+__string_rec(o[i],s);
					str += "]";
					return str;
				}
				var tostr;
				try {
					tostr = untyped o.toString;
				} catch( e : Dynamic ) {
					// strange error on IE
					return "???";
				}
				if( tostr != null && tostr != __js__("Object.toString") ) {
					var s2 = o.toString();
					if( s2 != "[object Object]")
						return s2;
				}
				var k : String = null;
				var str = "{\n";
				s += "\t";
				var hasp = (o.hasOwnProperty != null);
				__js__("for( var k in o ) { ");
					if( hasp && !o.hasOwnProperty(k) )
						__js__("continue");
					if( k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" )
						__js__("continue");
					if( str.length != 2 )
						str += ", \n";
					str += s + k + " : "+__string_rec(o[k],s);
				__js__("}");
				s = s.substring(1);
				str += "\n" + s + "}";
				return str;
			case "function":
				return "<function>";
			case "string":
				return o;
			default:
				return String(o);
			}
		}
	}
	#end
	
	private static function __interfLoop(cc : Dynamic,cl : Dynamic) {
		if( cc == null )
			return false;
		if( cc == cl )
			return true;
		var intf : Dynamic = cc.__interfaces__;
		if( intf != null )
			for( i in 0...intf.length ) {
				var i : Dynamic = intf[i];
				if( i == cl || __interfLoop(i,cl) )
					return true;
			}
		return __interfLoop(cc.__super__,cl);
	}

	//private static function __instanceof(o : Dynamic,cl) {
	//renamed to is
	public static function is(o : Dynamic,cl:Dynamic) {
		untyped {
			try {
				if( __js__("o instanceof cl") ) {
					if( cl == Array )
						return (o.__enum__ == null);
					return true;
				}
				if( __interfLoop(o.__class__,cl) )
					return true;
			} catch( e : Dynamic ) {
				if( cl == null )
					return false;
			}
			switch( cl ) {
			case Int:
				return __js__("Math.ceil(o%2147483648.0) === o");
			case Float:
				return __js__("typeof(o)") == "number";
			case Bool:
				return __js__("o === true || o === false");
			case String:
				return __js__("typeof(o)") == "string";
			case Dynamic:
				return true;
			default:
				if( o == null )
					return false;
				return o.__enum__ == cl || ( cl == Class && o.__name__ != null ) || ( cl == Enum && o.__ename__ != null );
			}
		}
	}
	
}
