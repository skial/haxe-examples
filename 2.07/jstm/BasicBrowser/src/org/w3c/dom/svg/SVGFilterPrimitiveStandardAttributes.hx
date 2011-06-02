/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFilterPrimitiveStandardAttributes
 */
package org.w3c.dom.svg;

interface SVGFilterPrimitiveStandardAttributes implements SVGStylable {
	var x(default, never):SVGAnimatedLength;
	var y(default, never):SVGAnimatedLength;
	var width(default, never):SVGAnimatedLength;
	var height(default, never):SVGAnimatedLength;
	var result(default, never):SVGAnimatedString;
}