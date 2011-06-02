package jstm;

import hxtc.dom.style.Selector;
/*
 * TODO: hover, pseudo-classes, global CSS
 * */
class IE6__ extends IE7__ {
	
	public function new(w:Window) untyped {
		var d = w.document;
		//check out http://misterpixel.blogspot.com/2006/09/forensic-analysis-of-ie6.html
		d.execCommand("BackgroundImageCache", false, true);
		//native DOM functions do not support apply so now they do
		__js__("
		d.cEl = d.createElement;
		d.createElement = function(n){return this.cEl(n)};
		d.cEv = d.createEventObject;
		d.createEventObject = function(){return this.cEv()};
		");
		super(w);
	}
	
	//TODO: add all css patches
	override function fixGlobalStyle(css:CSSStyleSheet) {
		untyped css.addRule('html','border:none');
		super.fixGlobalStyle(css);
	}
}