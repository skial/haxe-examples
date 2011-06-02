/**
 * Create proxy instances that transfer it's function results to a callback.
 * 
 * advantages over haxe.remoting.Proxy:
 * - supports inheritance
 * - no need to write a proxy class for each class
 * - both sync and async calls are available on any instance (when supported)
 * 
 * @author Cref
 */

package hxtc;
import jstm.Host;

class Proxy<T> {
	
	function new(cls:Class<T>, fn:String, args:Array<Dynamic>, resolver:Resolver<T>):Void {
		this.fn = fn;
		this.args = args;
		this.resolver = resolver;
	}
	
	var fn:String;
	var args:Array<Dynamic>;
	var resolver:Resolver<T>;
	
	function exec(callbck:T->Void,async:Bool,serializedMode:Bool,cacheMsec:Float):Void resolver(fn,args,callbck,async,serializedMode,cacheMsec)
	
	public static function create<T>(cls:Class<T>,resolver:Resolver<T>):T {
		//TODO: integrate with type builder and dynamically build a virtual class for each superclass so we get:
		//class my.ServerClass_Proxy extends my.BaseServerClass_Proxy, implements my.ServerClass { }
		var r = Type.createEmptyInstance(cls);
		var methods:Array<String> = [];
			//TODO: patch Type.getInstanceFields!
		untyped __js__("for (var n in r) {var f=r[n];if (n!='__class__'&&n!='constructor'&&typeof f=='function') methods.push(n)}");
		for (n in methods) Reflect.setField(r, n, function() {
			var args:Array<Dynamic> = cast ES5.arguments,a=[];
			for (v in args) a.push(v);
			return new Proxy(cls,n,a,resolver);
		});
		return r;
	}
	
	static function getProxyCaller<T>(cls:Class<T>,resolver:Resolver<T>,n:String) {
		return function() {
			var args:Array<Dynamic> = cast ES5.arguments,a=[];
			for (v in args) a.push(v);
			return new Proxy(cls,n,a,resolver);
		}
	}
	
	//resolves the return value and runs the callback
	//default communication behaviour will be used when forceSync is not set.
	//on a browser, this will be asynchronous and on ASP this will be synchronous.
	//default mode is JSON
	//TODO: fully support serialization, currently only works with strings
	public static function use<T>(proxyResult:T, ?callbck:T->Void,?forceSync:Bool,?serializedMode:Bool,?cacheMsec:Float) {
		Std.is(proxyResult, Proxy)
			?untyped proxyResult.exec(callbck == null?function(){}:callbck, forceSync, serializedMode,cacheMsec)
			:callbck == null
				?null
				:forceSync
					?callbck(proxyResult)
					:Host.window.setTimeout(function() callbck(proxyResult), 0)//consistently use async
		;
	}
	
}

typedef Resolver<T> = String->Array<Dynamic>->(T->Void)->Bool->Bool->Float->Void;
