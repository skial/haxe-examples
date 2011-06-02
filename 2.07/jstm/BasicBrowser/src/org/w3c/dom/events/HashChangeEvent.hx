/**
 * http://www.whatwg.org/specs/web-apps/current-work/#hashchangeevent
 * @author Cref
 */

package org.w3c.dom.events;

import org.w3c.dom.html.Window;

extern class HashChangeEvent extends Event {
	var oldURL(default,null):String;
	var newURL(default,null):String;
  function initHashChangeEvent(typeArg:String,canBubbleArg:Bool,cancelableArg:Bool,oldURLArg:String,newURLArg:String):Void;
}