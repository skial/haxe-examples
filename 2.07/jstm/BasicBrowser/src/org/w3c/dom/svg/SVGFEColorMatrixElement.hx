/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFEColorMatrixElement
 */
package org.w3c.dom.svg;

interface SVGFEColorMatrixElement 	implements SVGElement,
									implements SVGFilterPrimitiveStandardAttributes{
	
	var in1(default, never):SVGAnimatedString;
	var type(default, never):SVGAnimated<SVGFEColorMatrixType>;
	var values(default, never):SVGAnimatedNumberList;
}