/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFETurbulenceElement
 */
package org.w3c.dom.svg;

interface SVGFETurbulenceElement 	implements SVGElement,
									implements SVGFilterPrimitiveStandardAttributes {
	
	var baseFrequencyX(default, never):SVGAnimatedNumber;
	var baseFrequencyY(default, never):SVGAnimatedNumber;
	var numOctaves(default, never):SVGAnimatedInteger;
	var seed(default, never):SVGAnimatedNumber;
	var stitchTiles(default, never):SVGAnimated<SVGFEStitchType>;
	var type(default, never):SVGAnimated<SVGFETurbulenceType>;
}