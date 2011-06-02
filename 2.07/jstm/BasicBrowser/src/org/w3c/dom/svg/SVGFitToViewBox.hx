/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/types.html#InterfaceSVGFitToViewBox
 */
package org.w3c.dom.svg;

interface SVGFitToViewBox {
	var viewBox(default, never):SVGAnimatedRect;
	var preserveAspectRatio(default, never):SVGAnimatedPreserveAspectRatio;
}