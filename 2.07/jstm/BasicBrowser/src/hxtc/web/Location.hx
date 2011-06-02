/**
 * Mimics the browser's internal Location class (instantiated as window.location).
 * Should be in org.w3c.Location ?
 * 
 * full RFC 2396 (http://www.apps.ietf.org/rfc/rfc2396.html) regexp with username, password and parameters:
 * (\w+:)(?:\/\/)?(?:(\w+)(?::(\w+))?@)?([^\/;\?:#]+)(?::(\d+))?(?:(\/?[^;\?#]+))?(?:(;[^\?#]+))?(?:(\?[^#]+))?(?:(#.+))?
 * regexp mathing only the components needed for this class:
 * (\w+:)(?:\/\/)?([^\/\?:#]+)(?::(\d+))?(?:(\/?[^\?#]+))?(?:(\?[^#]+))?(?:(#.+))?
 * 
 * TODO: class URI extends Location ?
 * 
 * @author Cref
 */

package hxtc.web;
using StringTools;

class Location {
	
	public var href(toString,setHref):String;
	public var protocol(default, setProtocol):String;
	public var host(getHost,setHost):String;
	public var hostname:String;
	public var port:Int;
	public var pathname(default, setPathname):String;
	public var search(default, setSearch):String;
	public var hash(default, setHash):String;
	private static var ereg = ~/(\w+:)(?:\/\/)?([^\/\?:#]+)(?::(\d+))?(?:(\/?[^\?#]+))?(?:(\?[^#]+))?(?:(#.+))?/;
	private function setHref(v:String):String {
		//TODO: throw an enum
		if (!ereg.match(v)) throw(new SyntaxError('invalid URL'));
		protocol = ereg.matched(1);
		hostname = ereg.matched(2);
		port = Std.parseInt(ereg.matched(3));
		pathname = ereg.matched(4);
		search = ereg.matched(5);
		hash = ereg.matched(6);
		return v;
	}
	private function setFor(char:String, v:String) {
		//following W3C here...
		if (v==null) return char+'null';
		switch(v) {
			case '', char:return '';
			default: return v.startsWith(char)?v:char + v;
		}
	}
	private function setSearch(v:String):String {
		search = setFor('?', v);
		return v;
	}
	private function setHash(v:String):String {
		hash = setFor('#', v);
		return v;
	}
	private function setPathname(v:String):String {
		pathname = setFor('/', v);
		if (pathname == '') pathname = '/';
		return v;
	}
	private static var protoEreg=~/\w+:?/;
	private function setProtocol(v:String):String {
		//following W3C here...
		if (v == null) protocol = ':null';
		if (!protoEreg.match(v)) throw new SyntaxError('Can\'t set protocol');
		protocol = v.endsWith(':')?v:v+':';
		return v;
	}
	private function getHost():String return hostname + (port==null?'':':'+port)
	private function setHost(v:String):String {
		var t = v.split(':');
		hostname = t[0];
		port = Std.parseInt(t[1]);
		return v;
	}
	public function new(url:String) href=url
	//double slash after protocol is actually optional but were following the W3C spec here:
	public function toString():String return protocol + '//' + host + pathname + search + hash
	
}