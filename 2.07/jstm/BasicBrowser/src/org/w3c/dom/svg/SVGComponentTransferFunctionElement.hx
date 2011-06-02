/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGComponentTransferFunctionElement
 */
package org.w3c.dom.svg;

interface SVGComponentTransferFunctionElement implements SVGElement {
	
	var type(default, never):SVGAnimatedEnumeration;
	var tableValues(default, never):SVGAnimatedNumberList;
	var slope(default, never):SVGAnimatedNumber;
	var intercept(default, never):SVGAnimatedNumber;
	var amplitude(default, never):SVGAnimatedNumber;
	var exponent(default, never):SVGAnimatedNumber;
	var offset(default, never):SVGAnimatedNumber;
}