package hxtc.dom.style;

/**
 * http://www.w3.org/TR/css3-selectors/
 * 
 * @author Cref
 */
import jstm.Host;

using hxtc.dom.DOMTools;

class Selector {
	static var sheet:CSSStyleSheet;
	static var rules:Hash<CSSStyleDeclaration>;
	static function __init__() {
		//for now, this class is meant to be used for one-window apps only
		sheet = Host.window.document.createStyleSheet();
		rules = new Hash();
	}
	
	public static var any:Selector = new Selector('*');
	
	public function query() return Host.window.document.querySelectorAll(s)
	public function querySingle() return Host.window.document.querySelector(s)
	
	//returns a selector for the class from within which the function was called
	//can also be done with macro's but this works just as well
	public static inline function getControlSelector():Selector {
		return new Selector(untyped __js__("'.'+$0.__name__.join('-')"));
	}
	
	static function getRule(sel:String) {
		if (!rules.exists(sel)) rules.set(sel, sheet.createStyle(sel));
		return rules.get(sel);
	}
	
	public function writeStyle(prop:String, val:String):Selector {
		untyped getRule(s)[prop] = val;
		return this;
	}
	
	public function writeStyles(styles:Dynamic<String>):Selector {
		for (n in Reflect.fields(styles)) writeStyle(n, Reflect.field(styles, n));
		return this;
	}

	var s:String;
	public function new(sel:String):Void {
		s = sel;
	}
	
	public function or(sel:Selector):Selector {
		return new Selector(s+','+sel.s);
	}
	
	//combinator selectors. inline?
	function combi(o:String, sel:Selector):Selector return new Selector(s + o + (sel == null?'*':sel.s))
	public function descendants(?sel:Selector):Selector return combi(' ',sel)
	//TODO: fix ie6: Browser.ieVersion<7?' ':'>'
	public function children(?sel:Selector):Selector return combi('>',sel)
	public function adjacentSiblings(?sel:Selector):Selector return combi('+',sel)
	public function siblings(?sel:Selector):Selector return combi('~',sel)
	
	public function idEquals(id:String):Selector return new Selector(s+'#'+id)
	public function havingClass(cn:String):Selector return new Selector(s+'.'+cn)
	//attribute selectors. inline?
	public function havingAttr(n:String):Selector return new Selector(s+'['+n+']')
	function attr(n:String,o:String,v:String):Selector return havingAttr(n+o+'="'+v+'"')
	public function valueEquals(name:String,value:String):Selector return attr(name,'',value)
	public function havingValue(name:String,value:String):Selector return attr(name,'~',value)
	public function valueStartsWith(name:String,value:String):Selector return attr(name,'^',value)
	public function valueEndsWith(name:String,value:String):Selector return attr(name,'$',value)
	public function valueContains(name:String, value:String):Selector return attr(name, '*', value)
	//e.g. havingValuePart('lang','en') for lang="en-US"
	public function havingValuePart(name:String,value:String):Selector return attr(name,'|',value)
	
	//pseudo-classes. TODO: automatic browser patching.
	function pseudo(n:String):Selector return new Selector(s + ':' + n)
	public function root():Selector return pseudo('root')
	public function nthChild(n:Int):Selector return pseudo('nth-child('+n+')')
	public function nthLastChild(n:Int):Selector return pseudo('nth-last-child('+n+')')
	public function nthOfType(n:Int):Selector return pseudo('nth-of-type('+n+')')
	public function nthLastOfType(n:Int):Selector return pseudo('nth-last-of-type('+n+')')
	public function firstChild():Selector return pseudo('first-child')
	public function lastChild():Selector return pseudo('last-child')
	public function firstOfType():Selector return pseudo('first-of-type')
	public function lastOfType():Selector return pseudo('last-of-type')
	public function onlyChild():Selector return pseudo('only-child')
	public function onlyOfType():Selector return pseudo('only-of-type')
	public function empty():Selector return pseudo('empty')
	public function visited():Selector return pseudo('visited')
	public function active():Selector return pseudo('active')
	public function hover():Selector return pseudo('hover')
	public function focus():Selector return pseudo('focus')
	public function target():Selector return pseudo('target')
	public function lang(code:String):Selector return pseudo('lang('+code+')')
	public function enabled():Selector return pseudo('enabled')
	public function disabled():Selector return pseudo('disabled')
	public function checked():Selector return pseudo('checked')
	public function firstLetter():Selector return pseudo('first-letter')
	public function firstLine():Selector return pseudo('first-line')
	public function before():Selector return pseudo('before')
	public function after():Selector return pseudo('after')
	public function not(s:Selector):Selector return pseudo('not('+s.s+')')
	
	public function state(state:Dynamic):Selector {
		#if debug
		switch(Type.typeof(state)) {
			case TEnum(e)://continue
			default: throw new Error('state should be enumConstructor: '+state);
		}
		#end
		//TODO: cache names
		var enumName = Type.getEnumName(Type.getEnum(state)).split('.').join('-')+'-'+Type.enumConstructor(state);
		return new Selector(s+'.'+enumName);
	}
	
	/*function toString():String {
		return s;
	}*/
	
}