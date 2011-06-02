/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFESpotLightElement
 */
package org.w3c.dom.svg;

interface SVGFESpotLightElement implements SVGElement {
	var x(default, never):SVGAnimatedNumber;
	var y(default, never):SVGAnimatedNumber;
	var x(default, never):SVGAnimatedNumber;
	var pointsAtX(default, never):SVGAnimatedNumber;
	var pointsAtY(default, never):SVGAnimatedNumber;
	var pointsAtZ(default, never):SVGAnimatedNumber;
	var specularExponent(default, never):SVGAnimatedNumber;
	var limitingConeAngle(default, never):SVGAnimatedNumber;
}