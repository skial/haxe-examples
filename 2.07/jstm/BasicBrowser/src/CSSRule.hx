/**
 * ...
 * @author Cref
 */

extern class CSSRule implements org.w3c.dom.css.CSSRule<CSSRule,CSSStyleSheet> {
	
	public var type(default, never):org.w3c.dom.css.RuleType;
	public var cssText:String;
	public var parentStyleSheet(default,never):CSSStyleSheet;
	public var parentRule(default,never):CSSRule;
}