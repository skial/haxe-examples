/**
 * ...
 * @author Cref
 */

package org.w3c.dom;

interface NamedNodeMap<T:Node<T,Dynamic,Dynamic>> {
  function getNamedItem(name:String):T;
  function setNamedItem(arg:T):T;//raises(DOMException);
  function removeNamedItem(name:String):T;//raises(DOMException);
  function item(index:Int):T;
  var length(default,null):Int;
  // Introduced in DOM Level 2:
  function getNamedItemNS(namespaceURI:String, localName:String):T;// raises(DOMException);
  // Introduced in DOM Level 2:
  function setNamedItemNS(arg:T):T;// raises(DOMException);
  // Introduced in DOM Level 2:
  function removeNamedItemNS(namespaceURI:String, localName:String):T;// raises(DOMException);
}