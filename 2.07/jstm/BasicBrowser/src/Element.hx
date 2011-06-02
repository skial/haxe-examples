/**
 * ...
 * @author Cref
 */

import org.w3c.dom.Attr;
import org.w3c.dom.TypeInfo;
import org.w3c.dom.events.EventListener;

extern class Element<TDoc,TElm>
extends Node<TDoc,NodeList<TElm>,TElm>,
//implements org.w3c.dom.events.EventTarget,
implements org.w3c.dom.NodeSelector<NodeList<TElm>,TElm>,
implements org.w3c.dom.Element<TDoc,NodeList<TElm>,TElm> {
	//EventTarget
	function addEventListener(type:String, handler:EventListener<Dynamic>, capture:Bool):Void;
	function removeEventListener(type:String, handler:EventListener<Dynamic>, capture:Bool):Void;
	function dispatchEvent(event:org.w3c.dom.events.Event):Bool;
	//NodeSelector
	function querySelector(query:String):TElm;
	function querySelectorAll(query:String):NodeList<TElm>;
	//Element
  var tagName(default,never):String;
  function getAttribute(name:String):String;
  function setAttribute(name:String, value:String):Void;// raises(DOMException);
  function removeAttribute(name:String):Void;// raises(DOMException);
  function getAttributeNode(name:String):Attr;
  function setAttributeNode(newAttr:Attr):Attr;//raises(DOMException)
  function removeAttributeNode(oldAttr:Attr):Attr;//raises(DOMException)
  function getElementsByTagName(name:String):NodeList<TElm>;
  // Introduced in DOM Level 2:
  function getAttributeNS(namespaceURI:String, localName:String):Void;// raises(DOMException):String;
  // Introduced in DOM Level 2:
  function setAttributeNS(namespaceURI:String, qualifiedName:String, value:String):Void;//raises(DOMException)
  // Introduced in DOM Level 2:
  function removeAttributeNS(namespaceURI:String, localName:String):Void;//raises(DOMException)
  // Introduced in DOM Level 2:
  function getAttributeNodeNS(namespaceURI:String, localName:String):Attr;//raises(DOMException)
  // Introduced in DOM Level 2:
  function setAttributeNodeNS(newAttr:Attr):Attr;//raises(DOMException)
  // Introduced in DOM Level 2:
  function getElementsByTagNameNS(namespaceURI:String, localName:String):NodeList<TElm>;//raises(DOMException)
  // Introduced in DOM Level 2:
  function hasAttribute(name:String):Bool;
  // Introduced in DOM Level 2:
  function hasAttributeNS(namespaceURI:String, localName:String):Bool;//raises(DOMException)
  // Introduced in DOM Level 3:
  var schemaTypeInfo(default,never):TypeInfo;
  // Introduced in DOM Level 3:
  function setIdAttribute(name:String, isId:Bool):Void;//raises(DOMException)
  // Introduced in DOM Level 3:
  function setIdAttributeNS(namespaceURI:String, localName:String, isId:Bool):Void;//raises(DOMException)
  // Introduced in DOM Level 3:
  function setIdAttributeNode(idAttr:Attr, isId:Bool):Void;//raises(DOMException)
	
}