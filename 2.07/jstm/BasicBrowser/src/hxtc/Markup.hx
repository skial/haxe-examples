/**
 * Makes it easy to generate clean markup.
 * If it compiles, it will produce valid markup.
 * Does not apply DTD rules so doesn't check for allowed tagnames, childnodes, attributes and values.
 * 
 * Why use this class?
 * - hand-coded markup is what it is: a string. So not flexible and not very readable
 * - hand-coding markup is a pain
 * - hand-coding markup can easily lead to invalid markup
 * - hand-coding markup is tricky because of injection exploits potential
 * - this class takes care of the different notation standards
 * - this class uses a compact notation of anonymous objects and arrays which can be
 *   transferred and stored as JSON
 * - the input objects can be re-used and manipulated
 * 
 * doesn't use StringBuffer, can't see any advantages for now
 * 
 * TODO: write full documentation
 * TODO: add formatting option (line breaks, tabs etc.)
 * TODO: add SVG and MathML void elements
 * TODO: do more escaping?
 * TODO: getRSS, getAtom?
 * 	http://dev.w3.org/html5/markup/syntax.html#syntax-attributes
 * 	http://www.w3schools.com/tags/ref_entities.asp
 * 
 * Note: could also offer style support (style atributes as Dynamic) but this
 * is deliberately left out to promote the use of stylesheets.
 * Could still be implemented by something like: {div:[],style:myStyleObject.toString()}
 * 
 * @author Cref
 */
package hxtc;
using StringTools;

class Markup {
	//This class will always use the latest HTML standard.
	//Currently, this is HTML5.
	//http://dev.w3.org/html5/markup/syntax.html#void-element
	private static var htmlVoidElements:Hash<Void> = {
		var h = new Hash<Void>();
		for (n in 'area base br col command embed hr img input keygen link meta param source wbr'.split(' ')) h.set(n, null);
		h;
	}
	private static function makeAttribute(name:String, value:Dynamic, boolAsFlag:Bool):String {
		return value == null || value == false
			?''
			:' ' + name + (value == true && boolAsFlag?'':'="' + StringTools.replace(''+value,'"','&#34;') + '"');
	}
	public static function getSGML(src:Dynamic, ?voidElements:Hash<Void>, ?closeVoidElements:Bool, ?boolAsFlag:Bool):String {
		if (src == null) return '';
		//kan dit ook via een switch?
		if (Std.is(src, String)) return StringTools.htmlEscape(cast src);
		if (Std.is(src, Embed)) return untyped src.value;
		if (Std.is(src, Array)) {
			var a:Array<Dynamic> = cast src;
			for (i in 0...a.length) a[i] = getSGML(a[i], voidElements, closeVoidElements, boolAsFlag);
			//for (s in cast(src,Array<Dynamic>)) a.push(getSGML(s,voidElements,closeVoidElements,boolAsFlag));
			return a.join('');
		}
		if (Std.is(src, Int)||Std.is(src, Float)||Std.is(src, Bool)||Std.is(src, Date)) return ''+src;
		//if (Std.is(src, Dynamic)) {
			//get attributes
			var attr = Reflect.fields(src),arr = [],tagName=null,content=null;
			for (a in attr) {
				var value = Reflect.field(src, a);
				if (Std.is(value, Array)) {
					if (tagName != null) throw new Error('can not use array as attribute value');
					tagName = a;
					content = value;
				}
				else {
					//add support for HTML5 data
					if (a == 'data') {
						var data = Reflect.fields(value);
						for (a in data) arr.push(makeAttribute('data-' + a, Reflect.field(value, a), boolAsFlag));
					}
					//className patch
					else arr.push(makeAttribute(a == 'className'?'class':a, value, boolAsFlag));
				}
			}
			if (tagName == null) throw new Error('invalid tag: '+attr);
			//make tag
			return '<' + tagName + arr.join('')+(voidElements!=null && voidElements.exists(tagName)
				?closeVoidElements?' /':''
				:'>' + getSGML(content,voidElements,closeVoidElements,boolAsFlag) + '</' + tagName
			) + '>';
		//}
		//return '';
	}
	//HTML is based on SGML
	public static function getHTML(src:Dynamic):String {
		return getSGML(src, htmlVoidElements, false, true);
	}
	//XML is based on SGML
	public static function getXML(src:Dynamic, ?voidElements:Hash<Void>):String {
		return getSGML(src, voidElements, true, false);
	}
	//XHTML is based on XML
 	public static function getXHTML(src:Dynamic):String {
		return getXML(src, htmlVoidElements);
	}
	/*
	public static function validate();
	public static function clean();
	*/
	//allows markup in string form to be embedded in Markup objects without escaping
	public static function embed(markup:String) {
		return new Embed(markup);
	}
}

//allows the embedding of markup from strings
private class Embed {
	public function new(v:String) {
		value = v;
	}
	public var value:String;
}

