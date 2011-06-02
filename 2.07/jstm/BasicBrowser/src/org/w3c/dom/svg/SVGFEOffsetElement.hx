/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFEOffsetElement
 */
package org.w3c.dom.svg;

interface SVGFEOffsetElement 	implements SVGElement,
								implements SVGFilterPrimitiveStandardAttributes {
	var in1(default, never):SVGAnimatedString;
	var dx(default, never):SVGAnimatedNumber;
	var dy(default, never):SVGAnimatedNumber;
}