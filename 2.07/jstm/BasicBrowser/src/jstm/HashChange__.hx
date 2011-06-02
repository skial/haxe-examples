/**
 * Emulates hashchange event on the window object.
 * Chrome 3 doesn't have native hashchange, Chrome 4 does.
 * 
 * notitie:
 * In IE kan steeds dezelfde event worden gedispatcht maar
 * Firefox (3.0 en lager) vereist een nieuwe event voor elke dispatch.
 * In IE werkt dit dan weer alleen als er al eens een hashchange event is aangemaakt.
 * Nog centraal oplossen.
 * 
 * @author Cref
 */
package jstm;

class HashChange__ {
	static function __init__():Void {
		if (untyped __js__("'onhashchange' in window&&document.documentMode!=7")) throw new Error('incorrect usage');
	}
	
	function new(w:Window) {
		//trace('hashchange patch');
		var e:Event = w.document.createEvent('Event');//should be HashChangeEvent
		e.initEvent('hashchange',false,false);
		var l=w.location,lastHash=l.hash,hashInterval=w.setInterval(function(){
			if (l.hash != lastHash) {
				lastHash = l.hash;
				//trace('hashchange dispatched');
				w.dispatchEvent(e);//we ignore the fact that this event should also apply to the body element as it doesn't add anything
			}
		},150);
	}
}