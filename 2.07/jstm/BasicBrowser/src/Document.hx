/**
 * http://dev.w3.org/html5/spec/Overview.html#htmldocument
 * spec states that Document should implement HTMLDocument.
 * 
 * @author Cref
 */

extern class Document<TDoc,TElm>
	extends Node<TDoc,NodeList<TElm>,TElm>,
	implements org.w3c.dom.events.DocumentEvent,
	//implements org.w3c.dom.events.EventTarget,
	implements org.w3c.dom.NodeSelector<NodeList<TElm>,TElm>,
	implements org.w3c.dom.Document<TDoc,NodeList<TElm>,TElm> {
	//implements HTMLDocument {
	//DocumentEvent
	public function createEvent(eventModule:String):Dynamic;
	//EventTarget
	function addEventListener(type:String, handler:org.w3c.dom.events.EventListener<Dynamic>, capture:Bool):Void;
	function removeEventListener(type:String, handler:org.w3c.dom.events.EventListener<Dynamic>, capture:Bool):Void;
	function dispatchEvent(event:org.w3c.dom.events.Event):Bool;
	//NodeSelector
	function querySelector(query:String):TElm;
	function querySelectorAll(query:String):NodeList<TElm>;
	//Document
	var documentElement(default,never):TElm;
	function createElement(tagName:String):Dynamic;
	function createTextNode(str:String):org.w3c.dom.Text;
	function getElementsByTagName(tagName:String):NodeList<TElm>;
}