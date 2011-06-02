/**
 * Easy methods for sending HTTP requests.
 * 
 * Will contain a fallback method for the browser target when doing cross-domain requests.
 * 
 * @author Cref
 */

package hxtc.net;

import hxtc.web.Data;
import jstm.Host;

using hxtc.use.ForString;

class HTTP {
	
	//the most efficient way to send a message over HTTP when you don't need a response.
	//optionally, you could use the boolean argument in the callback function to detect a serverside failure.
	//note that this will only work correctly when a valid image is returned so that onload will be triggered!
	public static function signal(url:String,?cb:Bool->Void):Void {
		var i:HTMLImageElement = untyped __js__("new Image()");
		if (cb != null) untyped {
			i.onload = function() cb(true);
			//will be triggered when the url doesn't return a valid image
			i.onerror = function() cb(false);
		}
		i.src = url;
	}
	
	//TODO: move and rename and integrate into all-in-one solution for cross-site scripting
	public static function postObject(url:String, obj:Dynamic, ?callbck:String->Dynamic) {
		var d = Host.window.document;
		var f:HTMLFormElement = cast d.createElement('form');
		f.method = 'post';
		f.action = url;
		for (n in Reflect.fields(obj)) {
			var t:HTMLTextAreaElement = cast d.createElement('textarea');
			t.name = n;
			t.value = Reflect.field(obj, n);
			f.appendChild(t);
		}
		var h = d.documentElement.firstChild;
		h.appendChild(f);//required for Firefox!
		postForm(f, callbck);
		h.removeChild(f);
	}
	
	static var n = 0;
	
	/*
	cross-browser, cross-domain form posting with callback
	without the need for a transfer url.

	For a cross-domain post, the response should have the following format:

	<script language="x">the response
	for the request</script><script>this.name=document.getElementsByTagName('script')[0].innerHTML</script>

	this requires no escaping, just make sure the response doesn't contain a closing script tag
	
	TODO: set encoding to 'multipart/form-data' when file inputs are present
	*/
	public static function postForm(f:HTMLFormElement, ?callbck:String->Dynamic) {
		var d = f.ownerDocument;
		var i:HTMLIFrameElement = cast d.createElement('iframe');
		d.documentElement.firstChild.appendChild(i);
		if (callbck != null) {
			var l = null;
			l=function() {
					l = function() {
						callbck(i.contentWindow.name);
						d.defaultView.setTimeout(function() i.parentNode.removeChild(i), 0);
					};
					//TODO: indien toegankelijk direct i.contentWindow.name raadplegen, anders transfer gebruiken:
					i.contentWindow.location.href = untyped window.opera?'javascript:;':'about:blank';
			};
			//TODO: emulate onload event for IE
			untyped {
				i.onreadystatechange = function() if (i.readyState == 'complete') l();//loaded too?
				i.onload = function() l();
			}
		}
		f.target = i.contentWindow.name = 'i' + (n++);
		f.submit();
		i.contentWindow.name = null;
	}
	
	//TODO: post as string?
	//NOTE: Make sure the webserver sends cache response headers to prevent IE6 from falling back to heuristics-mode!
	public static function request(url:String,?post:Dynamic<String>,?headers:Dynamic<String>,?async:Bool,?callbck:XMLHttpRequest->Void):XMLHttpRequest {
		var x=new XMLHttpRequest(),p=post!=null;
		// TODO!
		if (callbck != null) x.onreadystatechange = /*jstm.Platform.getEntrypointWrapperFor(cast*/ function() {
			if (x.readyState == 4) {
				//prevent IE6 from leaking:
				x.onreadystatechange = empty;
				callbck(x);
			}
		}/*)*/;
		x.open(p?'POST':'GET', url, async == true);
		//can only be set AFTER open() !!!
		if (p) x.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		if (headers != null) for (n in Reflect.fields(headers)) x.setRequestHeader(n.uncamelize(), Reflect.field(headers, n));
		var s = function() x.send(p?Data.serialize(post):null);
		//prevents IE6 from treating async calls for cached responses as sync:
		async && ie6?Host.window.setTimeout(s, 0):s();
		return x;
	}
	
	static function empty() {
		
	}
	static var ie6 = Host.ieVersion > 0 && Host.ieVersion < 7;
	
	public static function requestText(url:String, ?post:Dynamic<String>, ?headers:Dynamic<String>, ?async:Bool, ?callbck:String->Void):String {
		var r = request(url, post, headers, async, callbck == null?null:function(x) callbck(x.responseText));
		//IE will complain if we don't do this check first:
		return async?null:r.responseText;
	}
	
	public static function requestJSON(url:String, ?post:Dynamic<String>, ?headers:Dynamic<String>, ?async:Bool, ?callbck:Dynamic->Void):Dynamic {
		var p=null,r = requestText(url, post, headers, async, callbck == null?null:function(x) callbck(p=JSON.parse(x)));
		return async?null:p==null?JSON.parse(r):p;
	}
	
	public static function requestXML(url:String, ?post:Dynamic<String>, ?headers:Dynamic<String>, ?async:Bool, ?callbck:org.w3c.dom.Document<Dynamic,Dynamic,Dynamic>->Void):org.w3c.dom.Document<Dynamic,Dynamic,Dynamic> {
		var r = request(url, post, headers, async, callbck == null?null:function(x) callbck(x.responseXML));
		//IE will complain if we don't do this check first:
		return async?null:r.responseXML;
	}
	
}