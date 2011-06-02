/**
 * ...
 * @author Cref
 */

package hxtc.dom;

using hxtc.dom.DOMTools;
using StringTools;

//TODO: abstract CSS selector syntax!
class ControlStyle {
	private var sheet:CSSStyleSheet;
	private var cssClass:String;
	private var rules:Hash<CSSStyleDeclaration>;
	public function new(d:HTMLDocument,c:Class<UIControl<Dynamic>>) {
		cssClass = '.ctrl' + hxtc.Tools.getInstanceId(cast c);
		rules = new Hash();
		//each document instance has it's own control stylesheet
		sheet = untyped d.css==null?d.css = d.createStyleSheet():d.css;
	}
	public function get(selector:String):CSSStyleDeclaration {
		selector = cssClass + selector.toLowerCase().rtrim();
		if (!rules.exists(selector)) rules.set(selector, sheet.createStyle(selector));
		return rules.get(selector);
	}
}