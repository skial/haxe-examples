/**
 * http://dev.w3.org/csswg/cssom/#cssrule
 */
package org.w3c.dom.css;

interface CSSRule<TCSSRule,TCSSStyleSheet> {
	public var type(default,never):RuleType;
	public var cssText:String;
	public var parentStyleSheet(default,never):TCSSStyleSheet;
	public var parentRule(default,never):TCSSRule;
}