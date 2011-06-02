/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/shapes.html#InterfaceSVGLineElement
 */
package org.w3c.dom.svg;

import org.w3c.dom.events.EventTarget;

interface SVGLineElement 	implements SVGElement,
							implements SVGTests,
							implements SVGLangSpace,
							implements SVGExternalResourcesRequired,
							implements SVGStylable,
							implements SVGTransformable,
							implements EventTarget {
	var x1(default, never):SVGAnimatedLength;
	var y1(default, never):SVGAnimatedLength;
	var x2(default, never):SVGAnimatedLength;
	var y2(default, never):SVGAnimatedLength;
}