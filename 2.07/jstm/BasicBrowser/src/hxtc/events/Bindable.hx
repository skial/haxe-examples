/**
 * ...
 * @author Cref
 */

package hxtc.events;

import js.browser.Browser;
import hxtc.events.EventListener;

using hxtc.Tools;
using hxtc.events.EventListener;

class Bindable<T> {
	var _:T;
	public function new():Void;
	dynamic function getEvent():org.w3c.dom.events.Event {
		var e = cast Browser.window.document.createEvent('Event');
		e.initEvent(getInstanceId() + 'change', false, true);
		getEvent = function() return e;
		return e;
	}
	public function set(v:T):T {
		if (_ != v) {
			_ = v;
			js.browser.Browser.window.dispatchEvent(event);
		}
		return _;
	}
	public function bind(f:T->Void):EventListener {
		var t = this;
		return Browser.window.on(getInstanceId()+'change', function(e) f(t._));
	}
}