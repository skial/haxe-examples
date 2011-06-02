/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFEDisplacementMapElement
 */
package org.w3c.dom.svg;

interface SVGFEDisplacementMapElement 	implements SVGElement,
										implements SVGFilterPrimitiveStandardAttributes{
	var in1(default, never):SVGAnimatedString;
	var in2(default, never):SVGAnimatedString;
	var scale(default, never):SVGAnimatedNumber;
	var xChannelSelector(default, never):SVGAnimated<SVGFEChannel>;
	var yChannelSelector(default, never):SVGAnimated<SVGFEChannel>;
}