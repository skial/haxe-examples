package hxtc.net;

import hxtc.web.Location;
import haxe.io.Path;

using DateTools;
using StringTools;
using hxtc.use.ForString;
/**
 * ...
 * @author Cref
 */

class HTTPServerRequest extends PathHandler<Void> {
	public var token(default, null):String;
	public var isClientFirst(default, null):Bool;
	public var isSessionFirst(default, null):Bool;
	
	public var cookies:hxtc.DynamicHash<Dynamic>;//TODO: Cookie class
	public var headers:hxtc.DynamicHash<String>;
	public var post:VarGetter;
	//GET and POST variables combined where POST variables overrule GET variables
	public var data:VarGetter;
	public var files:hxtc.DynamicHash<Dynamic>;//TODO: BinaryPost class. Wellicht beter om hier een iterable te gebruiken?
	//public var response:HTTPServer.Response;
	public var location(default,null):Location;
	public var referrer:Location;
	public var userAgent(default,null):String;
	public var isBot(default,null):Bool;
	public var ip:String;
	public var workingDirectory(default,null):String;
	public var server(default, null):HTTPServer;
	
	static var searchBotRE = ~/bot|crawl|spider|slurp|ia_archiver/i;
	
	//writes a session or client token cookie
	//should be shorter eventually, like Base64 encoded
	//TODO: XSRF protection
	public function new(srv:HTTPServer, url:String, userAgent:String) {
		server = srv;
		this.userAgent = userAgent;
		isBot = searchBotRE.match(userAgent);
		var tokenName = server.tokenName;
		//prevent bots from using a new session for each request since they don't support cookies
		//by using the userAgent as the token
		if (isBot && tokenName != null) token = userAgent;
		if (isBot || tokenName == null) isClientFirst = isSessionFirst = true;
		else {
			isClientFirst = !Request.cookies.exists(tokenName);
			if (isClientFirst) {
				isSessionFirst = true;
				//if this is a new visitor:
				//permanent cookie:
				var rspCookie = Response.cookies.item(tokenName);
				rspCookie.expires = Date.now().delta(20*365.days());
				token = rspCookie.item = hxtc.Tools.getGUID();
			}
			//if this is a returning visitor:
			else {
				token = Request.cookies.item(tokenName).item;
				//if this is the first request of a session:
				isSessionFirst = !Request.cookies.exists(tokenName+'s');
			}
			if (isClientFirst||isSessionFirst) Response.cookies.item(tokenName+'s').item='';
		}
		/*
		this.headers={};//method, accept, referrer, userAgent
		this.cookies={};
		this.post =  {};
		*/
		#if asp
		workingDirectory = Server.mapPath('.').toLowerCase();
		#end
		cookies = new hxtc.DynamicHash<Dynamic>();
		headers = new hxtc.DynamicHash<String>();
		var f = Request.form;
		post = new VarGetter(function(n) return f.item(n).item );
		data = new VarGetter(function(n) return f.exists(n)?f.item(n).item:Request.queryString.item(n).item );
		files = new hxtc.DynamicHash<String>();
		//response = new Response();
		location = new Location(url);
		//transforms /this/URL/myfile.txt into this/url/myfileTxt for easy path handling
		var path = location.pathname.toLowerCase().replaceStart('/', '').camelize('.');
		//TODO: skip path to current working directory
		super(path.split('/'));
		/*
		 * testDomain allows testing applications by using a test TLD in the local DNS.
		 * 
		 * So for example, in order to test:
		 * http://myapp.com
		 * you could navigate to:
		 * http://myapp.com.mytestserver.test
		 * 
		 * This feature requires some webserver and DNS configuration.
		 */
		var arr = location.hostname.split('.'), td = arr.pop();
		if (td=='test') testDomain=arr.pop()+'.'+td;
		config = new RequestConfig(this);
	}
	
	public var testDomain(default, null):String;
	public var config(default, null):RequestConfig;
	
	private dynamic function checkHeaders() checkHeaders=function() throw 'headers already written'
	/**
	 * 
	 * @param	url
	 * @param	?permanent	if true: 301 redirect, else 302 redirect (temporary)
	 */
	public function redirectTo(url:String, ?permanent:Bool) {
		checkHeaders();
		Response.status = ''+(permanent?301:302);
		Response.addHeader('Location',url==''?'/':url);
	}
	
	/**
	 * sends a 404 response with optional delayed forwarding
	 * @param	body
	 * @param	?autoForwardURL
	 * @param	?autoForwardPauseMSec
	 */
	public function notFound(body:String='', ?autoForwardURL:String,?autoForwardPauseMSec:Int) {
			//afhankelijk maken van Accept header?
			//cache toepassen?
			var h = new Hash();
			if (autoForwardURL!=null||autoForwardPauseMSec!=null) h.set('refresh',(autoForwardPauseMSec==null?0:autoForwardPauseMSec/1000)+(autoForwardURL==null?'':';URL='+autoForwardURL));
			//NOTE: body must be at least 512 bytes to prevent the browser from showing its built-in 'friendly' error page
			//which also prevents redirecting to the homepage
			getResponse(404, h).write(body.rpad(' ', 512));
	}
	
	/**
	 * automatically creates a response for a file on disk.
	 * sets headers to the values associated with the file.
	 * @param	path
	 * @param	?compress
	 * @param	?bufferSize
	 */
	public function returnFile(path:String, ?compress:Bool, ?bufferSize:Int) {
		checkHeaders();
		//TODO: 
	}
	/**
	 * sets 304 header to indicate that the response is unchanged since the last request
	 * so that the cached response will be used
	 */
	public function returnCachedResponse() {
		
	}
	
	/**
	 * forces the headers to be written before any content can be written to the body.
	 * makes sure this function can only be called once.
	 */
	public function getResponse(
			?status:Int=200,
			?filename:String,
			?mimeType:String,
			?charset:String='UTF-8',
			?gzip:Bool,//gzip is the defacto standard, deflate is inferior to gzip. use with care! only set to true when content is gzipped!
			?showDialog:Bool,//prevents the response from opening in the browser automatically but instead shows a dialog
			?modified:Date,
			?entityTag:String,
			?cache=0.0,//max-age=cache/1000 since this works best together with DateTools class as the unit for time values is msec
			//expires:Date,//expires and max-age basically do the same but max-age has a higher priority so we don't use expires
			?isPrivate:Bool,//true: private, false: public (proxy cachable)
			?vary:Array<String>,
			?cookies:Hash<{value:String,store:Float}>,//TODO: domain and path
			?customHeaders:Hash<String>) {
		checkHeaders();
		Response.status = '' + status;
		if (filename == null) filename = Path.withoutDirectory(location.pathname);
		Response.addHeader('Content-Disposition', (showDialog?'attachment; ':'') + 'filename=' + filename.escape());
		if (mimeType == null) {
			mimeType = config.mimes.get(Path.extension(filename));
			if (mimeType == null) mimeType = 'text/plain';
		}
		Response.contentType = mimeType;
		Response.charset = charset;
		if (gzip) Response.addHeader('Content-Encoding','gzip');
		if (modified != null) Response.addHeader('Last-Modified', ES5.toGMTString(modified).replace('UTC','GMT'));
		//TODO:
		//contentInfo.entityTag
		//max-age=0 does cache the content but will only be re-used when navigating back or forward which is the desired effect
		Response.cacheControl = 'max-age=' + (cache / 1000) + ',' + (isPrivate?'private':'public');
		if (vary != null) for (v in vary) Response.addHeader('Vary', v);
		//TODO: cookies
		if (customHeaders != null) for (h in customHeaders.keys()) Response.addHeader(h, customHeaders.get(h));
		return {
			//writes a string directly to the output stream and applies character conversion when necessary
			write: function(str) Response.write(str),
			//writes a string directly to the output stream without character conversion
			writeRaw: function(str) Response.binaryWrite(str),
			stream: function(){},//TODO: streams
			streamFile:function(path:String,bufferSize:Int){}//TODO: streams a files contents (determine nice default bufferSize)
		}
	}
	
	//NOTE: requires a 500.100 handler for ASP that returns error messages as a JSON string that starts with '!~'
	//in order to correctly return server errors
	public function serveInstance(i:Dynamic, ?requireSession:Bool):Void {
		var h = new Hash(),mime=null;
		//Google runs a headless Chrome browser to crawl the page from it's own domain
		h.set('Access-Control-Allow-Origin', '*');
		//TODO: apply session restrictions, HTTP headers and response format based on rq.data
		var a = data.args == null || data.args == ''?[]:JSON.parse(data.args);
		var f = Reflect.field(i, data.call == null?'defaultResponse':data.call);
		if (!Reflect.isFunction(f)) throw new Error('invalid call');
		var result = Reflect.callMethod(i, f, a);
		if (data.call != null) switch (data.format) {
			case 'html':
				//replace </script> ?
				mime = 'text/html';
				result = '<script language="x">' + result + '</script><script>this.name=document.getElementsByTagName("script")[0].innerHTML</script>';
			case 'txt':
				//do nothing: rsp.write will force toString, client will run the same function locally
				//and determine the returntype. Then, it runs the returntype's fromString method.
				//this format is most efficient on the serverside and since it doesn't need a callback
				//argument, it can be used in combination with HTTP caching.
				//TODO: add separate dsv extension for supported results?
				mime = 'text/plain';
			case 'hx'://haxe serialization: http://haxe.org/manual/serialization
				mime = 'text/plain';
				result = haxe.Serializer.run(result);
			case 'xml'://for exporting purposes (also offer rss and atom for supported results?)
				//TODO: use some sensible xml structure, type info etc.
				mime = 'text/xml';
				result = '<?xml version="1.0" encoding="UTF-8"?>\n<result><![CDATA[\n' + result + '\n]]></result>';
			default://json(p)
				mime = 'text/javascript';
				result = JSON.stringify(result);
				var cb = data.get('callback');
				if (cb != null) {
					if (cb.length > 16) throw new Error('callback argument exceeds allowed length');
					result = data.get('callback') + '(' + result + ')';
				}
		}
		//TODO: modified via alternatieve response afhandeling ondersteunen
		//TODO: in geval van callback response clientside cachen
		getResponse(200, data.filename, mime, null, null, null, null, null, Std.parseInt(data.cache) * 1000, null, null, null, h).write(result);
		//TODO: response.end();
		if (Reflect.isFunction(i.close)) i.close();
	}
}


private class RequestConfig implements Dynamic<DynamicHash<String>> {
	var hash:Hash<DynamicHash<String>>;
	var startAt:String;
	var test:String;
	var path:Array<String>;
	public function new(rq:HTTPServerRequest) {
		hash = new Hash();
		startAt = rq.server.webroot;
		path = rq.workingDirectory.after(startAt + '\\').split('\\');
		test = rq.testDomain;
		if (test != null) test = '.' + test;//use test as a domain suffix
	}
	inline function resolve(key:String):DynamicHash<String> return get(key)
	public function get(key:String):DynamicHash<String> {
		if (!hash.exists(key)) hash.set(key,new ConfigLoader.HierarchicalConfigLoader(startAt, path, key, {
			requestPath:path.join('/'),
			requestPathPackage:path.join('.'),
			requestPathPackageDashed:path.join('-'),
			test:test
		}));
		return hash.get(key);
	}
}

//TODO: make iterable
class VarGetter implements Dynamic<String> {
	public function new(getter:String->String) {
		get = getter;
	}
	public var get:String->String;
	inline function resolve(n:String) return get(n)
}