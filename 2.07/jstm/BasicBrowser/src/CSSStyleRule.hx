/**
 * ...
 * @author Cref
 */

extern class CSSStyleRule extends CSSRule, implements org.w3c.dom.css.CSSStyleRule<CSSStyleDeclaration,CSSRule,CSSStyleSheet> {
	var selectorText:String;
  var style(default,never):CSSStyleDeclaration;
}