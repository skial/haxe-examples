/**
 * http://www.w3.org/TR/DOM-Level-3-Core/core.html#i-Document
 * @author Cref
 */

package org.w3c.dom;

interface Document<TDoc,TNodeList,TElm> implements Node<TDoc,TNodeList,TElm> {
	
	var documentElement(default,never):TElm;
	function createTextNode(data:String):Text;
	function getElementsByTagName(tagName:String):TNodeList;
	function getElementsByTagNameNS(namespace:String, localName:String):TNodeList;
	function getElementsByClassName(classNames:String):TNodeList;
	function getElementById(elementId:String):Element<TDoc, TNodeList, TElm>;
	function createElement(localName:String):Element<TDoc, TNodeList, TElm>;
	function createElementNS(namespace:String, qualifiedName:String):Element<TDoc, TNodeList, TElm>;
	//function createDocumentFragment():DocumentFragment;
}