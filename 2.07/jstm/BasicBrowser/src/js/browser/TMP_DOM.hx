/**
 * The DOM class forms the DOM abstraction layer for hxtc.
 * It has an static inlined variable named 'instance'.
 * js.Boot creates an instance of a class depending on the browser it is running in.
 * This instance points to $DOM.
 * Any function that is not part of IE's DOM is a member of this instance.
 * This is done because IE's DOM objects aren't scripting objects and thus
 * their prototype can not be manipulated.
 * 
 * @author Cref
 */

package js.browser;

//for patching IE<8:
//import com.sizzlejs.Sizzle;

using hxtc.use.ForString;
//using hxtc.dom.DOMTools;

extern class DOM {
	public static inline var instance:DOM = untyped __js__("$DOM");
	public static inline function getStyle(s:CSSStyleDeclaration, n:String):String return instance.styleAttr(s, n)
	public static inline function setStyle(s:CSSStyleDeclaration, n:String, ?v:Dynamic):String return instance.styleAttr(s, n, v)
	public function createStyleRule(stylesheet:CSSStyleSheet, selector:String):CSSStyleRule;
	public function styleAttr(s:CSSStyleDeclaration, n:String, ?v:String):String;
	public function initWindow(w:Window):Window;
}

//typedef Window = org.w3c.dom.html.Window

//patch for browsers that obey the W3C specs (all but IE<9)
private class Standard /*implements DOM*/ {
	
	public function createStyleRule(stylesheet:CSSStyleSheet, selector:String):CSSStyleRule {
		#if debug
		if (selector.indexOf(',') > -1) throw('IE<9 doesn\'t like the comma in: '+selector);
		#end
		return untyped stylesheet.cssRules[stylesheet.insertRule(selector+'{}',stylesheet.cssRules.length)];
	}

	private static var vendorPrefix:String;
	#if js_browser
	private static function __init__():Void {
		var w = Browser.window;
		//determine the current browser's vendor prefix
		if (untyped w.opera) vendorPrefix='O';
		else{
			var vendorPrefixes=['Webkit','Moz','Khtml','Icab'],s=w.document.documentElement.style;
			for (vp in vendorPrefixes) if (hxtc.ECMAObject.hasField(s, vp + 'Opacity')) {
				vendorPrefix = vp;
				break;
			}
		}
	}
	#end
	public function styleAttr(s:CSSStyleDeclaration,n:String,?v:String):String untyped {
		if (!hxtc.ECMAObject.hasField(s, n)) {
			switch(n) {
				case 'zoom':
					//scale behaves a bit different but it's better than nothing
					//although supported by WebKit and IE, zoom is not part of any standard so not sure if this will stay in haxetacy
					//a cross-browser transform might be a better idea:
					//https://developer.mozilla.org/en/CSS/-moz-transform
					n = vendorPrefix + 'Transform';
					v = 'scale(' + v + ')';
				default: n=vendorPrefix + n.capitalize();
			}
		}
		if (Function.arguments.length > 2) s[n] = v;
		//trace(n);
		return s[n];
	}
	
	public function initWindow(w:Window):Window {
		ieMouseEvents(w.document);
		return w;
	}
	
	//emulate IE mouseover and mouseout events, since they're very useful!
	private function ieMouseEvents(d:HTMLDocument):Void {
		var enterLeave = function(e:MouseEvent) {
			var pos=e.relatedTarget == null?-1:untyped __js__("e.target").compareDocumentPosition(e.relatedTarget);
			if (pos != 20 && pos != 0) {
				var evt:MouseEvent = untyped __js__("d.createEvent('MouseEvent')");
				evt.initMouseEvent('mouse'+(e.type=='mouseover'?'enter':'leave'), false, false, null, null, e.screenX, e.screenY, e.clientX, e.clientY,e.ctrlKey,e.altKey,e.shiftKey,e.metaKey,e.button,e.relatedTarget);
				untyped __js__("e.target.dispatchEvent(evt)");
			}
		};
		untyped __js__("d.addEventListener")('mouseover',enterLeave,false);
		untyped __js__("d.addEventListener")('mouseout',enterLeave,false);
	}
	
}


/**
 * Global exception handling for WebKit-based browsers.
 * Also adds support for window.addEventListener('error',errorHandler)
 * 
 * @author Cref
 */
private class WebKit extends Standard {
	
	private static function __init__() {
		var x = untyped __js__("document.createEvent")('Event');
		untyped __js__("x.initEvent")('error', true, true);
		//prevent default error handler from firing
		untyped Browser.window.onerror = null;
		untyped js.Boot.handleUncaughtException = function(e) {
			var d = getDetails(e);
			var prevent1 = js.Boot.globalExceptionHandler(e, d.url, d.line);
			var prevent2 = untyped __js__("!dispatchEvent")(x);
			if (!(prevent1 || prevent2)) throw e;
		};
		//untyped js.Boot.entry = wrapEntrypoint(Browser.window, untyped js.Boot.entry);
	}
	/*
	public override function initWindow(w:Window):Window {
		var t = untyped w.setTimeout;
		untyped w.setTimeout = function(f,m) return t(wrapEntrypoint(w, cast f),m);
		var i = untyped w.setInterval;
		untyped w.setInterval = function(f, m) return i(wrapEntrypoint(w, cast f), m);
		return super.initWindow(w);
	}
	
	private static function wrapEntrypoint(w:Window, fn:Function < Dynamic, Dynamic >):Function < Dynamic, Dynamic > {
		return cast function() {
			try {
				return fn.apply(w, untyped Function.arguments);
			}
			catch (e:Error) {
				var d = getDetails(e);
				var doDefault = untyped __js__("!w.onerror") || !untyped w.onerror(e.message, d.url, d.line);
				var tmp = untyped __js__("w.onerror");untyped w.onerror = function() w.onerror = tmp;
				if (w.dispatchEvent(ex) && doDefault) throw(e);
				return;
			}
		};
	}
	*/
	
	//we could also make a Chrome class and a Safari class but lets just keep it simple
	private static function getDetails(e:Error<Dynamic>):{url:String,line:Int} {
		try{
			//Safari:
			if (untyped e.line) return { url:untyped e.sourceURL, line:untyped e.line };
			//Chrome:
			var info:String = untyped e.stack;
			var infoArr = info.after('(').before(')').split(':');
			return { url:infoArr[0] + ':' + infoArr[1], line:untyped parseInt(infoArr[2]) };
		}
		catch (e:Dynamic) {
			return {url:'',line:-1}
		}
	}
	
}

/**
 * TODO: some versions of Opera incorrectly handle some events
 * @author Cref
 */
private class Opera extends Standard {
	
}

/**
 * Emulates W3C DOM Events and fixes various CSS properties such as opacity, cssFloat... (more)
 * @author Cref
 */
/**
 * patch for IE event model
 * http://msdn.microsoft.com/en-us/library/ms535863(VS.85).aspx
 * IE9 will implement DOM Events level 3 support
 * 
 * Note:
 * Always make sure an event is created with createEvent before binding to it using addEventListener.
 * 
 * @author Cref
 */
private class IE8 implements DOM {
	
	public function patchStyleSheet(stylesheet:CSSStyleSheet, flags:Int):Void {
		//fixes opacity and cssFloat
		//if (flags & DOM.patchBasics>0) {
			//setOpacity(s:CSSStyleDeclaration, v);
		//}
	}
	
	function clear(e:HTMLElement):Void {
		var tmp = e.ownerDocument.createElement('t');
		while (e.childNodes.length>0) tmp.appendChild(e.firstChild);
	}

	public function createStyleRule(stylesheet:CSSStyleSheet, selector:String):CSSStyleRule {
		#if debug
		if (selector.indexOf(',') > -1) throw('IE<9 doesn\'t like the comma in: '+selector);
		#end
		untyped stylesheet.addRule(selector,'_:0');//bugfix (IE<9?): sommige stijlen worden niet doorgevoerd als ze de eerste zijn dus altijd een dummy stijl als eerste schrijven
		return untyped stylesheet.rules[stylesheet.rules.length-1];
	}
	
	public function styleAttr(s:CSSStyleDeclaration, n:String, ?v:String):String {
		var doSet = ES5.arguments.length > 2,r;
		//trace(n);
		switch(n) {
			case 'textShadow':
				//http://samples.msdn.microsoft.com/workshop/samples/author/filter/shortSamples/dropShadowEX1.htm
				if (doSet) {
					//TODO
					//setFilter(s,"progid:DXImageTransform.Microsoft.DropShadow(OffX=5, OffY=5, Color='gray', Positive='true')");
				}
				return v;
			case 'boxShadow':
				if (doSet) {
					//TODO
					//setFilter(s,"progid:DXImageTransform.Microsoft.Shadow(color='#969696', Direction=135, Strength=3)");
					//zie ook http://markusstange.wordpress.com/2009/02/15/fun-with-box-shadows/
					//het DropShadow filter kan gebruikt worden voor solid shadows
					//voor een goede boxShadow met verloop kan een nieuw element met Blur filter worden toegevoegd
					//deze oplossing ondersteunt ook nog rounded corners http://code.google.com/p/box-shadow/
					//http://www.useragentman.com/blog/2010/05/06/csssandpaper-now-supports-transform-translate-and-rgba-gradients/
				}
				return v;
			case 'opacity':
				if (doSet) return setOpacity(s,v);
				else {
					var op = untyped s.filter.indexOf('opacity=');
					return op<0?'':''+Std.parseInt(untyped s.filter.substr(op+8))/100;
				}
			case 'cssFloat':
				if (doSet) untyped s.styleFloat = v;
				return untyped s.styleFloat;
			default:
				if (doSet) try {
					untyped s[n] = v;
				}
				catch (e:Dynamic) {
					//#if debug
					trace('unsupported style: ' + n);
					//#end
				}
				return untyped s[n];
		}
	}
	
	private static function setFilter(s:CSSStyleDeclaration,v:String):String {
		if (!untyped s.hasLayout) untyped s.zoom = 1;
		untyped s.filter = v;
		return v;
	}
	
	private static function setOpacity(s:CSSStyleDeclaration, v:String) {
		return setFilter(s,'Alpha(opacity=' + (Std.parseFloat(v) * 100) + ')');
	}
	
	/*
	private static var customEventTypes:Dynamic<Dynamic> = { };
	//propertychange wordt niet uitgevoerd voor expando's van window of document,
	//vandaar dat we voor een window het head element gebruiken en voor document het html element.
	//het is wellicht netter om hiervoor verborgen elementen aan te maken.
	//todo: ook bruikbaar maken voor eigen objecten (is nu alleen bedoeld voor window, document en element)
	public function getTarget(o:Dynamic):Dynamic untyped {
		return o.tagName
			?o
			:o.documentElement
				?o.documentElement
				:o.document.documentElement.firstChild
		;
	}
	public inline function addEventListener(o:Dynamic, t:String, f:Dynamic->Void, ?c:Bool):Void x(o,t,f,c,true)
	public inline function removeEventListener(o:Dynamic, t:String, f:Dynamic, ?c:Bool):Void x(o,t,f,c,false)
	private function x(o:Dynamic, t:String, f:Dynamic->Void, ?c:Bool,attach:Bool):Void untyped {
		if (c) throw 'capture phase not implemented for IE';//JDC might offer a solution but for now, only use bubble phase
		var
			fId=hxtc.Tools.getInstanceId(cast f),
			//IE8 in IE7 mode has window.onhashchange but doesn't use it so we ignore this fact
			isCustom=__js__("!('on'+t in o)") || (t=='hashchange'&&Browser.ieVersion<8),
			h=t+fId+';',
			v = isCustom?getTarget(o):o
		;
		if (attach){
			if (!v._bubble) v._bubble=h;
			else{
				if (v._bubble.indexOf(h)>-1) return;
				v._bubble+=h;
			}
		}
		else v._bubble = v._bubble?v._bubble.replace(h, ''):'';
		v[(attach?'at':'de') + 'tachEvent']('on' + (isCustom?'propertychange':t), v[fId] || (v[fId] = function() {
			if (!isCustom || (event.propertyName == 'customEvent' && event.srcElement.customEvent == t)) {
				var e = isCustom?customEventTypes[t]:event;
				if (e.type==null) e.type = event.srcElement.customEvent;
				e.target = e.srcElement||o;
				e.currentTarget = o;
				e.relatedTarget = t == 'mouseout'?e.toElement:e.fromElement;
				e.eventPhase = e.target == v?Event.AT_TARGET:Event.BUBBLING_PHASE;//TODO: checken
				e.timeStamp = __js__("new Date()");
				f.call(o,e);
			}
		}));
	}
	*/
	/*
	public function dispatchEvent(o:Dynamic, e:Dynamic):Bool {
		untyped customEventTypes[e.type]?getTarget(o).customEvent = e.type:o.fireEvent('on' + e.type, e);
		return true;//TODO: If preventDefault was called the value is false, else the value is true.
	}
	
	public function createEvent<Target,CurrentTarget>(d:HTMLDocument, eventModule:String):Event<Target,CurrentTarget> return untyped __js__("d.createEventObject")()
	public function initEvent(e:Event<Dynamic,Dynamic>, t:String, b:Bool, c:Bool):Void untyped {
		e.type = t;
		e.bubbles=b;
		e.cancelable=c;
		customEventTypes[t]=this;
	}
	public function preventDefault(e:Event<Dynamic,Dynamic>):Void untyped {
		if (e.cancelable!=false) e.defaultPrevented = e.returnValue = false;
	}
	public function stopPropagation(e:Event<Dynamic,Dynamic>):Void untyped e.cancelBubble = true
	
	//support hxtc.dom.CustomEventDispatcher:
	//private static function t(e:Dynamic):Void return untyped __js__("e.target.target||e.target")
	//NodeSelector:
	public function querySelector(n:HTMLNode<Dynamic>,query:String):HTMLElement<Dynamic> return untyped __js__("n.querySelector")(query)
	public function querySelectorAll(n:HTMLNode<Dynamic>, query:String):NodeList<HTMLElement<Dynamic>> return untyped __js__("n.querySelectorAll")(query)
	
	
	public var styleSheet:CSSStyleSheet;
	
	private var w:Window;
	private var d:HTMLDocument;
	
	static var ns = 'v';// 'DD_roundies';
	/* TODO: DD_roundies
	static var evml = ['color','image','stroke'];
	static var borders = ['Top', 'Right', 'Bottom', 'Left'];
	static var dims = ['Left', 'Top', 'Width', 'Height'];
	*/

	public function initWindow(w:Window):Window {
		var w = w, d = w.document;
		initGlobalCSS(untyped d.createStyleSheet());
		return w;
	}
	
	//make IE's default styles match the standard
	private function initGlobalCSS(s:CSSStyleSheet) untyped {
		s.addRule('textarea', 'overflow-y:auto');
		//s.addRule(ns + '\\:', '{behavior:url(#default#VML)}');
	}
}

/**
 * Fixes for IE<8:
 * - corrects boxmodel
 * - patches various quirks
 * - adds support for hash changes in history
 * - adds hashchange event
 * - 
 * 
 * Contains code from DD_roundies for emulating rounded corners and for emulating transparent PNG's in IE<7:
 * DD_roundies, this adds rounded-corner CSS in standard browsers and VML sublayers in IE that accomplish a similar appearance when comparing said browsers.
 * Author: Drew Diller
 * Email: drew.diller@gmail.com
 * URL: http://www.dillerdesign.com/experiment/DD_roundies/
 * Version: 0.0.2a
 * Licensed under the MIT License: http://dillerdesign.com/experiment/DD_roundies/#license
 * 
 * @author Cref
 */
private class IE7 extends IE8 {
	
	public override function patchStyleSheet(stylesheet:CSSStyleSheet, flags:Int):Void {
		super.patchStyleSheet(stylesheet, flags);
	}
	
	static var fixes:Array < HTMLElement->Void > = [];
	
	public override function createStyleRule(stylesheet:CSSStyleSheet, selector:String):CSSStyleRule {
		//TODO: IE<8 :active emuleren via behavior
		//IE>6 voegt zoveel rules in als er komma-gescheiden selectors worden meegegeven,
		//IE6 vindt het een ongeldig argument. vandaar de split:
		//IE<8 CSS bugs: http://www.satzansatz.de/cssd/pseudocss.html
		//IE7 selectors support: http://www.evotech.net/blog/2007/05/ie7-css-selectors-how-they-fail/
		if (selector.indexOf(':first-letter')>-1) selector=untyped selector.replace(__js__("/:first-letter/"),':first-letter ');
		if (selector.indexOf(':first-line')>-1) selector=untyped selector.replace(__js__("/:first-line/"),':first-line ');
		//	if (selector.indexOf(':before')>-1) selector=selector.replace(/:before/,'.not-supported');
		//	if (selector.indexOf(':after')>-1) selector=selector.replace(/:after/,'.not-supported');
		return super.createStyleRule(stylesheet,selector);
	}
	
	private override function initGlobalCSS(css:CSSStyleSheet) untyped {
		//fix Quirks mode:
		//TODO: owningElement inlined as ownerNode in CSSStyleSheet class
		var d = css.owningElement.ownerDocument;
		d.autoFix = [];
		css.addRule('html','overflow:hidden');
		if (d.compatMode == 'CSS1Compat') {
			//fix: make IE<8 obey zIndexes:
			css.addRule('.zfix', 'z-index:-1');
			//fix: forces hasLayout for IE<8 so hovers will work correctly.
			//CAUTION! IE6 freezes completely when unknown CSS operators are being used!
			css.addRule('.zfix'+(Browser.ieVersion<7?' ':'>')+'*','zoom:1');
			css.addRule('.inputfix', 'border-width:2px;padding:1px;margin:0px');
			d.autoFix.push(correctBoxModel);
		}
		//add behaviors to stylesheet so newly added elements will be fixes automagically
		if (d.autoFix.length > 0) {
			//the selectors to which the fixes are applied (no span tags: would probably result in too much overhead)
			var selectors = ['body', 'a', 'div', 'img', 'form', 'p', 'input'];
			//TODO: test for sub-windows
			for (sel in selectors) untyped css.addRule(sel,'behavior:expression($DOM.fixElement(this))');
		}
	}
	
	function fixElement(e:HTMLElement) {
		//prevent fixElement to fire more than once
		untyped e.runtimeStyle.behavior = 'none';
		//apply all required fixes
		var fixes:Array < HTMLElement->Void >= untyped e.ownerDocument.autoFix;
		for (f in fixes) f(e);
	}
	
	//recalculates dimensions for an element, emulating box-sizing:border-box in standards mode
	static function correctBoxModel(e:HTMLElement):Void untyped {
		if (e.currentStyle.boxSizing != 'border-box' || e.type == 'submit') return;//ignore submit, has weird scaling
		if (e.currentStyle.position=='absolute') e.className='zfix '+e.className;
		if (e.tagName == 'INPUT'/*||e.tagName=='SELECT'*/) e.className = 'inputfix ' + e.className;
		updateBorderBox(e,'width','Left','Right');
		updateBorderBox(e, 'height', 'Top', 'Bottom');
	}
	
	static function getStyle(e:HTMLElement,n:String) {
		if (e.tagName=='INPUT'){//inputs hebben een apart border gedrag in IE
			var m=untyped n.match(__js__("/border(.*)Width/"));
			if (untyped m&&e.currentStyle['border'+m[1]+'Style']=='none') return 0;
		}
		return untyped parseInt(e.currentStyle[n])||0;
	}
	
	static function updateBorderBox(e:HTMLElement,ldim:String,side1:String,side2:String) untyped {
		e.runtimeStyle[ldim]='';
		var cs=e.currentStyle;
		var csdim=cs[ldim],csdimInt=parseInt(csdim)||0;
		if (isNaN(csdimInt)||(cs[ldim]=='100%' && cs.styleFloat=='none' && (e.tagName!='INPUT'/*||e.tagName!='SELECT'*/))) e.runtimeStyle[ldim]='auto';
		if (csdim != 'auto' && csdim.indexOf('px') > -1) {
			e.runtimeStyle[ldim] = Math.max(0,
				csdimInt -
				getStyle(e,'border'+side1+'Width') -
				getStyle(e, 'border'+side2+'Width') -
				getStyle(e, 'padding'+side1) - 
				getStyle(e, 'padding'+side2)
			) + 'px';
		}
		//if (ldim=='width') e.title=csdim+'>'+e.runtimeStyle[ldim];
	}
	
	
	//public override function querySelector(n:HTMLNode<Dynamic>, query:String):HTMLElement<Dynamic> return untyped Sizzle.query(query,n)[0]
	//public override function querySelectorAll(n:HTMLNode<Dynamic>, query:String):NodeList<HTMLElement<Dynamic>> return untyped Sizzle.query(query,n)
}



/**
 * IE6 patches
 * XMLHttpRequest, PNG, pseudo-classes...
 * hover all elements
 */
private class IE6 extends IE7 {
	
	public override function patchStyleSheet(stylesheet:CSSStyleSheet, flags:Int):Void {
		//fixes PNG transparency using DD_roundies (or DD_corners?)
		//TODO: when that works: check if rounded corners also really work and apply that part to IE7 and 8 as well
		//if (flags & DOM.patchPNG > 0) {
			//untyped alert('IE6 patch');
		//}
		//if (flags & DOM.patchHover > 0) {}//TODO: apply this fix by default to all stylesheets (generates hover classes for eacht :hover pseudo-class)
		super.patchStyleSheet(stylesheet, flags);
	}
	
	private function hoverListener(e:MouseEvent) {
		e.currentTarget.switchClass('hover', e.type == 'mouseenter');
	}
	
	private function overListener(e:MouseEvent) {
		/* TODO: move to haxetacy?
		var el:HTMLElement = e.target;
		//we need this loop because mouseover will only fire for elements the mouse cursor can 'touch'
		while (el != e.currentTarget && !el.hasClass('hover')) {
			if (el.tagName != 'A' && untyped !el._hovers) {
				el.switchClass('hover', untyped el._hovers = true);
				el.addEventListener('mouseenter', hoverListener,false);
				el.addEventListener('mouseleave', hoverListener,false);
			}
			el = el.parentNode;
		}
		*/
	}
	
	public override function initWindow(w:Window):Window {
		//emulate :hover
		w.document.documentElement.addEventListener('mouseover', overListener,false);
		//check out http://misterpixel.blogspot.com/2006/09/forensic-analysis-of-ie6.html
		untyped w.document.execCommand("BackgroundImageCache", false, true);
		//TODO: disable browser cache for XMLHttpRequest (querystring) since IE6 has problems using cache combined with compression
		return super.initWindow(w);
	}
	
	private override function initGlobalCSS(css:CSSStyleSheet) {
		super.initGlobalCSS(css);
		//TODO: put global IE6 CSS patches here
		untyped css.addRule('html','border:none');
		//untyped css.addRule('.hover','border:1px solid red');
	}
	
}


//END BROWSER PATCHES
