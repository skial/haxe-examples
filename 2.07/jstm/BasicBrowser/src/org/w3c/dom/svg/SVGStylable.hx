/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/types.html#InterfaceSVGStylable
 */
package org.w3c.dom.svg;

import org.w3c.dom.css.CSSStyleDeclaration;
import org.w3c.dom.css.CSSValue;

interface SVGStylable {
	var className(default, never):SVGAnimatedString;
	var style(default, never):CSSStyleDeclaration;
	
	function getPresentationAttribute(name:String):CSSValue;
}