/*
 * http://www.w3.org/TR/DOM-Level-3-Events/#interface-EventTarget
 * 
 * Note:
 * flash.events.IEventDispatcher should implement w3c.EventTarget
 * http://haxe.org/api/flash9/events/ieventdispatcher
 */
package org.w3c.dom.events;

//native DOM events
typedef EventTarget = {
	function addEventListener(type:String, handler:EventListener<Dynamic>, capture:Bool):Void;
	function removeEventListener(type:String, handler:EventListener<Dynamic>, capture:Bool):Void;
	function dispatchEvent(event:Event):Bool;
}