/**
 * ...
 * @author Cref
 */

package hxtc.net;

class HTMLEmail extends Email {
#if jscript
	private override function getBody():String return msg.htmlBody
	private override function setBody(v:String) return msg.htmlBody = v
#end
}