/**
 * http://dev.w3.org/html5/spec/Overview.html#htmldocument
 * 
 * @author Cref
 */

extern class HTMLDocument
	extends Document<HTMLDocument,HTMLElement>,
	implements org.w3c.dom.html.HTMLDocument<Window,HTMLDocument,NodeList<HTMLElement>,HTMLElement>,
	//implements org.w3c.dom.events.EventTarget,
	implements org.w3c.dom.NodeSelector<NodeList<HTMLElement>,HTMLElement>,
	implements org.w3c.dom.events.DocumentEvent {
		
	var body(default, never):HTMLElement;
	var activeElement(default, never):HTMLElement;//TODO: patch Safari, Opera and older Firefox http://jamesgoodfellow.com/blog/post/documentactiveElement-in-Firefox---Finding-The-Element-That-Has-Focus.aspx
	var title:String;
	var URL(default,null):String;
	var referrer(default, never):String;
	var cookie:String;
	var compatMode(default, never):String;
	var defaultView(default, null):Window;
	function hasFocus():Bool;//TODO: patch IE
	function write(str:String):Void;
	function writeln(str:String):Void;
  function getElementById(id:String):HTMLElement;
  function getElementsByName(elementName:String):NodeList<HTMLElement>;
  function getElementsByClassName(classNames:String):NodeList<HTMLElement>;
}