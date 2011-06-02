/**
 * ...
 * @author Cref
 */

//http://www.w3.org/TR/2007/WD-DOM-Level-3-Events-20071221/events.html#Events-KeyboardEvent
extern class KeyboardEvent extends UIEvent {
  public static inline var DOM_KEY_LOCATION_STANDARD      = 0x00;
  public static inline var DOM_KEY_LOCATION_LEFT          = 0x01;
  public static inline var DOM_KEY_LOCATION_RIGHT         = 0x02;
  public static inline var DOM_KEY_LOCATION_NUMPAD        = 0x03;
  public static inline var DOM_KEY_LOCATION_MOBILE        = 0x04;
  public static inline var DOM_KEY_LOCATION_JOYSTICK      = 0x05;
	
	//official standard
	public var keyIdentifier(default, null):String;
	//de facto standard (will be removed as soon as soon as we have full support for keyIdentifier)
  public var keyCode(default, null):Int;
	
  public var keyLocation(default,null):Int;
  public var ctrlKey(default,null):Bool;
  public var shiftKey(default,null):Bool;
  public var altKey(default,null):Bool;
  public var metaKey(default, null):Bool;
	//don't know why these were here:
  //public var repeat(default, null):Bool;
	//public var relatedTarget(default, null):T;
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