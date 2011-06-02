/**
 * JSON-based remoting
 * 
 * The theory is the same as haXe remoting but it has some important differences!
 * - JSON is used instead of serialize and unserialize
 * - inheritance is supported
 * - multiple communication methods are supported
 * - HTTP headers are supported (cache control anyone?)
 * - secure XSS and XSRF protection are built-in
 * - but most importantly:
 *   classes are not proxy instances!
 *   remote instances are generated based on the class.
 *   this offers more flexibility but please note that you should use compile-time conditions
 *   around any code you do not wish to publish to the browser target!
 * 
 * 
 * @author Cref
 */

package hxtc.remoting;

import hxtc.browser.CookieHelper;
import hxtc.Proxy;
import hxtc.net.HTTP;
import jstm.Host;

using hxtc.dom.DOMTools;
using StringTools;
using hxtc.use.ForString;

class HTTPConsumer {
	
	//TODO: forcePost, cache
	//TODO: cross-domain POST's using hxtc.net.HTTP.postObject
	public function new(remotePath:String,?sessionTokenName:String):Void {
		this.remotePath = remotePath;
		this.sessionToken = CookieHelper.getCookieHelper(Host.window.document).resolve(sessionTokenName).value;
	}
	var remotePath:String;
	var sessionToken:String;
	
	static var errorFlag = '!~';
	
	//TODO: integrate remote exceptionStack with local
	static function checkError(cls:Class<Dynamic>,r:String,n:String):Dynamic {
		if (Std.is(r, String) && r.startsWith(errorFlag)) throw new Error('Remote error in ' + Type.getClassName(cls) + '.' + n + ': ' + r.after(errorFlag)/*,cls,n*/);
		return r;
	}
	
	function buildURL(inst:String, fn:String, args:Array<Dynamic>, serializedMode:Bool, cacheMsec:Float):String {
		return (remotePath+(inst==''?'':'/'+inst))+ '?' + hxtc.web.Data.serialize({
			call:fn,
			args:JSON.stringify(args),
			session:sessionToken
		}) + (serializedMode?'&format=txt':'') + (cacheMsec == null?'':'&cache='+(cacheMsec/1000));
	}
	
	public function getInstance<T>(remoteClass:Class<T>,pathToInstance:String=''):T {
		//TODO: throw error when forceSync is used combined with an incompatible host (same origin policy)
		//TODO: also use cacheMsec to cache the final result as well (browsercache still has a purpose because it 'survives' refreshes and can be cached by proxyservers)
		//TODO: return JSON results that integrate with the Type Manager so that unavailable types will be loaded as required
		//TODO: forcePost and use HTTP.postObject combined with format=html for running callbacks from unauthorized frames
		//otherwise, set callback to ''parent.'+callbackId (TODO: check if there won't be any native object errors due to other iframe's context)
		var t = this;
		return Proxy.create(
			remoteClass,
			function(n:String, args:Array<Dynamic>, callbck:Dynamic->Void, forceSync:Bool,serializedMode:Bool,cacheMsec:Float):Void {
				var url = t.buildURL(pathToInstance, n, args,serializedMode,cacheMsec),cb=function(r:String) callbck(checkError(remoteClass, r, n));
				forceSync
					?cb(serializedMode
						?HTTP.requestText(url)//can only be used in combination with Access-Control-Allow-Origin:* on the serverside
						:HTTP.requestJSON(url)
					)
					:serializedMode
						?HTTP.requestText(url,true,cb)
						:Host.loadCallback(url,cb)
				;
			}
		);
	}
	
}