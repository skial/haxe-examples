extern class XMLHttpRequest implements org.w3c.dom.XMLHttpRequest {
	function new() : Void;
	var onreadystatechange : Void->Void;//EventListener;//disabled because of haxe.Http
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