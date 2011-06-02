/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFESpecularLightingElement
 */
package org.w3c.dom.svg;

interface SVGFESpecularLightingElement 	implements SVGElement,
										implements SVGFilterPrimitiveStandardAttributes {
	var in1(default, never):SVGAnimatedString;
	var surfaceScale(default, never):SVGAnimatedNumber;
	var specularConstant(default, never):SVGAnimatedNumber;
	var specularExponent(default, never):SVGAnimatedNumber;
}