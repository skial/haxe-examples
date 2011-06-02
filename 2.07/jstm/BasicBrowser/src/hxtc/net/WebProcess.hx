package hxtc.net;

/**
 * any ISAPI or (F)CGI hosted process:
 * ASP, ASP.NET, PHP, JSP etc.
 * @author Cref
 */

class WebProcess {

	#if asp
	public static var request:HTTPServerRequest = {
		var vars=new HTTPServerRequest.VarGetter(function(label:String):String return Request.serverVariables.item(label).item);
		//HTTP_HOST:						test.nl.vista8.test
		//PATH_INFO:						/projects/nl/test/default.asp
		//PATH_TRANSLATED:			D:\www\projects\nl\test\default.asp
		//HTTP_X_ORIGINAL_URL:	/mijn/voorbeeld/123.abc
		//for (n in Request.serverVariables) Response.write(Request.serverVariables.item(n)+'\n');
		var protocol = 'http' + (vars.https=='on'?'s':'');
		var port = vars.server_port;
		var host = vars.http_host;
		var url = vars.http_x_original_url;
		//ASP does have its own session solution but this limits clients to one simultaneous request
		//which is unacceptable for todays web applications. So be smart and don't use ASP's own sessions!
		//You can change your IIS configuration or add a page directive: EnableSessionState=False
		//TODO: url opbouw indien geen rewriting is gebruikt
		var rq = new HTTPServerRequest(new HTTPServer(Server.mapPath('/')),protocol + '://' + host + url,vars.http_user_agent);
		var ref = vars.http_referer;
		if (ref != null) rq.referrer = new hxtc.web.Location(ref);
		rq.ip=vars.remote_addr;
		rq;
	}
	#elseif php
	#end
}