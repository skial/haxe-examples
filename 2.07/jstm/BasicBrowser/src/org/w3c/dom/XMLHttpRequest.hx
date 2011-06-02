/**
 * ECMAScript HTTP API:
 * http://www.w3.org/TR/XMLHttpRequest2/#xmlhttprequest
 * 
 * The W3C JavaDoc doesn't specify a namespace for this class so we introduce org.w3c.dom.xml.
 * 
 * TODO: someone should really write this class for php, neko, cpp and flash (URLLoader) targets
 * 
 * js.Boot takes care of IE
 * 
 * this might one day come in handy:
 * http://www.ilinsky.com/articles/XMLHttpRequest/#bugs
 * http://code.google.com/p/xmlhttprequest/
 * 
 * @author Cref
 */
package org.w3c.dom;

interface XMLHttpRequest {
	var onreadystatechange : Void->Void;//EventListener;//disabled because of haxe.Http, TODO: move to browser implementation (implements org.w3c.dom.events.EventTarget)
	var readyState(default,never) : Int;
	var responseText(default,never) : String;
	var responseXML(default,never) : org.w3c.dom.Document<Dynamic,Dynamic,Dynamic>;//TODO: XMLDocument
	var status(default,never) : Int;
	var statusText(default,never) : String;
	function abort() : Void;
	function getAllResponseHeaders() : String;
	function getResponseHeader( name : String ) : String;
	function setRequestHeader( name : String, value : String ) : Void;
	function open( method : String, url : String, ?async : Bool, ?user:String, ?password:String ) : Void;
	function send( ?content : String ) : Void;
}

/*
#if (js_browser || js_hta || js_air)
typedef XMLHttpRequest = X_org_w3c_dom_xml_XMLHttpRequest__;
#elseif (js_asp || js_wsh)
typedef XMLHttpRequest = activex.msxml2.XMLHttp;
#end
*/