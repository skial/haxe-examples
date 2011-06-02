/**
 * ...
 * @author Cref
 */

package org.w3c.dom.events;

extern class KeyboardEvent extends UIEvent {
  public static inline var DOM_KEY_LOCATION_STANDARD      = 0;
  public static inline var DOM_KEY_LOCATION_LEFT          = 1;
  public static inline var DOM_KEY_LOCATION_RIGHT         = 2;
  public static inline var DOM_KEY_LOCATION_NUMPAD        = 3;
  public static inline var DOM_KEY_LOCATION_MOBILE        = 4;
  public static inline var DOM_KEY_LOCATION_JOYSTICK      = 5;
	public var keyIdentifier(default,null):String;
  public var keyLocation(default,null):Int;
  public var ctrlKey(default,null):Bool;
  public var shiftKey(default,null):Bool;
  public var altKey(default,null):Bool;
  public var metaKey(default,null):Bool;
  public var repeat(default, null):Bool;
	
  public function initKeyboardEvent(typeArg:String, 
                                canBubbleArg:Bool, 
                                cancelableArg:Bool, 
                                viewArg:Void,//TODO: views.AbstractView, 
																keyIdentifierArg:String, 
																keyLocationArg:Int, 
																modifiersListArg:String,
																repeat:Bool):Void;
  // Introduced in DOM Level 3:
  public function getModifierState(keyIdentifierArg:String):Bool;
  // Introduced in DOM Level 3:
  public function initKeyboardEventNS(namespaceURIArg:String, 
                                  typeArg:String, 
                                  canBubbleArg:Bool, 
                                  cancelableArg:Bool, 
                                  viewArg:Void, //TODO: views::AbstractView
																	keyIdentifierArg:String, 
																	keyLocationArg:Int, 
																	modifiersListArg:String,
																	repeat:Bool):Void;
}