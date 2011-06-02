/**
 * ...
 * @author Cref
 */

package hxtc;

import hxtc.ObjectHash;
import jstm.Host;

using hxtc.Tools;

class Bindable<T> {
	
	//when available, setting an initial value through the constructor is efficient because
	//this will never trigger an update since there can not be any bindings yet.
	public function new(?v:T):Void value=v

	var _listeners:ObjectHash<Void->Void>;
	public var value(default, set):T;
	
	function toString() return value+''
	function valueOf() return value
	
	function set(v:T):T {
		//only trigger an update when the value will actually be changed
		if (value != v) {
			value = v;
			_changes.add(this);
			//using a timeout ensures that bindings for more than one Bindable will not be called more than once
			_to = Host.window.setTimeout(_update, _updateResolution);
		}
		return value;
	}
	
	dynamic function _bind(fn:Void->Void) {
		//only create an ObjectHash instance when a Bindable actually has bindings, saves memory
		_listeners = new ObjectHash();
		//only create the ObjectHash instance at the first call
		_bind = __bind;
		__bind(fn);
	}
	
	function __bind(fn:Void->Void) _listeners.add(fn)
	
	function _unbind(fn) _listeners.remove(fn)
	
	static var _updateResolution = 200;
	
	static var _to:Int;
	
	static var _changes = new ObjectHash<Bindable<Dynamic>>();
	
	static function _update(){
		var changes=_changes;
		_changes=new ObjectHash();
		var uniqueListeners=new ObjectHash();
		for (b in changes){
			var bl = b._listeners;
			if (bl == null) break;
			for (l in bl) uniqueListeners.add(l);
		}
		//prevent failing listeners from blocking others
		for (l in uniqueListeners) try l() catch (e:Dynamic) Host.window.setTimeout(function() throw e, 0);
	}
	
	//TODO: change to fn instead of Bindable
	//usage:
	//using hxtc.DataBinder;
	//function(){}.bind([getDocument(123).setTitle,myStyle.setColor]);
	static function bind<T>(fn:Void->Void,fnArr:Array<Dynamic>) {
		for (b in fnArr) b._bind(fn);
		fn();
	}
	
	//public static inline function bind1 < T1 > (fn:T1->Void, b1:Bindable<T1>)
	//	bind(fn,[b1])
	/*
	static function bind<T>(fn:Dynamic,bArr:Array<Dynamic>) {
		var f = function() {
			var vArr = [];
			for (b in bArr) vArr.push(b._);
			untyped fn.apply(this,vArr);
		};
		for (b in bArr) b._bind(f);
		f();
	}
	
	//we want typed arguments and this is the only way to do this in haXe
	
	public static inline function bind1 < T1 > (fn:T1->Void, b1:Bindable<T1>)
		bind(fn,[b1])
	
	public static inline function bind2 < T1, T2 > (fn:T1->T2->Void, b1:Bindable<T1>, b2:Bindable<T2>)
		bind(fn,[b1,b2])
	
	public static inline function bind3 < T1, T2, T3 > (fn:T1->T2->T3->Void, b1:Bindable<T1>, b2:Bindable<T2>, b3:Bindable<T3>)
		bind(fn,[b1,b2,b3])
	
	public static inline function bind4 < T1, T2, T3, T4 > (fn:T1->T2->T3->T4->Void, b1:Bindable<T1>, b2:Bindable<T2>, b3:Bindable<T3>, b4:Bindable<T4>)
		bind(fn,[b1,b2,b3,b4])
	
	public static inline function bind5 < T1, T2, T3, T4, T5 > (fn:T1->T2->T3->T4->T5->Void, b1:Bindable<T1>, b2:Bindable<T2>, b3:Bindable<T3>, b4:Bindable<T4>, b5:Bindable<T5>)
		bind(fn,[b1,b2,b3,b4,b5])
	
	public static inline function bind6 < T1, T2, T3, T4, T5, T6 > (fn:T1->T2->T3->T4->T5->T6->Void, b1:Bindable<T1>, b2:Bindable<T2>, b3:Bindable<T3>, b4:Bindable<T4>, b5:Bindable<T5>, b6:Bindable<T6>)
		bind(fn,[b1,b2,b3,b4,b5,b6])
	//TODO: add more bind functions?...
	*/
}