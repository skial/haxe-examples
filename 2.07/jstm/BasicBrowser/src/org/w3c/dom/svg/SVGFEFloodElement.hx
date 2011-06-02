/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFEFloodElement
 */
package org.w3c.dom.svg;

interface SVGFEFloodElement implements SVGElement,
							implements SVGFilterPrimitiveStandardAttributes{
	var in1(default, never):SVGAnimatedString;
}