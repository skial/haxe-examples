/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFEMorphologyElement
 */
package org.w3c.dom.svg;

interface SVGFEMorphologyElement 	implements SVGElement,
									implements SVGFilterPrimitiveStandardAttributes {
	var in1(default, never):SVGAnimatedString;
	var operator(default, never):SVGAnimated<SVGFEMorphologyOperator>;
	var radiusX(default, never):SVGAnimatedNumber;
	var radiusY(default, never):SVGAnimatedNumber;
}