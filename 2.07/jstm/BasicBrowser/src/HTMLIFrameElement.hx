/**
 * ...
 * @author Cref
 */

extern class HTMLIFrameElement extends HTMLElement, implements org.w3c.dom.html.HTMLIFrameElement<Window,HTMLDocument,NodeList<HTMLElement>,HTMLElement> {
	var src:String;
	var contentWindow(default, null):Window;//TODO: should be WindowProxy: http://www.w3.org/TR/html5/browsers.html#the-windowproxy-object
}