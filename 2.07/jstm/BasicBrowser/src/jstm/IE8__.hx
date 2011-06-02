/*
 * TODO: put css and stylesheet related patches here
 */
package jstm;

import hxtc.dom.style.Selector;

using ES5;
using hxtc.Tools;

class IE8__ extends IE9__ {
	
	var wp:Window;
	var dp:HTMLDocument;
	var ep:HTMLElement;
	
	public function new(w:Window) {
		super(w);
		untyped {
			//IE doesn't define HTMLElement
			w.HTMLElement = w.Element;
			//IE7 patcher could already have created HTMLDocument
			if (w.HTMLDocument==null) w.HTMLDocument = w.document.constructor;
			wp = w.Window.prototype;
			dp = w.HTMLDocument.prototype;
			ep = w.HTMLElement.prototype;
		}
		//display:none so css animations will run smoothly
		eWin.style.display = 'none';
		untyped d.defaultView = w;
		//enable styling of HTML5 elements (HTML5 shiv fix)
		//TODO: add standards compliant styles to stylesheet (e.g. datalist{display:none})
		var tagNames = 'abbr,article,aside,audio,canvas,datalist,details,eventsource,figure,footer,header,hgroup,mark,menu,meter,nav,output,progress,section,time,video'.split(',');
		for (n in tagNames) d.createElement(n);
		//elements in IE are crippled compared to real browser elements when not initially part of the DOM tree, this fixes this.
		//example: writing HTML5 elements through innerHTML won't work
		//always append to the dom so everything works as if IE was smart like the rest
		var t = this;
		d.createElement.patch(function(cE) {
			return function(n) {
				var e = cE(n);
				//IE only allows access to an input's type attribute before the element is appended to a parent!
				//so we can't fix input elements this way. might do this on type propertychange for inputs
				return e.tagName=='INPUT'?e:t.eWin.appendChild(e);
			}
		});
		//http://ajaxian.com/archives/the-vml-changes-in-ie-8
		//d.namespaces.add(ns, 'urn:schemas-microsoft-com:vml', "#default#VML");
		supportDOMEvents();
		//emulate userSelect style property
		d.addEventListener('selectstart', function(e:Event) {
			if (e.target.currentStyle.userSelect == 'none') e.preventDefault();
		},false);
		//add getElementsByClassName support
		untyped dp.getElementsByClassName = ep.getElementsByClassName = function(cls) {
			cls=StringTools.trim(cls);
			if (cls=='') return [];
			cls = cls.split(' ');
			var n=cls.length-1,all:Array<HTMLElement>=this.all,arr=[],re=RegExp.prototype.compile('(?:^|\\s)(?:'+cls.join('|')+')(?=\\s|$)','g');
			for(e in all){
				var m=e.className.match(re);
				if (m&&m.length>n) arr.push(e);
			}
			return arr;
		}
		fixGlobalStyle(d.createStyleSheet());
	}
	
	function fixGlobalStyle(css:CSSStyleSheet) {
		untyped css.addRule('textarea', 'overflow-y:auto');
	}
	
	/**
 * Requires prototype extending (JDC)
 * IE8 supports native prototype extending (including getters and setters) but still lacks the W3C Dom Event Model and still has some bugs.
 * http://msdn.microsoft.com/en-us/library/dd229916(VS.85).aspx
 * 
 * Every window has its own DOM constructors in IE so we have to extend prototypes on each window instance
 * 
 * @author Cref
 */
	function supportDOMEvents() {
		var customEventTypes = { };
		
		//the Window object doesn't have a propertychange event and
		//the Document object doesn't trigger this event for expando properties
		//so we use some elements for these. These MUST be within the documentElement to receive events!
		var eDoc=d.createElement('document');
		//get the element on which to emulate a custom event
			//WEIRD BUG!
			//(o == w) always returns false
			//(w == o) always returns true
		var d = this.d,eWin=this.eWin,w=this.w;
		var getTarget = function(o:Dynamic) { return untyped o.window?eWin:o == d?eDoc:o; };
		//createEvent:
		untyped dp.createEvent = function(className:String){
			var e=untyped this.createEventObject();
			e._cn=className;
			//TODO: extend based on className
			return e;
		};
		//dispatchEvent:
		untyped dp.dispatchEvent = ep.dispatchEvent = wp.dispatchEvent = function(e) {
			var t = untyped this;
			//e.target=t;
			//fireEvent can only be used to fire native (or behavior) events so we trigger an onpropertychange event for custom events
			(untyped __js__("!('on'+e.type in t)") || (e.type == 'hashchange' && Host.ieVersion < 8))?getTarget(t).customEvent = e.type:t.fireEvent('on' + e.type, e);
			return true;//TODO: If preventDefault was called the value is false, else the value is true.
		}
		
		// Apply addEventListener to all the prototypes where it should be available.
		//TODO: check for duplicate bindings (always trigger each listener only once)
		untyped dp.addEventListener = ep.addEventListener = wp.addEventListener = function (type, fCallback, capture) {
			//maybe I'll add this later but for now, we can easily live without the capture phase
			if (capture) throw new Error("capture phase is not supported");
			var t = untyped this;
			//TODO: combine with previous solution so everything works correctly again
			//add support for custom events
			untyped __js__("!('on'+type in t)") || (type == 'hashchange' && Host.ieVersion < 8)
				?getTarget(t).attachEvent('onpropertychange', function(e) {
					if (untyped e.propertyName == 'customEvent' && e.srcElement.customEvent == type) {
						var cEvent=untyped customEventTypes[type];
						cEvent.target = t;
						fCallback.call(t, cEvent);
					}
				})
				:t.attachEvent('on' + type, function (e) {
					e.target=e._ct?e._ct:e.srcElement;
					// Add some extensions directly to 'e' (the actual event instance)
					// Create the 'currentTarget' property (read-only)
					e.currentTarget=t;
					// Create the 'eventPhase' property (read-only)
					e.eventPhase=e.srcElement==t ? 2 : 3; // "AT_TARGET" = 2, "BUBBLING_PHASE" = 3
					// Create a 'timeStamp' (a read-only Date object)
					e.timeStamp = Date.now(); // The current time when this anonymous function is called.
					/* assigning a constructor is not allowed but we don't really need that anyway
					e.constructor = e._cn
						?w[e._cn]
						:(e.type.indexOf('mouse') > -1 || e.type.indexOf('click') > -1 || e.type.indexOf('wheel') > -1)//TODO: regexp
							?w.MouseEvent
							:w.Event//TODO: switch type
					;
					*/
					//TODO: for IE7 we should patch a function for these because IE8 always has these functions
					if (!e.preventDefault) {
						e.preventDefault = w.Event.prototype.preventDefault;
						e.stopPropagation = w.Event.prototype.stopPropagation;
					}
					// Call the function handler callback originally provided...
					fCallback.call(t, untyped e); // Re-bases 'this' to be correct for the callback.
				});
		}
		
		
		//TODO: removeEventListener, this is not the final solution!!!!! See TMP_DOM.hx
		untyped dp.removeEventListener = ep.removeEventListener = wp.removeEventListener = function (type, fCallback) this.detachEvent("on"+type,fCallback);

		var O = w.Object, Ep = w.Event.prototype;
		/* NOT SUPPORTED IN IE<8
		// Extend Event.prototype with a few of the W3C standard APIs on Event
		// Add 'target' object (read-only)
		O.defineProperty(Ep, 'target', {get: function() {
			return untyped this._ct?this._ct:this.srcElement;
		}});
		O.defineProperty(Ep, 'currentTarget', {get: function() {
			return untyped this.target;//TODO
		}});
		O.defineProperty(Ep, 'constructor', {get: function() untyped {
			if (this._cn) return window[this._cn];
			if (this.type.indexOf('mouse')>-1||this.type.indexOf('click')>-1||this.type.indexOf('wheel')>-1) return MouseEvent;
			switch(this.type){
				//TODO
				default: return Event;
			}
		}});
		*/
		// Add 'stopPropagation' and 'preventDefault' methods
		Ep.stopPropagation = function () untyped if (this.cancelable) this.cancelBubble = true;
		Ep.preventDefault = function () untyped this.returnValue = false;
		Ep.initEvent = function (type, bubbles, cancelable) untyped {
			this.type = type;
			this.bubbles = bubbles;
			this.cancelable = cancelable;
			customEventTypes[type] = this;//use true?
		};
		
		w.UIEvent=function(){};
		w.MouseEvent=function(){};
		w.KeyboardEvent=function(){};
		w.TextEvent=function(){};
		
		//TODO: add HTML5 element constructors (like HTMLVideoElement) (also for other browsers that don't support these elements)
		
	}
}