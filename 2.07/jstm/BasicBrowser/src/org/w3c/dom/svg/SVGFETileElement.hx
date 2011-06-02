/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFETileElement
 */
package org.w3c.dom.svg;

interface SVGFETileElement 	implements SVGElement, 
							implements SVGFilterPrimitiveStandardAttributes {
	var in1(default, never):SVGAnimatedString;
}