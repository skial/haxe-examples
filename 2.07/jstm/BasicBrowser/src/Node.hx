/**
 * ...
 * @author Cref
 */

import org.w3c.dom.NodeType;
//import org.w3c.dom.NodeList;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Document;
import org.w3c.dom.DocumentPosition;
import org.w3c.dom.DOMObject;
import org.w3c.dom.DOMUserData;
import org.w3c.dom.UserDataHandler;

extern class Node<TDoc,TNodeList,TNode> extends Object<TNode>, implements org.w3c.dom.Node<TDoc,TNodeList,TNode> {
	
  var nodeName(default,never):String;
	var nodeValue:String;// raises(DOMException) on setting, raises(DOMException) on retrieval
  var nodeType(default,never):NodeType;
  var parentNode(default,never):TNode;
  var childNodes(default,never):TNodeList;
  var firstChild(default,never):TNode;
  var lastChild(default,never):TNode;
  var previousSibling(default,never):TNode;
  var nextSibling(default,never):TNode;
  var attributes(default, never):NamedNodeMap<Dynamic>;
  // Modified in DOM Level 2:
  var ownerDocument(default,never):TDoc;
  // Modified in DOM Level 3:
  function insertBefore(newChild:TNode, refChild:TNode):TNode;//raises(DOMException);
  // Modified in DOM Level 3:
  function replaceChild(newChild:TNode, oldChild:TNode):TNode;//raises(DOMException);
  // Modified in DOM Level 3:
  function removeChild(oldChild:TNode):TNode;//raises(DOMException);
  // Modified in DOM Level 3:
  function appendChild<TNode>(newChild:TNode):TNode;//raises(DOMException);
  function hasChildNodes():Bool;
  function cloneNode(deep:Bool):TNode;
  // Modified in DOM Level 3:
  function normalize():Void;
  // Introduced in DOM Level 2:
  function isSupported(feature:String, version:String):Bool;
  // Introduced in DOM Level 2:
  var namespaceURI(default, never):String;
  // Introduced in DOM Level 2:
  var prefix:String;// raises(DOMException) on setting
  // Introduced in DOM Level 2:
  var localName:String;
  // Introduced in DOM Level 2:
  function hasAttributes():Bool;
  // Introduced in DOM Level 3:
  var baseURI(default, never):String;
  // Introduced in DOM Level 3:
  function compareDocumentPosition(other:TNode):DocumentPosition;//raises(DOMException);
  // Introduced in DOM Level 3:
	var textContent:String;// raises(DOMException) on setting, raises(DOMException) on retrieval
  // Introduced in DOM Level 3:
  function isSameNode(other:TNode):Bool;
  // Introduced in DOM Level 3:
  function lookupPrefix(namespaceURI:String):String;
  // Introduced in DOM Level 3:
  function isDefaultNamespace(namespaceURI:String):Bool;
  // Introduced in DOM Level 3:
  function lookupNamespaceURI(prefix:String):String;
  // Introduced in DOM Level 3:
  function isEqualNode(arg:TNode):Bool;
  // Introduced in DOM Level 3:
  function getFeature(feature:String, version:String):DOMObject;
  // Introduced in DOM Level 3:
	function setUserData(key:String, data:DOMUserData, handler:UserDataHandler<TNode>):DOMUserData;
  // Introduced in DOM Level 3:
	function getUserData(key:String):DOMUserData;
	
}