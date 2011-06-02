/**
* DD_roundies, this adds rounded-corner CSS in standard browsers and VML sublayers in IE that accomplish a similar appearance when comparing said browsers.
* Author: Drew Diller
* Email: drew.diller@gmail.com
* URL: http://www.dillerdesign.com/experiment/DD_roundies/
* Version: 0.0.2a
* Licensed under the MIT License: http://dillerdesign.com/experiment/DD_roundies/#license
*
* Usage:
* DD_roundies.addRule('#doc .container', '10px 5px'); // selector and multiple radii
* DD_roundies.addRule('.box', 5, true); // selector, radius, and optional addition of border-radius code for standard browsers.
* 
* Just want the PNG fixing effect for IE6, and don't want to also use the DD_belatedPNG library?  Don't give any additional arguments after the CSS selector.
* DD_roundies.addRule('.your .example img');
**/

package com.dillerdesign;

import js.browser.Browser;
import org.w3c.dom.html.Window;
import org.w3c.dom.html.HTMLDocument;
import org.w3c.dom.html.HTMLElement;
import org.w3c.dom.html.HTMLImageElement;
import org.w3c.dom.css.CSSStyleSheet;//should really be IE_CSSStyleSheet

class DD_roundies {
	
	static var ns = 'DD_roundies';
	static var evml = ['color','image','stroke'];
	static var borders = ['Top', 'Right', 'Bottom', 'Left'];
	static var dims = ['Left', 'Top', 'Width', 'Height'];
	
	var ie8sel:Array<{ selector:String, radii:Array<Int> }>;
	var imgSize:Dynamic;

	//initializes the window/document for rounded corners support
	public function new(w:Window,styleSheet:CSSStyleSheet) {
		var d = w.document;
		ie8sel = [];
		imgSize = {};
		//enable VML
		switch(Browser.ieVersion) {
			case 6, 7: untyped d.namespaces.add(ns, 'urn:schemas-microsoft-com:vml');
			//won't work... find dynamic alternative
			case 8: d.writeln('<?import namespace="' + ns + '" implementation="#default#VML" ?>');
		}
		//style VML, enable behaviors
		untyped ss.addRule(ns + '\\:*', '{behavior:url(#default#VML)}');
		untyped __js__("hxtc.roundify = roundify");
		
		//rounded corners for IE8:
		if (js.browser.Browser.ieVersion == 8) {
			var sel = ie8sel;
			untyped d.attachEvent('onreadystatechange', function() {
				if (d.readyState != 'complete') return;
				for (s in sel) {
					//IE8 doesn't like to do this to inputs yet (could this be taken care of in the selector?)
					for (e in d.querySelectorAll(s.selector)) if (e.nodeName != 'INPUT') roundify(e, radii);
				}
			});
		}
		
	}


	

	
	
	/**
	* Method to use from afar - refer to it whenever.
	* Example for IE only: DD_roundies.addRule('div.boxy_box', '10px 5px');
	* Example for IE, Firefox, and WebKit: DD_roundies.addRule('div.boxy_box', '10px 5px', true);
	* @param {String} selector - REQUIRED - a CSS selector, such as '#doc .container'
	* @param {Integer} radius - REQUIRED - the desired radius for the box corners
	**/
	static function addRule(ss:CSSStyleSheet,selector:String, rad:String='0') untyped {
		rad = rad.replace(untyped __js__("/[^0-9 ]/g"), '').split(' ');
		for (i in 0...4) rad[i] = (!rad[i] && rad[i] != 0) ? rad[Math.max((i-2), 0)] : rad[i];
		if (Browser.ieVersion==8) ie8sel.push( { selector:selector, radii:cast rad } );
		else {
				var selectors = selector.split(','); /* multiple selectors supported, no need for multiple calls to this anymore */
				for (s in selectors) {
					ss.addRule(s, 'behavior:expression(hxtc.roundify(this, [' + rad.join(',') + ']))'); /* seems to execute the function without adding it to the stylesheet - interesting... */
				}
			/* STANDARDS:
				var moz_implementation = rad.join('px ') + 'px';
				ss.appendChild(d.createTextNode(selector + ' {border-radius:' + moz_implementation + '; -moz-border-radius:' + moz_implementation + ';}'));
				ss.appendChild(d.createTextNode(selector + ' {-webkit-border-top-left-radius:' + rad[0] + 'px ' + rad[0] + 'px; -webkit-border-top-right-radius:' + rad[1] + 'px ' + rad[1] + 'px; -webkit-border-bottom-right-radius:' + rad[2] + 'px ' + rad[2] + 'px; -webkit-border-bottom-left-radius:' + rad[3] + 'px ' + rad[3] + 'px;}'));
			*/
		}
	}
	
	static function readPropertyChanges(el:HTMLElement) untyped {
		switch (untyped event.propertyName) {
			case 'style.border','style.borderWidth','style.padding':
				applyVML(el);
			case 'style.borderColor':
				vmlStrokeColor(el);
			case 'style.backgroundColor','style.backgroundPosition','style.backgroundRepeat':
				applyVML(el);
			case 'style.display':
				el.vmlBox.style.display = (el.style.display == 'none') ? 'none' : 'block';
			case 'style.filter':
				vmlOpacity(el);
			case 'style.zIndex':
				el.vmlBox.style.zIndex = el.style.zIndex;
		}
	}
	
	static function applyVML(el:HTMLElement) {
		untyped el.runtimeStyle.cssText = '';
		vmlFill(el);
		vmlStrokeColor(el);
		vmlStrokeWeight(el);
		vmlOffsets(el);
		vmlPath(el);
		nixBorder(el);
		vmlOpacity(el);
	}
	
	static function vmlOpacity(el:HTMLElement) untyped {
		if (el.currentStyle.filter.search('lpha') != -1) {
			var trans = el.currentStyle.filter;
			trans = parseInt(trans.substring(trans.lastIndexOf('=')+1, trans.lastIndexOf(')')), 10)/100;
			for (v in evml) el.vml[v].filler.opacity = trans;
		}
	}
	
	static function vmlFill(el:HTMLElement) untyped {
		if (el.currentStyle==null) return;
		var elStyle = el.currentStyle;
		el.runtimeStyle.backgroundColor = '';
		el.runtimeStyle.backgroundImage = '';
		var noColor = (elStyle.backgroundColor == 'transparent');
		var noImg = true;
		if (elStyle.backgroundImage != 'none' || el.isImg) {
			if (!el.isImg) {
				el.vmlBg = elStyle.backgroundImage;
				el.vmlBg = el.vmlBg.substr(5, el.vmlBg.lastIndexOf('\")')-5);
			}
			else {
				el.vmlBg = el.src;
			}
			if (!imgSize[untyped el.vmlBg]) { /* determine size of loaded image */
				var img:HTMLImageElement = d.createElement('img');
				untyped img.attachEvent('onload', function() {
					img.width = img.offsetWidth; /* weird cache-busting requirement! */
					img.height = img.offsetHeight;
					vmlOffsets(el);
				});
				img.className = ns + '_sizeFinder';
				untyped img.runtimeStyle.cssText = 'behavior:none; position:absolute; top:-10000px; left:-10000px; border:none;'; /* make sure to set behavior to none to prevent accidental matching of the helper elements! */
				img.src = el.vmlBg;
				img.removeAttribute('width');
				img.removeAttribute('height');
				d.body.insertBefore(img, d.body.firstChild);
				imgSize[untyped el.vmlBg] = img;
			}
			untyped el.vml.image.filler.src = el.vmlBg;
			noImg = false;
		}
		el.vml.image.filled = !noImg;
		el.vml.image.fillcolor = 'none';
		el.vml.color.filled = !noColor;
		el.vml.color.fillcolor = elStyle.backgroundColor;
		el.runtimeStyle.backgroundImage = 'none';
		el.runtimeStyle.backgroundColor = 'transparent';
	}
	
	static function vmlStrokeColor(el:HTMLElement) {
		untyped el.vml.stroke.fillcolor = el.currentStyle.borderColor;
	}
	
	static function vmlStrokeWeight(el:HTMLElement) untyped {
		el.bW = {};
		for (b in 0...4) el.bW[borders[b]] = parseInt(el.currentStyle['border' + borders[b] + 'Width'], 10) || 0;
	}
	
	static function vmlOffsets(el:HTMLElement) untyped {
		for (d in 0...4) el.dim[dims[d]] = el['offset'+dims[d]];
		var assign = function(obj, topLeft) {
			obj.style.left = (topLeft ? 0 : el.dim.Left) + 'px';
			obj.style.top = (topLeft ? 0 : el.dim.Top) + 'px';
			obj.style.width = el.dim.Width + 'px';
			obj.style.height = el.dim.Height + 'px';
		};
		for (v in evml) {
			var mult = (v == 'image') ? 1 : 2;
			el.vml[v].coordsize = (el.dim.Width*mult) + ', ' + (el.dim.Height*mult);
			assign(el.vml[v], true);
		}
		assign(el.vmlBox, false);
		
		if (Browser.ieVersion==8) {
			el.vml.stroke.style.margin = '-1px';
			if (el.bW == null) vmlStrokeWeight(el);
			el.vml.color.style.margin = (el.bW.Top-1) + 'px ' + (el.bW.Left-1) + 'px';
		}
	}
	
	static function vmlPath(el:HTMLElement) untyped {
		var coords = function(direction, w, h, r, aL, aT, mult) {
			var cmd = direction ? ['m', 'qy', 'l', 'qx', 'l', 'qy', 'l', 'qx', 'l'] : ['qx', 'l', 'qy', 'l', 'qx', 'l', 'qy', 'l', 'm']; /* whoa */
			aL *= mult;
			aT *= mult;
			w *= mult;
			h *= mult;
			var R = r.slice(); /* do not affect original array */
			for (i in 0...4) {
				R[i] *= mult;
				R[i] = untyped __js__("Math.min(w/2, h/2, R[i])"); /* make sure you do not get funky shapes - pick the smallest: half of the width, half of the height, or current value */
			}
			var coords = [
				cmd[0] + Math.floor(0+aL) +','+ Math.floor(R[0]+aT),
				cmd[1] + Math.floor(R[0]+aL) +','+ Math.floor(0+aT),
				cmd[2] + Math.ceil(w-R[1]+aL) +','+ Math.floor(0+aT),
				cmd[3] + Math.ceil(w+aL) +','+ Math.floor(R[1]+aT),
				cmd[4] + Math.ceil(w+aL) +','+ Math.ceil(h-R[2]+aT),
				cmd[5] + Math.ceil(w-R[2]+aL) +','+ Math.ceil(h+aT),
				cmd[6] + Math.floor(R[3]+aL) +','+ Math.ceil(h+aT),
				cmd[7] + Math.floor(0+aL) +','+ Math.ceil(h-R[3]+aT),
				cmd[8] + Math.floor(0+aL) +','+ Math.floor(R[0]+aT)
			];
			if (!direction) {
				coords.reverse();
			}
			var path = coords.join('');
			return path;
		};
	
		if (el.bW == null) vmlStrokeWeight(el);
		var bW = el.bW;
		var rad = el.DD_radii.slice();
		
		/* determine outer curves */
		var outer = coords(true, el.dim.Width, el.dim.Height, rad, 0, 0, 2);
		
		/* determine inner curves */
		rad[0] -= Math.max(bW.Left, bW.Top);
		rad[1] -= Math.max(bW.Top, bW.Right);
		rad[2] -= Math.max(bW.Right, bW.Bottom);
		rad[3] -= Math.max(bW.Bottom, bW.Left);
		for (i in 0...4) rad[i] = Math.max(rad[i], 0);
		var inner = coords(false, cast el.dim.Width-bW.Left-bW.Right, cast el.dim.Height-bW.Top-bW.Bottom, rad, cast bW.Left, cast bW.Top, 2);
		var image = coords(true, cast el.dim.Width-bW.Left-bW.Right+1, cast el.dim.Height-bW.Top-bW.Bottom+1, rad, cast bW.Left, cast bW.Top, 1);
		
		/* apply huge path string */
		el.vml.color.path = inner;
		el.vml.image.path = image;
		el.vml.stroke.path = outer + inner;
		
		clipImage(el);
	}
	
	static function nixBorder(el:HTMLElement) untyped {
		var s = el.currentStyle;
		var sides = ['Top', 'Left', 'Right', 'Bottom'];
		for (i in 0...4) el.runtimeStyle['padding' + sides[i]] = __js__("(parseInt(s['padding' + sides[i]], 10) || 0) + (parseInt(s['border' + sides[i] + 'Width'], 10) || 0)") + 'px';
		el.runtimeStyle.border = 'none';
	}
	
	static function clipImage(el:HTMLElement) untyped {
		if (!el.vmlBg || !imgSize[el.vmlBg]) return;
		var thisStyle = el.currentStyle;
		var bg = {X:0,Y:0};
		var figurePercentage = function(axis:String, position:String) {
			var fraction = true;
			switch(position) {
				case 'left','top':
					bg[axis] = 0;
				case 'center':
					bg[axis] = 0.5;
				case 'right','bottom':
					bg[axis] = 1;
				default:
					if (position.search('%') != -1) {
						bg[axis] = parseInt(position, 10) * 0.01;
					}
					else {
						fraction = false;
					}
			}
			var horz = (axis == 'X');
			bg[axis] = Math.ceil(fraction ? (( el.dim[horz ? 'Width' : 'Height'] - (el.bW[horz ? 'Left' : 'Top'] + el.bW[horz ? 'Right' : 'Bottom']) ) * bg[axis]) - (imgSize[el.vmlBg][horz ? 'width' : 'height'] * bg[axis]) : parseInt(position, 10));
			bg[axis] += 1;
		};
		for (b in Reflect.fields(bg)) figurePercentage(b, thisStyle['backgroundPosition'+b]);
		el.vml.image.filler.position = (bg.X/(el.dim.Width-el.bW.Left-el.bW.Right+1)) + ',' + (bg.Y/(el.dim.Height-el.bW.Top-el.bW.Bottom+1));
		var bgR = thisStyle.backgroundRepeat;
		var c = {T:1, R:el.dim.Width+1, B:el.dim.Height+1, L:1}; /* these are defaults for repeat of any kind */
		var altC = { X: {b1: 'L', b2: 'R', d: 'Width'}, Y: {b1: 'T', b2: 'B', d: 'Height'} };
		if (bgR != 'repeat') {
			c = {T:(bg.Y), R:(bg.X+imgSize[el.vmlBg].width), B:(bg.Y+imgSize[el.vmlBg].height), L:(bg.X)}; /* these are defaults for no-repeat - clips down to the image location */
			if (bgR.search('repeat-') != -1) { /* now let's revert to dC for repeat-x or repeat-y */
				var v = bgR.split('repeat-')[1].toUpperCase();
				c[altC[v].b1] = 1;
				c[altC[v].b2] = el.dim[altC[v].d]+1;
			}
			if (c.B > el.dim.Height) {
				c.B = el.dim.Height+1;
			}
		}
		el.vml.image.style.clip = 'rect('+c.T+'px '+c.R+'px '+c.B+'px '+c.L+'px)';
	}
	
	static function pseudoClass(e:HTMLElement) {
		e.ownerDocument.defaultView.setTimeout(function() { /* would not work as intended without setTimeout */
			applyVML(e);
		}, 1);
	}
	
	static function reposition(e:HTMLElement) {
		vmlOffsets(e);
		vmlPath(e);
	}
	
	static var noSupport = { BODY: null, TABLE: null, TR: null, TD: null, SELECT: null, OPTION: null, TEXTAREA: null };
	static function roundify(e:HTMLElement, rad) untyped {
		untyped e.style.behavior = 'none';
		var thisStyle = untyped e.currentStyle;
		if (thisStyle==null) return;
		/* elements not supported yet */
		if (Reflect.hasField(noSupport,e.tagName)) return;
		untyped e.DD_radii = rad;
		untyped e.dim = {};

		/* attach handlers */
		var handlers = {resize: 'reposition', move: 'reposition'};
		if (e.tagName == 'A') {
			var moreForAs = {mouseleave: 'pseudoClass', mouseenter: 'pseudoClass', focus: 'pseudoClass', blur: 'pseudoClass'};
			for (a in Reflect.fields(moreForAs)) handlers[a] = moreForAs[a];
		}
		for (h in Reflect.fields(handlers)) {
			untyped e.attachEvent('on' + h, function() {
				DD_roundies[handlers[h]](e);
			});
		}
		untyped e.attachEvent('onpropertychange', function() {
			readPropertyChanges(e);
		});
		
		/* ensure that this elent and its parent is given hasLayout (needed for accurate positioning) */
		var giveLayout = function(el:HTMLElement) untyped {
			el.style.zoom = 1;
			if (el.currentStyle.position == 'static') el.style.position = 'relative';
		};
		giveLayout(e.offsetParent);
		giveLayout(e);
		
		/* create vml elements */
		e.vmlBox = d.createElement('ignore'); /* IE8 really wants to be encased in a wrapper element for the VML to work, and I don't want to disturb getElementsByTagName('div') - open to suggestion on how to do this differently */
		e.vmlBox.runtimeStyle.cssText = 'behavior:none; position:absolute; margin:0; padding:0; border:0; background:none;'; /* super important - if something accidentally matches this (you yourself did this once, Drew), you'll get infinitely-created elements and a frozen browser! */
		e.vmlBox.style.zIndex = thisStyle.zIndex;
		for (v in evml) {
			var t=e.vml[v] = d.createElement(ns + ':shape');
			t.filler = d.createElement(ns + ':fill');
			t.appendChild(t.filler);
			t.stroked = false;
			t.style.position = 'absolute';
			t.style.zIndex = thisStyle.zIndex;
			t.coordorigin = '1,1';
			e.vmlBox.appendChild(t);
		}
		e.vml.image.fillcolor = 'none';
		e.vml.image.filler.type = 'tile';
		e.parentNode.insertBefore(e.vmlBox, e);
		
		e.isImg = false;
		if (e.nodeName == 'IMG') {
			e.isImg = true;
			e.style.visibility = 'hidden';
		}
		
		e.ownerDocument.defaultView.setTimeout(function() {
			applyVML(e);
		}, 1);
	}
	
	
}