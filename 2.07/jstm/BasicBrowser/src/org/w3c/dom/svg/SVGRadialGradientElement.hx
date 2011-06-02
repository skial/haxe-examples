/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/pservers.html#InterfaceSVGRadialGradientElement
 */
package org.w3c.dom.svg;

interface SVGRadialGradientElement implements SVGGradientElement {
	var cx(default, never):SVGAnimatedLength;
	var cy(default, never):SVGAnimatedLength;
	var r(default, never):SVGAnimatedLength;
	var fx(default, never):SVGAnimatedLength;
	var fy(default, never):SVGAnimatedLength;
}