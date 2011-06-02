/**
 * Wraps native HTTP classes.
 * Should be implemented on each target that has HTTP capabilities.
 * Currently, only ASP is supported.
 * TODO: Neko, PHP, CPP, Rhino JSDB etc.
 * 
 * Targets that are by itself running inside an HTTP request (like ASP/PHP/(F)CGI)
 * have a private constructor that is used for getting the defaultInstance.
 * Targets that support the creation of HTTP servers have a public constructor.
 * 
 * TODO:
 * - guards against XSRF exploits (session hijacking) by requiring sessionKey in both cookie as well as querystring
 * - enforce secure use of XSS through trusted referrers
 * - Basic access authentication (no encryption! use together with SSL) (http://en.wikipedia.org/wiki/Basic_access_authentication)
 * - Digest access authentication (http://en.wikipedia.org/wiki/Digest_access_authentication)
 * - OAuth 2.0
 * 
 * HTTP Status code specs: http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
 * HTTP Headers specs: http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html
 * 
 * @author Cref
 */

package hxtc.net;

class HTTPServer {
	
	public var tokenName:String;
	//private var pathHandlers:CanonicalHash < {handler:Request->Void,useSessionKey:Bool,useClientKey:Bool} > ;
	public var webroot(default,null):String;
	public function new(?webroot:String) {
		this.webroot = webroot.toLowerCase();
		//pathHandlers = new CanonicalHash();
	}
	
	public function mapPath(url:String):String return Server.mapPath(url)
	/*
	public function setPathHandler(path:String,handler:Request->Void, ?useSessionKey:Bool, ?useClientKey:Bool):HTTPServer {
		pathHandlers.set(path, { handler:handler, useSessionKey:useSessionKey, useClientKey:useClientKey } );
		return this;
	}*/
	/*
	public function setPathHandler(path:String, ?handler:HTTPServerRequest->Void) {
		path = path.toCanonical();
		handler == null?pathHandlers.remove(path):pathHandlers.set(path, handler);
	}
	*/
	/*
	 * determines the handler associated with the request and executes it
	 */
	/*private function handleRequest(request:HTTPServer.Request):Void {
		if (pathHandlers == null) return;
		var requestPath = request.location.pathname.replace('+','{PLUS}').urlDecode().replace('{PLUS}','+').toCanonical();
		var pathArray = requestPath.split('/'), handlerPath = '';
		pathArray.unshift('');
		while (pathArray.length>0){
			handlerPath=pathArray.join('/');
			if (pathHandlers.exists(handlerPath)) {
				request.handlerPath = handlerPath;
				//request.resource = ('/'+requestPath).after(handlerPath+'/').toCanonical();
				pathHandlers.get(handlerPath).handler(request);
				//TODO: solve differently!
				//writeResponseHeaders(request.response);
				break;
			}
			else pathArray.pop();
		}
	}*/
	
	/*
	//this should generate a key that is not guessable, for instance a GUID (as is the case for ASP)
	private function getClientKey():String {
		if (_clientKey == null) {
			var cookie = NativeRsp.cookies.item(clientKeyName);
				//return compact?r.na(0).tot(2,true).vervang('-'):r;
			if ((_clientKey = NativeReq.cookies.item(clientKeyName).item) == '') {
				cookie.item = _clientKey = hxtc.Tools.getGUID();
				//cookie.secure = true;//only works with https?
			}
			//always update expiration once per request when using key
			cookie.expires = Date.now().delta(365.days());
		}
		return _clientKey;
	}
	//this should generate a key that is not guessable, for instance a GUID (as is the case for ASP)
	private function getSessionKey():String {
		if (_sessionKey == null){
				//return compact?r.na(0).tot(2,true).vervang('-'):r;
			if ((_sessionKey = NativeReq.cookies.item(sessionKeyName).item) == '') {
				var cookie = NativeRsp.cookies.item(sessionKeyName);
				cookie.item = _sessionKey = hxtc.Tools.getGUID();
				//cookie.secure = true;
			}
		}
		return _sessionKey;
	}
	*/
	
	//#if asp
	/*
	 * writes headers, cookies and body and optionally takes care of compression
	 * splitsen in writeBody, writeHeader en writeCookie?
	 */
	//private function writeResponseHeaders(response:HTTPServer.Response):Void {
		//for (header in response.headers.keys())  NativeRsp.addHeader(header, response.headers.get(header));
	//}
	//public function getVar(label:String):String return  Req.serverVariables.item(label).item
	/*
	 * in ASP, start immediately handles the current request
	 * 
	 * Not complete, more info: http://www.w3schools.com/asp/coll_servervariables.asp
	 */
	/*
	 * starts listening for requests
	 */
	/*public function start() {
		//HTTP_HOST:						test.nl.cref.local
		//PATH_INFO:						/projects/local/cref/nl/test/default.asp
		//PATH_TRANSLATED:			D:\www\projects\nl\test\default.asp
		//HTTP_X_ORIGINAL_URL:	/mijn/voorbeeld/123.abc
		//for (n in Request.serverVariables) Response.write(Request.serverVariables.item(n)+'\n');
		var protocol = 'http' + (getVar('HTTPS')=='on'?'s':'');
		var port = getVar('SERVER_PORT');
		var host = getVar('HTTP_HOST');
		var url = getVar('HTTP_X_ORIGINAL_URL');
		//ASP does have its own session solution but this limits clients to one simultaneous request
		//which is unacceptable for todays web applications. So be smart and don't use ASP's own sessions!
		//You can change your IIS configuration or add a page directive: EnableSessionState=False
		//TODO: url opbouw indien geen rewriting is gebruikt
		var request = new Request(this,protocol + '://' + host + url,getVar('HTTP_USER_AGENT'));
		for (n in  Req.queryString) request.data.set(n, Req.queryString.item(n).item);
		for (n in Req.form) {
			var value = Req.form.item(n).item;
			request.post.set(n, value);
			request.data.set(n, value);
		}
		var ref = getVar('HTTP_REFERER');
		if (ref != null) request.referrer = new hxtc.web.Location(ref);
		request.ip=getVar('REMOTE_ADDR');
		handleRequest(request);//TODO: request properties vullen
	}*/
	
	//public static var defaultInstance = new HTTPServer(Server.mapPath('/'));
	//#end
}