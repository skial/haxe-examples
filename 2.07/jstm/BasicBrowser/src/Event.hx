/**
 * ...
 * @author Cref
 */

extern class Event implements org.w3c.dom.events.Event {
	var type(default, null):String;
	var target(default, never):Dynamic;
	var currentTarget(default,never):Dynamic;
  var eventPhase(default, null):org.w3c.dom.events.EventPhase;
  var bubbles(default, null):Bool;
  var cancelable(default, null):Bool;
  var timeStamp(default, null):Int;//TODO: apply patch, Chrome returns a Date
  function stopPropagation():Void;// DOM.instance.stopPropagation(this)
  function preventDefault():Void;// DOM.instance.preventDefault(this)
	function initEvent(type:String, canBubble:Bool, cancelable:Bool):Void;// DOM.instance.initEvent(this, type, canBubble, cancelable)
}