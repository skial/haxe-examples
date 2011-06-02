/**
 * Tools that make working with the DOM easier.
 * TODO: should use DOM interfaces and no native classes so all functions
 * will work both in the browser as well as on other platforms such as asp.
 * 
 * TIP:
 * using hxtc.dom.DOMTools;
 * 
 * @author Cref
 */
package hxtc.dom;

import hxtc.Tools;
import jstm.Host;
import hxtc.dom.style.Selector;
import Type;

class DOMTools {
	
	public static function setAttributes(e:HTMLElement,o:Dynamic):HTMLElement {
		var flds = Reflect.fields(o);
		//type attribute needs to be set before any other attribute in IE:
		if (o.type) e.setAttribute('type',o.type);
		for (n in flds) {
			if (n.toUpperCase() == e.tagName) continue;
			var v = o[untyped n];
			//switch(Type.typeof(v)) {
				//case ValueType.TFunction: untyped e[n]=v;
				//default:
					//'class' doesn't automatically translate to className and IE<8 doesn't understand r.setAttribute('className',v)
					n == 'className'
						?e.className = v
						:n == 'style'
							?e.style.cssText = v
							:n == 'type'
								?continue
								#if browser
								:untyped v.constructor == Function?e[n] = v
								#end
								:e.setAttribute(n,v);
			//}
		}
		return e;
	}
	
	public static function buildContent(e:HTMLElement, content:Array<Dynamic>):HTMLElement {
		var d = e.ownerDocument;
		for (c in content) {
			switch(Type.typeof(c)) {
				case ValueType.TObject: e.appendChild(c.tagName?c:buildElement(d, c));
				default:
					e.appendChild(d.createTextNode(untyped c));
			}
		}
		return e;
	}
	
	//builds elements from a JSON structure
	//TODO: make independent of document type and element type
	public static function buildElement(doc:HTMLDocument, obj:Dynamic):HTMLElement {
		var flds = Reflect.fields(obj);
		var tagName=null,content:Array<Dynamic>=null;
		for (n in flds) {
			var v = Reflect.field(obj,n);
			if (Std.is(v, Array)) {
				tagName = n;
				content = v;
				break;
			}
		}
		#if debug
		if (tagName == null) {
			trace(obj);
			throw "invalid markup syntax: usage: {tagName:['content'],attr:'value'}";
		}
		#end
		return buildContent(setAttributes(doc.createElement(tagName),obj),content);
	}
	
	//TODO: contains for IE. For standards compliant browsers, use:
	public static function contains(elm1:HTMLElement, elm2:HTMLElement) {
		return !!(untyped elm1.compareDocumentPosition(elm2) & 16);
	}
	
	public static function createStyleSheet(doc:HTMLDocument) {
		return sheet(doc, { style:[] } );
	}
	public static function loadStyleSheet(doc:HTMLDocument,?url:String,?autoFixes:Int) {
		var s = sheet(doc, { link:[], rel:'stylesheet', href:url } );
		//TODO: apply autoFixes for IE
		return s;
	}
	private static function sheet(doc:HTMLDocument,tag:Dynamic):CSSStyleSheet {
		var e = doc.documentElement.firstChild.appendChild(buildElement(doc, tag));
		return untyped e.sheet||e.styleSheet||doc.styleSheets[doc.styleSheets.length-1];
	}
	
	public static function createStyleRule(stylesheet:CSSStyleSheet, selector:String):CSSStyleRule {
		#if debug
		if (selector.indexOf(',') > -1) throw('IE<9 doesn\'t like the comma in: '+selector);
		#end
		if (Host.ieVersion > 0 && Host.ieVersion < 9) untyped {
			stylesheet.addRule(selector, '_:0');//bugfix (IE<9?): sommige stijlen worden niet doorgevoerd als ze de eerste zijn dus altijd een dummy stijl als eerste schrijven
			//This really sucks! IE6 can't access stylesheet.rules using cross-domain scripting!
			return stylesheet.rules[stylesheet.rules.length - 1];
		}
		return untyped stylesheet.cssRules[stylesheet.insertRule(selector + '{}', stylesheet.cssRules.length)];
	}
	public static function createStyle(stylesheet:CSSStyleSheet, selector:String):CSSStyleDeclaration return createStyleRule(stylesheet, selector).style
	
	//element tools:
	public static function remove(e:HTMLElement):HTMLElement {
		e.parentNode.removeChild(e);
		return e;
	}
	//swap is the same as replace
	//todo: check for nested elements
	public static function swap(e:HTMLElement,s:HTMLElement):HTMLElement{
		var p=e.parentNode;
		if (p!=null){
			var t=e.ownerDocument.createElement('t');
			p.insertBefore(t,e);
			s.parentNode.insertBefore(e,s);
			p.replaceChild(s,t);
		}
		else s.parentNode.replaceChild(e,s);
		return e;
	}
	public static function shift(e:HTMLElement,n:Int):HTMLElement{
		if (n!=0){
			var s=e;
			if (n<0){
				while (n < 0 && s.previousSibling != null) {
					s = s.previousSibling;
					n++;
				}
				s.parentNode.insertBefore(e,s);
			}
			else{
				while (n > 0 && s.nextSibling != null) {
					s = s.nextSibling;
					n--;
				}
				placeAfter(e,s);
			}
		}
		return e;
	}
	
	
	public static function moveToFirst(e:HTMLElement):HTMLElement {
		var p = e.parentNode;
		return p.insertBefore(e,p.firstChild);
	}
	
	public static function moveToLast(e:HTMLElement):HTMLElement {
		return e.parentNode.appendChild(e);
	}
	
	public static function moveTo(e:HTMLElement, i:Int):HTMLElement {
		var p = e.parentNode;
		var r = i<1?p.firstChild:i>p.childNodes.length?p.lastChild:p.childNodes[i];
		return p.insertBefore(e, r);
	}
	
	public static function moveBy(e:HTMLElement, step:Int):HTMLElement {
		if (step == 0 || step == null) return e;
		var r = e;
		if (step < 0) {
			while (step < 0 && r.previousSibling!=null) {
				r = r.previousSibling;
				step++;
			}
			placeBefore(e,r);
		}
		else {
			while (step > 0 && r.nextSibling!=null) {
				r = r.nextSibling;
				step--;
			}
			placeAfter(e,r);
		}
		return e;
	}
	
	public static function placeBefore(e:HTMLElement,b:HTMLElement):HTMLElement{
		b.parentNode.insertBefore(e,b);
		return e;
	}
	public static function placeAfter(e:HTMLElement,a:HTMLElement):HTMLElement{
		var p=a.parentNode;
		if (a==p.lastChild) p.appendChild(e);
		else p.insertBefore(e,a.nextSibling);
		return e;
	}
	public static function placeIn(e:HTMLElement,p:HTMLElement,?asFirst:Bool):HTMLElement{
	 if (p==null) p=e.parentNode;
	 asFirst && p.childNodes.length>0
		?p.insertBefore(e,p.firstChild)
		:p.appendChild(e);
	 return e;
	}
	public static function placeAround(e:HTMLElement,a:HTMLElement):HTMLElement {
		//TODO
		return e;
	}
	
	//removes all content from an element
	//TODO: solve in browser patch class
	public static function clear(e:HTMLElement):HTMLElement {
		Host.ieVersion>0?backupInner(e):e.innerHTML = '';
		return e;
	}
	
	//backup elements for IE
	static function backupInner(e:HTMLElement) {
		var ieEl = e.ownerDocument.documentElement.lastChild;
		while (e.lastChild!=null) ieEl.appendChild(e.lastChild);
	}
	/**
	 * 
	 * @param	e
	 * @param	?parent		larger than 0, goes up the tree this amount of steps
	 * @param	?sibling	positive or negative, moves left or right this amount of steps
	 * @param	?child		goes to child for each Int in the array where 0 is no child, 1 is first child, -1 is last child etc.
	 * @return
	 */
	public static function getRelative(e:HTMLElement,?parent:Int,?sibling:Int,?child:Array<Int>):HTMLElement {
		if (parent != null && parent > 0) while (parent > 0) {
			e = e.parentNode;
			parent--;
		}
		if (sibling!=null) {
			if (sibling < 0) while (sibling < 0) {
				e = e.previousSibling;
				sibling++;
			}
			else while (sibling > 0) {
				e = e.nextSibling;
				sibling--;
			}
		}
		if (child!=null) for (c in child) {
			if (c == null || c == 0) continue;
			e = e.childNodes[c-1+(c<0?e.childNodes.length:0)];
		}
		return e;
	}
	
	//shortcut for working with HTML5 element data
	public static function getData(e:HTMLElement, n:String):String return e.getAttribute('data-' + n)
	public static function setData(e:HTMLElement, n:String, v:String):HTMLElement {
		e.setAttribute('data-' + n, v);
		return e;
	}
	
	//shortcut for working with event listeners (bubble phase only)
	//not only is it shorter, it also returns the element so we can use method chaining
	//TODO: HTMLElement<Dynamic> should be EventTarget typedef, need to move fix IE event model on another level first
	/*
	public static function on(e:HTMLElement<Dynamic>, type:String, handler:Dynamic->Void, ?falseForRemove:Bool):HTMLElement<Dynamic> {
		falseForRemove == false
			?e.removeEventListener(type, handler,false)
			:e.addEventListener(type, handler,false)
		;
		return e;
	}*/
	
	//className tools:
	public static function hasClass(e:HTMLElement, c:String):Bool {
		return classEReg(c).match(e.className);
	}
	public static function switchClass(e:HTMLElement,c:String,?b:Bool):HTMLElement {
		if (b == null) b = !hasClass(e, c);
		(b?addClass:removeClass)(e,c);
		return e;
	}
	//TODO: IE6 compatibility for multi-classes?
	public static function addClass(e:HTMLElement,c:String):HTMLElement {
		if (!hasClass(e,c)) e.className+=(e.className.length>0?' ':'')+c;
		return e;
	}
	public static function removeClass(e:HTMLElement, c:String):HTMLElement {
		e.className = classEReg(c).replace(e.className, '');
		return e;
	}
	
	static function classEReg(c:String) return new EReg('(\\s|^)' + c + '(\\s|$)', 'g')
	
	//returns a selector corresponding with the element
	/*public static function getSelector(e:HTMLElement):Selector {
		if (e.__sel!=null) return e.__sel;
		var cn = 'element-'+Tools.getInstanceId(e);
		addClass(e, cn);
		return new Selector('cn');
	}*/
	
}