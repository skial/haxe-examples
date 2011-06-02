/**
 * http://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSSValue
 */
package org.w3c.dom.css;

interface CSSValue {
	var cssText:String;
	var cssValueType(default, never):CSSValueType;
}