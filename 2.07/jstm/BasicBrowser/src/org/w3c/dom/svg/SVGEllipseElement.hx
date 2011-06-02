/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/shapes.html#InterfaceSVGEllipseElement
 */
package org.w3c.dom.svg;

import org.w3c.dom.events.EventTarget;

interface SVGEllipseElement 	implements SVGElement,
								implements SVGTests,
								implements SVGLangSpace,
								implements SVGExternalResourcesRequired,
								implements SVGStylable,
								implements SVGTransformable,
								implements EventTarget {
	var cx(default, never):SVGAnimatedLength;
	var cy(default, never):SVGAnimatedLength;
	var rx(default, never):SVGAnimatedLength;
	var ry(default, never):SVGAnimatedLength;
}