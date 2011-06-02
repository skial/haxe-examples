/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFEBlendElement
 */
package org.w3c.dom.svg;

interface SVGFEBlendElement implements SVGElement,
							implements SVGFilterPrimitiveStandardAttributes{
	
	var in1(default, never):SVGAnimatedString;
	var in2(default, never):SVGAnimatedString;
	var mode(default, never):SVGAnimated<SVGFEBlendMode>;
}