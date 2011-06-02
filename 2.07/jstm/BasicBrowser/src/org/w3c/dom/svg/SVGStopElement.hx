/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/pservers.html#InterfaceSVGStopElement
 */
package org.w3c.dom.svg;

interface SVGStopElement implements SVGElement, implements SVGStylable {
	var offset(default, never):SVGAnimatedNumber;
}