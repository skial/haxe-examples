/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/interact.html#InterfaceSVGCursorElement
 */
package org.w3c.dom.svg;

interface SVGCursorElement 	implements SVGElement,
							implements SVGURIReference,
							implements SVGTests,
							implements SVGExternalResourcesRequired {
	var x(default, never):SVGAnimatedLength;
	var y(default, never):SVGAnimatedLength;
}