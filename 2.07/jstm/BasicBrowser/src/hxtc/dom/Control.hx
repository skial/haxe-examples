/**
 * EventDispatcher for dom targets.
 * Wraps an element so that REAL events can be used.
 * 
 * When a class extends this class it can dispatch events.
 * 
 * @author Cref
 */

package hxtc.dom;
import jstm.Host;

class Control
//implements org.w3c.dom.events.EventTarget
{
	
	private var doc(default, null):HTMLDocument;
	//tbv debugging effe public
	public var element(default,null):HTMLElement;
	
	private function new(?d:HTMLDocument,tagName:String='ctrl') {
		doc = d==null?Host.window.document:d;
		if (element==null) element = doc.createElement(tagName);
		untyped element.ctrl = this;
	}
	
	public function dispatchEvent(event:org.w3c.dom.events.Event):Bool return element.dispatchEvent(event)
	public function addEventListener(type:String, listener:Dynamic->Void, capture:Bool):Void element.addEventListener(type, listener,capture)
	public function removeEventListener(type:String, listener:Dynamic->Void, capture:Bool):Void element.removeEventListener(type, listener,capture)
	
	//private static var events:Hash<ControlEvent> = new Hash();
	
	//for easy private event dispatching
	private function dispatch(type:String) {
		//assuming it doesn't make a difference which document instance created the event
		//NOTE: not meant for dispatching native events (like click), maybe later...
		//if (!events.exists(type)) {
			var e = doc.createEvent('Event');
			e.initEvent(type,false,false);
			//events.set(type,cast e);
		//}
		dispatchEvent(cast e);
		//dispatchEvent(cast events.get(type));
	}
}