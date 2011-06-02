/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFEConvolveMatrixElement
 */
package org.w3c.dom.svg;

interface SVGFEConvolveMatrixElement 	implements SVGElement,
										implements SVGFilterPrimitiveStandardAttributes{
	
	var orderX(default, never):SVGAnimatedInteger;
	var orderY(default, never):SVGAnimatedInteger;
	var kernelMatrix(default, never):SVGAnimatedNumberList;
	var divisor(default, never):SVGAnimatedNumber;
	var bias(default, never):SVGAnimatedNumber;
	var targetX(default, never):SVGAnimatedInteger;
	var targetY(default, never):SVGAnimatedInteger;
	var edgeMode(default, never):SVGAnimated<SVGEdgeMode>;
	var kernelUnitLengthX(default, never):SVGAnimatedNumber;
	var kernelUnitLengthY(default, never):SVGAnimatedNumber;
	var preserveAlpha(default, never):SVGAnimatedBoolean;
}