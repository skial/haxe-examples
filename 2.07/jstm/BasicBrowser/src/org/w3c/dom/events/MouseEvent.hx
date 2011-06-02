/**
 * http://www.w3.org/TR/DOM-Level-3-Events/#events-Events-MouseEvent
 * @author Cref
 */

package org.w3c.dom.events;

extern class MouseEvent extends UIEvent {
	public static inline var CLICK = 'click';
  public var screenX(default,null):Int;
  public var screenY(default,null):Int;
  public var clientX(default,null):Int;
  public var clientY(default,null):Int;
  public var ctrlKey(default,null):Bool;
  public var shiftKey(default,null):Bool;
  public var altKey(default,null):Bool;
  public var metaKey(default,null):Bool;
  public var button(default, null):Int;
	public var relatedTarget(default, null):Dynamic;// EventTarget;
  public function initMouseEvent(typeArg:String, 
                                canBubbleArg:Bool, 
                                cancelableArg:Bool, 
                                viewArg:Void,//TODO: views.AbstractView, 
                                detailArg:Int, 
                                screenXArg:Int, 
                                screenYArg:Int, 
                                clientXArg:Int, 
                                clientYArg:Int, 
                                ctrlKeyArg:Bool, 
                                altKeyArg:Bool, 
                                shiftKeyArg:Bool, 
                                metaKeyArg:Bool, 
                                buttonArg:Int, 
                                relatedTargetArg:Dynamic):Void;
  // Introduced in DOM Level 3:
  public function getModifierState(keyIdentifierArg:String):Bool;
  // Introduced in DOM Level 3:
  public function initMouseEventNS<T>(namespaceURIArg:String, 
                                  typeArg:String, 
                                  canBubbleArg:Bool, 
                                  cancelableArg:Bool, 
                                  viewArg:Void, //TODO: views::AbstractView
                                  detailArg:Int, 
                                  screenXArg:Int, 
                                  screenYArg:Int, 
                                  clientXArg:Int, 
                                  clientYArg:Int, 
                                  buttonArg:Int, 
                                  relatedTargetArg:Dynamic, 
                                  modifiersListArg:String):Void;
}