/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFEDistantLightElement
 */
package org.w3c.dom.svg;

interface SVGFEDistantLightElement implements SVGElement {
	var azimuth(default, never):SVGAnimatedNumber;
	var elevation(default, never):SVGAnimatedNumber;
}