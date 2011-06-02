/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/pservers.html#InterfaceSVGLinearGradientElement
 */
package org.w3c.dom.svg;

interface SVGLinearGradientElement implements SVGGradientElement {
	var x1(default, never):SVGAnimatedLength;
	var y1(default, never):SVGAnimatedLength;
	var x2(default, never):SVGAnimatedLength;
	var y2(default, never):SVGAnimatedLength;
}