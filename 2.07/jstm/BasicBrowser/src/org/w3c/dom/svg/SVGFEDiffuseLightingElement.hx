/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFEDiffuseLightingElement
 */
package org.w3c.dom.svg;

interface SVGFEDiffuseLightingElement 	implements SVGElement,
										implements SVGFilterPrimitiveStandardAttributes{
	var in1(default, never):SVGAnimatedString;
	var surfaceScale(default, never):SVGAnimatedNumber;
	var diffuseConstant(default, never):SVGAnimatedNumber;
	var kernelUnitLengthX(default, never):SVGAnimatedNumber;
	var kernelUnitLengthY(default, never):SVGAnimatedNumber;
}