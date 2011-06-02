/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFECompositeElement
 */
package org.w3c.dom.svg;

interface SVGFECompositeElement implements SVGElement,
								implements SVGFilterPrimitiveStandardAttributes{
	
	var in1(default, never):SVGAnimatedString;
	var in2(default, never):SVGAnimatedString;
	var operator(default, never):SVGAnimated<SVGFECompositeOperator>;
	var k1(default, never):SVGAnimatedNumber;
	var k2(default, never):SVGAnimatedNumber;
	var k3(default, never):SVGAnimatedNumber;
	var k4(default, never):SVGAnimatedNumber;
}