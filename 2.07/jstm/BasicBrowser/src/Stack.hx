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
/*
 * Adapted to support js_split callStack and exceptionStack
 * that are more efficient and correctly handle multi-threading.
 * 
 * Only added for compatibility, hxtc offers more advanced stack options.
 */
package haxe;

/**
	Elements return by [Stack] methods.
**/
enum StackItem {
	CFunction;
	Module( m : String );
	FilePos( s : Null<StackItem>, file : String, line : Int );
	Method( classname : String, method : String );
	Lambda( v : Int );
}

/**
	Get informations about the call stack.
**/
class Stack {

	/**
		Return the call stack elements.
	**/
	public static function callStack() : Array<StackItem> {
		#if js_split
		//might not always have exactly the same result as std js but it sure does the job
		//TODO: add Lambda calls
		var a = [];
		var caller = org.ecmascript.Function.arguments.callee.caller.caller;
		while (untyped caller) {
			//TODO: don't use __name__ anymore, we don't need it as an Array
			if (untyped caller.name) a.push(Method(untyped caller.cls.__name__.join('.'),untyped caller.name));
			caller = caller.caller;
		}
		return a;
		#else
		#if neko
			var a = makeStack(untyped __dollar__callstack());
			a.shift(); // remove Stack.callStack()
			return a;
		#elseif flash9
			var a = makeStack( new flash.Error().getStackTrace() );
			a.shift(); // remove Stack.callstack()
			return a;
		#elseif (flash || js)
			return makeStack("$s");
		#elseif php
			return makeStack("%s");
		#else
			return [];
		#end
		#end
	}

	/**
		Return the exception stack : this is the stack elements between
		the place the last exception was thrown and the place it was
		catched.
	**/
	#if js_split
	public static inline function exceptionStack() : Array<StackItem> {
		//should only be called from within a catch clause
		//haXe always defines the current exception as e.
		//TODO: nicely handle wrong usage
		return buildExStack(untyped e);
	}
	private static function buildExStack(e:Dynamic) : Array<StackItem> {
		var sa:Array<org.ecmascript.Arguments<Dynamic>> = e.exStack==null?untyped js.Boot.mainExStack:e.exStack;
		if (sa == null) return [];
		var a = [];
		for (s in sa) a.push(Method(untyped s.fn.cls.__name__.join('.'), untyped s.fn._name));
		return a;
	}
	#else
	public static function exceptionStack() : Array<StackItem> {
		#if neko
			return makeStack(untyped __dollar__excstack());
		#elseif as3
			return new Array();
		#elseif flash9
			var err : flash.Error = untyped flash.Boot.lastError;
			if( err == null ) return new Array();
			var a = makeStack( err.getStackTrace() );
			var c = callStack();
			var i = c.length - 1;
			while( i > 0 ) {
				if( Std.string(a[a.length-1]) == Std.string(c[i]) )
					a.pop();
				else
					break;
				i--;
			}
			return a;
		#elseif (flash || js)
			return makeStack("$e");
		#elseif php
			return makeStack("%e");
		#else
			return [];
		#end
	}

	private static function makeStack(s) {
		#if neko
			var a = new Array();
			var l = untyped __dollar__asize(s);
			var i = 0;
			while( i < l ) {
				var x = s[i++];
				if( x == null )
					a.unshift(CFunction);
				else if( untyped __dollar__typeof(x) == __dollar__tstring )
					a.unshift(Module(new String(x)));
				else
					a.unshift(FilePos(null,new String(untyped x[0]),untyped x[1]));
			}
			return a;
		#elseif flash9
			var a = new Array();
			var r = ~/at ([^\/]+?)\$?(\/[^\(]+)?\(\)(\[(.*?):([0-9]+)\])?/;
			var rlambda = ~/^MethodInfo-([0-9]+)$/g;
			while( r.match(s) ) {
				var cl = r.matched(1).split("::").join(".");
				var meth = r.matched(2);
				var item;
				if( meth == null ) {
					if( rlambda.match(cl) )
						item = Lambda(Std.parseInt(rlambda.matched(1)));
					else
						item = Method(cl,"new");
				} else
					item = Method(cl,meth.substr(1));
				if( r.matched(3) != null )
					item = FilePos( item, r.matched(4), Std.parseInt(r.matched(5)) );
				a.push(item);
				s = r.matchedRight();
			}
			return a;
		#elseif (flash || js)
			var a : Array<String> = untyped #if flash __eval__(s) #else try __js__("eval")(s) catch( e : Dynamic ) [] #end;
			var m = new Array();
			for( i in 0...a.length - if(s == "$s") 2 else 0 ) {
				var d = a[i].split("::");
				m.unshift(Method(d[0],d[1]));
			}
			return m;
		#elseif php
			if (!untyped __call__("isset", __var__("GLOBALS", s)))
				return [];
			var a : Array<String> = untyped __var__("GLOBALS", s);
			var m = [];
			for( i in 0...a.length - ((s == "%s") ? 2 : 0)) {
				var d = a[i].split("::");
				m.unshift(Method(d[0],d[1]));
			}
			return m;
		#else
			return null;
		#end
	}
	#end

	/**
		Returns a representation of the stack as a printable string.
	**/
	public static function toString( stack : Array<StackItem> ) {
		var b = new StringBuf();
		for( s in stack ) {
			b.add("\nCalled from ");
			itemToString(b,s);
		}
		return b.toString();
	}

	private static function itemToString( b : StringBuf, s ) {
		switch( s ) {
		case CFunction:
			b.add("a C function");
		case Module(m):
			b.add("module ");
			b.add(m);
		case FilePos(s,file,line):
			if( s != null ) {
				itemToString(b,s);
				b.add(" (");
			}
			b.add(file);
			b.add(" line ");
			b.add(line);
			if( s != null ) b.add(")");
		case Method(cname,meth):
			b.add(cname);
			b.add(".");
			b.add(meth);
		case Lambda(n):
			b.add("local function #");
			b.add(n);
		}
	}

}
