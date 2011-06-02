/**
 * ...
 * @author Cref
 */

package hxtc.events;

import org.w3c.dom.events.EventTarget;

class EventListener {
	
	var obj:EventTarget;
	var type:String;
	var fn:Dynamic->Void;
	var capture:Bool;
	
	function new(obj:EventTarget,type:String,fn:Dynamic->Void,autoEnable:Bool) {
		this.obj = obj;
		this.type = type;
		this.fn = fn;
		if (autoEnable) enable();
	}
	
	public function enable():EventListener {
		obj.addEventListener(type, fn, capture);
		return this;
	}
	
	public function disable():EventListener {
		obj.removeEventListener(type, fn, capture);
		return this;
	}
	
	//shortcut for working with event listeners (bubble phase only)
	//not only is it shorter, it also returns the element so we can use method chaining
	//TODO: HTMLElement<Dynamic> should be EventTarget typedef, need to move fix IE event model on another level first
	public static function on(obj:EventTarget, type:String, fn:Dynamic->Void, autoEnable = true):EventListener {
		//TODO: IE patch
		//if (!obj.addEventListener && ie<8) patch(obj);
		return new EventListener(obj, type, fn, autoEnable);
	}

	public static function once(obj:EventTarget, type:String, fn:Dynamic->Void, autoEnable = true):EventListener {
		//TODO: IE patch
		//if (!obj.addEventListener && ie<8) patch(obj);
		var l:EventListener = null;
		l=on(obj, type, function(e) {
			l.disable();
			fn(e);
		}, autoEnable);
		return l;
	}
	
}