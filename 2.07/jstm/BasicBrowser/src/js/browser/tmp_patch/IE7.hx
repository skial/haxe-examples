/**
 * Inspired by the great (but overkill) JDC Library
 * @author Cref
 */

package js.browser.patch;

import js.browser.Browser;

using hxtc.use.ForString;
using hxtc.Tools;

class IE7 {
	
	static function __init__() {
		if (untyped window.constructor) throw new org.ecmascript.Error('incorrect usage');
		js.Boot.windowPatchers.push(domConstructors);
		js.Boot.patchWin.patch(function(patchWin) {
			return function(w) {
				patchWin(w);
				//TODO: use document.all but first prevent special event elements from getting patched
				//or else IE6 will die!
				var all = w.document.documentElement.getElementsByTagName('*');
				for (e in all) e.ext(untyped w.Element.prototype);
				hashHistory(w);
				return w;
			}
		});
	}
	
	static function domConstructors(w:Window) {
		var d:IEDocument = cast w.document;
		var ElP = { },EvP = { };
		untyped {
			w.Window = { prototype:w };
			w.HTMLDocument = { prototype:d };
			w.Element = { prototype: ElP };
			w.Event = { prototype: EvP };
			//TODO: add more constructors
		}
		d.createEventObject.patch(function(ce:Void->Event) return function() return ce().ext(EvP));
		d.createElement.patch(function(ce:String->HTMLElement) return function(n) return ce(n).ext(ElP));
	}
	

	/*
	IE<8 doesn't write hash changes to the history.
	This fix emulates history for hash changes by using an iframe.

	TODO: Doesn't always work in Quirks-mode
	TODO: Optimize
	TODO: IE6 verversen na handmatige wijzigingen omdat anders adresbalk niet meer wordt bijgewerkt (zie CWF)
	NOTE: IE8 plaatst handmatige wijzigingen NIET in de history (wel clicks op links),
	is ook op te lossen via de iframe methode maar laten we vooralsnog voor wat het is

	click noise is niet op te lossen want onderstaande oplossing ondersteunt geen history en events
	//retourneert een IE-only document object dat geen click-geluid maakt na een POST (tbv rpc's)
	function(s){
	 var d=new ActiveXObject('htmlfile');
	 with(d){open();write(s||'');close()};//een body maken
	 return d;
	}
	*/
	static function hashHistory(w:Window):Void {
		var
			d = w.document,
			//Dynamic because only IE will load this class and this way we can just use some IE only code
			f:Dynamic = d.createElement('iframe'),
			ol = 'onload',
			l = w.location
		;
		var update = function(?e) {
			//todo: htmlEscape
			var fd = f.contentWindow.document;
			var h = l.href.after('#');//l.hash doesn't give the right result in IE6
			if (h != fd.body.innerText) {
				untyped __js__("with (fd){open();write(h);close()}");
			}
		};
		f.attachEvent(ol,function(){//TODO: check if this contraption is still necessarry
			f.detachEvent(ol,org.ecmascript.Function.arguments.callee);//skip first time
			update();
			f.attachEvent(ol,function() l.hash = f.contentWindow.document.body.innerText);
		});
		w.addEventListener('hashchange', update,false);
	}
	
}

typedef IEDocument = { > HTMLDocument,
	public function createEventObject():Dynamic;
}