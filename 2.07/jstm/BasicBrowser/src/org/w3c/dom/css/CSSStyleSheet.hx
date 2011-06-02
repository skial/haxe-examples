/**
 * http://dev.w3.org/csswg/cssom/#cssstylesheet
 * 
 * @author Cref
 */

package org.w3c.dom.css;

import org.w3c.dom.stylesheets.StyleSheet;
import org.w3c.dom.html.HTMLElement;

interface CSSStyleSheet<TCSSRule,TCSSRuleList,TNode> implements StyleSheet {
	public var ownerRule(default,never):TCSSRule;
	public var cssRules(default,never):TCSSRuleList;
	public function insertRule(rule:String, index:Int):Int;
	public function deleteRule(index:Int):Void;
	public var ownerNode(default,never):TNode;
}