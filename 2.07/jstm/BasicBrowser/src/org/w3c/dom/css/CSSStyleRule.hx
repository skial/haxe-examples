/**
 * ...
 * @author Cref
 */

package org.w3c.dom.css;

interface CSSStyleRule<TCSSStyleDeclaration,TCSSRule,TCSSStyleSheet> implements CSSRule<TCSSRule,TCSSStyleSheet> {
	var selectorText:String;
  var style(default,never):TCSSStyleDeclaration;
}