/**
 * ...
 * @author Cref
 */

package jstm;

//make sure browserpatches will be compiled
import hxtc.web.Data;
import jstm.IE6__;
import jstm.Moz__;
import jstm.DOMQueries__;
import jstm.DOMTraversal__;
import jstm.HashChange__;
import JSON__;

using ES5;

class Host extends jstm.Runtime {
	
	static function __init__():Void {
		//the IE version reported by the browser
		ieVersion = Std.parseInt(window.navigator.appVersion.split('MSIE ')[1]);//TODO: QuirksMode (document.documentMode==5)
		//IE8 document mode can be IE7 or quirks: quirksmode should behave like IE7
		if (ieVersion > 7 && untyped !document.querySelector) ieVersion = 7;
		engine = ieVersion > 0
			?BrowserEngine.Trident//IE
			:untyped window.opera//Opera
				?BrowserEngine.Presto//Chrome, Safari etc.
				:(navigator.appVersion.indexOf('WebKit') > -1)
					?BrowserEngine.WebKit
					//TODO: verify if this check works for all Gecko-based browsers:
					:navigator.product == 'Gecko'
						?BrowserEngine.Gecko//Firefox, Netscape, Mozilla etc.
						:BrowserEngine.Unknown//you tell me!
		;
		//BROWSER PATCHING
		untyped {
			//make sure browserpatching is done before any code runs
			//make useType backup
			var uT = jstm.Runtime['useType'];
			jstm.Runtime.useType = function(tn:String, callbck:Dynamic->Void):Void {
				//run patches
					//restore useType
					jstm.Runtime.useType = uT;
					var browserPatch = 'jstm$'+(switch(Host.engine) {
						case BrowserEngine.Trident:'IE' + (ieVersion < 7?6:ieVersion);
						case BrowserEngine.Gecko:'Moz';
						default:'NonIE';
					}) + '__';
					var patchArgs = ['PATCH',browserPatch];
					if (!window.JSON) patchArgs.push('JSON__');
					if (!document.querySelector) patchArgs.push('jstm$DOMQueries__');
					if (!(untyped __js__("'onhashchange' in window"))||document.documentMode<8) patchArgs.push('jstm$HashChange__');
					jstm.Runtime.registerClass(new Function(patchArgs, 'return [{patches:arguments}]'));
					jstm.Runtime.useClass('PATCH', function(P) {
						var l = P.patches.length;
						for (p in 1...l) patches.push(P.patches[p]);
						//patch main window
						patchWindow(window);
						//run callback
						uT(tn, callbck);
					});
			}
		}
	}
	
	//static var srcRE:RegExp = untyped __js__("/jstm\\/Host/i");
	
	static var scriptElm:HTMLScriptElement;
	
	static function getTypeRegExp(path:Array<String>):RegExp {
		var check = '\n('+path.join('(?:\\.');
		for (i in 1...path.length) check += ')?';
		check += ')\n';
		return new RegExp(check,'');
	}

	public override function loadType(typeName:String):Void {
		var path = typeName.split('.'),root=scrSrc[0];
		if (roots != null) {
			var matches=getTypeRegExp(path).exec(roots);
			if (matches != null) {
				var pack = matches[1];
				root = rootsObj.get(pack)+'/';
				path = typeName.split(pack + '.')[1].split('.');
			}
		}
		//var src = '';
		/*if (typeName == '_gat__init__') {
			//TODO: check if already loaded
			untyped _gaq = [function()jstm(function(_gat__init__){})];
			src = '//www.google-analytics.com/ga.js';
		}
		else {*/
			/*src = path[0] == 'google'
				?getGoogleSrc(path)
				:scriptElm.src.replace(srcRE, path.join('/').toLowerCase())
			;*/
			var src=(root+path.join('/')+scrSrc[1]).toLowerCase();
		//}
		//untyped console.log('loadType: '+scriptElm.src);
		loadScript(src);
	}
	
	/*function getGoogleSrc(path:Array<String>):String {
		return path.join('.');
	}*/
	
	static function getArg(name:String):String {
		return scriptElm.getAttribute('data-'+name);
	}
	
	public static function loadScript(url:String, ?onload:Void->Void):HTMLScriptElement {
		//untyped console.log('loadScript: '+url);
		var d = window.document,h=d.documentElement.firstChild;
		var s:HTMLScriptElement = d.createElement('script');
		s.src = url;
		s.onload = function(e) {
			h.removeChild(s);
			if (onload != null) onload();
		};
		//IE. TODO: implement as patch
		untyped s.onreadystatechange = function(e) {
			if (s.readyState == 'loading') return;
			s.onreadystatechange = null;
			if (onload != null) onload();
			//not sure about this...
			//setTimeout(function() h.removeChild(s), 500 );
		}
		return h.appendChild(s);
	}
	
	static var n = 0;
	
	public static function loadCallback(url:String, callbck:Dynamic->Void, ?callbckStr:String = 'callback'):HTMLScriptElement {
		var id = n++;
		untyped window.jstm['_'+id] = function(o) {
			ES5.delete(window.jstm['_'+id]);
			callbck(o);
		}
		var s = loadScript(url+((url.indexOf('?')>-1)?'&':'?')+ES5.global.encodeURIComponent(callbckStr)+'=jstm._'+id);
		return s;
	}
	
	public function new() {
		super();
		//TODO: integrate Browser in Host (host.window etc.)
		var d = window.document;
		var allscr = d.getElementsByTagName('script');
		scriptElm = cast allscr[allscr.length - 1];
		var tmp = scriptElm.src.split('#');
		scrSrc = tmp[0].toLowerCase().split("jstm/host");//IE<8 skips empty results when using split with a RegExp so we use a string
		//load package roots
		roots = getArg('roots');
		if (roots != null) {
			//roots = 'nl.haaglanden= nl.haaglanden.controls=//controls.haaglanden.nl.vista8.test:88 cimple=//cimplecms.nl.vista8.test:88/cimple test=//test.com/jslib';
			rootsObj = Data.unserialize(roots, ' ', true);
			var rootsArr = ES5.getKeys(rootsObj);
			if (rootsArr.length == null) roots = null;
			else {
				//prepare for optimal performance: sort by length so we can instantly get the most specific match
				rootsArr.sort(function(a, b) return b.length - a.length);
				roots='\n'+rootsArr.join('\n')+'\n';
			}
		}
		var autoRun = tmp[1];
		if (autoRun != null) Runtime.runClass(autoRun);
	}
	var roots:String;
	var rootsObj:Dynamic<String>;
	
	static var patches:Array<Class<Void>> = [];
	static function patchWindow(w:Window) for (p in patches) untyped __new__(p,w)
	
	var scrSrc:Array<String>;
	
	public static inline var window:Window = untyped __js__("window");
	//is determined in js.Boot but made accessible here
	public static var ieVersion(default,null):Int;
	//tells you if the browser is a mobile version
	//matches iPhone, iPad, IEMobile, Nokia S60, Samsung, Opera, RIM Blackberry, HP WebOS
	//not using EReg to keep initial footprint small
	public static var isMobile:Bool = untyped __js__("/(mobile|symbian|opera mini|blackberry|webos)/i").test(window.navigator.userAgent);
	
	//returns the browser engine (a.k.a. layout engine, a.k.a. render engine)
	public static var engine:BrowserEngine;
	
	//TODO: scriptEngine?
	
}

/**
 * virtual enum
 * TODO: generate using macro?
 * @author Cref
 */
class BrowserEngine {
	public static inline var Unknown:BrowserEngine = cast 0;//anything we couldn't succesfully detect
	public static inline var Trident:BrowserEngine = cast 1;//IE
	public static inline var WebKit:BrowserEngine = cast 2;//Chrome, Safari (based on KHTML, use same?)
	public static inline var Gecko:BrowserEngine = cast 3;//Firefox, Netscape, Mozilla etc.
	public static inline var Presto:BrowserEngine = cast 4;//Opera
}