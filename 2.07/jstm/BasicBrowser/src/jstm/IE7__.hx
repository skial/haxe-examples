package jstm;

import hxtc.dom.style.Selector;

using hxtc.Tools;
using hxtc.use.ForString;

class IE7__ extends IE8__ {
	
	public function new(w:Window) {
		var d:IEDocument = cast w.document;
		var ElP = { },EvP = { };//TODO: experiment by using elements with propertychange events as prototypes for live prototype extension!
		untyped {
			w.Window = { prototype:w };
			w.HTMLDocument = { prototype:d };
			w.Element = { prototype: ElP };
			w.Event = { prototype: EvP };
			//TODO: add more constructors
		}
		var elmPatcher:HTMLElement->HTMLElement=null;
		var opc = function() {
			var el:HTMLElement = untyped event.srcElement;
			if (untyped event.propertyName == 'innerHTML') {
				for (e in el.getElementsByTagName('*')) elmPatcher(e);
				//trace('ihc');
			}
		}
		//patches an elements
		elmPatcher = function(e:HTMLElement):HTMLElement {
			untyped e.attachEvent('onpropertychange',opc);
			return e.ext(ElP);
		}
		d.createEventObject.patch(function(ce:Void->Event) return function() return ce().ext(EvP));
		//TODO: patch element properties such as firstChild etc.
		d.createElement.patch(function(ce:String->HTMLElement) return function(n:String):HTMLElement return elmPatcher(ce(n)));
		elmFixes = [];
		super(w);
		//patch all existing elements
		for (e in d.all) elmPatcher(e);
		hashHistory(w);
	}
	
	var elmFixes:Array<HTMLElement->Void>;
	
	//TODO: per window
	
	override function fixGlobalStyle(css:CSSStyleSheet) untyped {
		super.fixGlobalStyle(css);
		//fix Quirks mode:
		//TODO: owningElement inlined as ownerNode in CSSStyleSheet class
		css.addRule('html','overflow:hidden');
		if (w.document.compatMode == 'CSS1Compat') {
			//fix: make IE<8 obey zIndexes:
			css.addRule('.zfix', 'z-index:-1');
			//fix: forces hasLayout for IE<8 so hovers will work correctly.
			//CAUTION! IE6 freezes completely when unknown CSS operators are being used!
			css.addRule('.zfix'+(Host.ieVersion<7?' ':'>')+'*','zoom:1');
			css.addRule('.inputfix', 'border-width:2px;padding:1px;margin:0px');
			elmFixes.push(correctBoxModel);
		}
		//add behaviors to stylesheet so newly added elements will be fixes automagically
		//the selectors to which the fixes are applied (no span tags: would probably result in too much overhead)
		var selectors = ['body', 'a', 'div', 'img', 'form', 'p', 'input'],fxs = elmFixes;
		//TODO: test for sub-windows
		jstm.fixElement = function(e:HTMLElement) {
			//prevent fixElement to fire more than once
			untyped e.runtimeStyle.behavior = 'none';
			//apply all required fixes
			for (f in fxs) f(e);
		};
		for (sel in selectors) untyped css.addRule(sel,'behavior:expression(jstm.fixElement(this))');
	}
	
	//recalculates dimensions for an element, emulating box-sizing:border-box in standards mode
	static function correctBoxModel(e:HTMLElement):Void untyped {//return;
		//e.title = e.currentStyle.boxSizing;
		//e.style.border = '1px solid red';
		if (/*e.currentStyle.boxSizing != 'border-box' ||*/ e.type == 'submit') return;//ignore submit, has weird scaling
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
			f.detachEvent(ol,ES5.arguments.callee);//skip first time
			update();
			f.attachEvent(ol,function() l.hash = f.contentWindow.document.body.innerText);
		});
		w.addEventListener('hashchange', update,false);
	}
}

typedef IEDocument = { > HTMLDocument,
	public function createEventObject():Dynamic;
	public var all(default,never):NodeList<HTMLElement>;
}