/**
 * HTML5 Document
 * 
 * http://dev.w3.org/html5/spec/dom.html#htmldocument
 * 
 * implements HTMLDocument (extends Node), EventTarget, NodeSelector, DocumentEvent
 * 
 * @author Cref
 */
package org.w3c.dom.html;

interface HTMLDocument<TWin,TDoc,TNodeList,TElm> implements Document<TDoc,TNodeList,TElm> {
	var body(default, never):TElm;
	var activeElement(default, never):TElm;//TODO: patch Safari, Opera and older Firefox http://jamesgoodfellow.com/blog/post/documentactiveElement-in-Firefox---Finding-The-Element-That-Has-Focus.aspx
	var title:String;
	var URL(default,null):String;
	var referrer(default, never):String;
	var cookie(default, never):String;
	var compatMode(default, never):String;
	var defaultView(default, null):TWin;
	function hasFocus():Bool;//TODO: patch IE
	function write(str:String):Void;
	function writeln(str:String):Void;
	function getElementsByName(elementName:String):TNodeList;
	function getElementsByClassName(classNames:String):TNodeList;
}