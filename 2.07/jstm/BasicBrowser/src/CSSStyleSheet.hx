/**
 * ...
 * @author Cref
 */

extern class CSSStyleSheet extends StyleSheet, implements org.w3c.dom.css.CSSStyleSheet<CSSRule,CSSRuleList,HTMLElement> {
	public var ownerRule(default,never):CSSRule;
	public var cssRules(default,never):CSSRuleList;
	public function insertRule(rule:String, index:Int):Int;
	public function deleteRule(index:Int):Void;
	public var ownerNode(default,never):HTMLElement;
}