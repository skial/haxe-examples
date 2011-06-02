/**
 * http://www.w3.org/TR/DOM-Level-3-Events/#events-Events-Event
 * 
 * TODO: UIEvent, MouseEvent, MutationEvent etc:
 * http://www.w3.org/TR/DOM-Level-3-Events/#event-types-list
 * 
 * 
 * @author Cref
 */
package org.w3c.dom.events;

interface Event {
	var type(default, null):String;
	var currentTarget(default, null):Dynamic;
	var target(default, null):Dynamic;
  var eventPhase(default, null):EventPhase;
  var bubbles(default, null):Bool;
  var cancelable(default, null):Bool;
  var timeStamp(default, null):Int;
  function stopPropagation():Void;
  function preventDefault():Void;
	function initEvent(type:String, canBubble:Bool, cancelable:Bool):Void;
}