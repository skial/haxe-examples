/**
 * adds querySelector and querySelectorAll using NWMatcher which offers best overall IE7&8 performance
 * https://github.com/dperini/nwmatcher/raw/master/src/nwmatcher.js
 * (Sizzle and IDQuery might one day be used as an alternative)
 * 
 * TODO: use new JS embedding option
 * 
 * required for FF<3.5 and IE<8
 * 
 * @author Cref
 */

package jstm;
import haxe.macro.Expr;
import haxe.macro.Type;



class DOMQueries__ {
	
	//Initializes NWMatcher
	static function __init__() untyped {
		if (__js__("document.querySelector")) throw new Error('incorrect usage');
	}
	
	function nwMatcher() {
		haxe.macro.Tools.includeFile("jstm/nwmatcher.js");
	}
	
	function new(w:Window) untyped {
		untyped __js__("this").nwMatcher.call(w);
		var nw = w.NW.Dom;
		w.HTMLDocument.prototype.querySelector=w.Element.prototype.querySelector=function(s) { return nw.select(s, this)[0]; };//should have a limiter argument!
		w.HTMLDocument.prototype.querySelectorAll=w.Element.prototype.querySelectorAll = function(s) { return nw.select(s, this); };
	}
}