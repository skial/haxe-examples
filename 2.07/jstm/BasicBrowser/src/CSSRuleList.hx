/**
 * ...
 * @author Cref
 */

extern class CSSRuleList implements ArrayAccess<CSSRule>, implements org.w3c.dom.css.CSSRuleList<CSSRule> {
	public var length(default,never):Int;
	public function item(index:Int):CSSRule;
}