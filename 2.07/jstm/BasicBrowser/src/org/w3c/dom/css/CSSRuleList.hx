/**
 * ...
 * @author Cref
 */

package org.w3c.dom.css;

interface CSSRuleList<TCSSRule> implements ArrayAccess<TCSSRule> {
	public var length(default,never):Int;
	public function item(index:Int):TCSSRule;
}