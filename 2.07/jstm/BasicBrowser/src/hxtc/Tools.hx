/**
 * UUID:
 * http://www.broofa.com/2008/09/javascript-uuid-function/
 * http://davidbau.com/archives/2010/01/30/random_seeds_coded_hints_and_quintillions.html
 * http://blogs.cozi.com/tech/2010/04/generating-uuids-in-javascript.html
 * 
 * @author Cref
 */

package hxtc;

using StringTools;
using hxtc.use.ForString;

class Tools {
	
	public static function ext<T>(o1:T, o2:Dynamic):T {
		untyped __js__("for (var n in o2) o1[n]=o2[n]");
		return o1;
	}
	
	//overwrites a method.
	//might in the future return an object with an undo method.
	public static function patch<T>(closure:T, fn:T->T) {
		untyped closure.scope[closure._name] = fn(closure);
	}
	
	static function bind<T>(fn:T->Void,get:Void->T):hxtc.events.EventListener {
		//TODO: wrap getter if not yet wrapped by binder that adds an eventListener which repeats this function call
		//TODO: dispatch change event when value changes, example: in mySetter: notify(myGetter), do this on first call to getter
		fn(get());
		return null;
	}
	
	//TODO: same as above
	static inline function bind2 < T0, T1 > (fn:T0->T1->Void,get1:Void->T0, get2:Void->T1):hxtc.events.EventListener {
		//TODO: call bind with arguments
		return null;
	}
	
	/*
	 * useful generic error handling.
	 * the main goal is to show useful information when something other then an exception was thrown in ASP.
	 * usage:
	 * public static function main() hxtc.Tools.tryThis(function(){
	 * 	...
	 * })
	 * 
	 * TODO: move to final location
	 */
	public static inline function tryThis(fnc:Void -> Void) {
		#if debug
		try {
			(fnc)();
		}
		catch (e:Dynamic) {
			trace('Exception: '+(e.message||e.description||e)+haxe.Stack.toString(haxe.Stack.exceptionStack()));
			//trigger redirect so ASP server error details can be read
			throw e;
		}
		#else
		(fnc)();
		#end
	}
	
	//random seed so that it is less likely someone will mistakenly rely on these id's outside the runtime scope
	private static var idSeed = Std.random(100);
	//sets the id to a globally unique Int for runtime identification purposes
	public static function getInstanceId(?o:Dynamic/*Identifiable*/):Int {
		return o == null
			?idSeed++
			:o.__id == null
				?o.__id = idSeed++
				:o.__id
		;
	}

	#if jscript
	public static function getGUID():String return new activex.scriptlet.TypeLib().guid.after('{').before('}').replace('-', '')
	#end
}

private typedef Identifiable = {
	private var __id:Int;
}