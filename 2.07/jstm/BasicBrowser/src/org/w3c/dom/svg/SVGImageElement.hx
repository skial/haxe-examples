/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/struct.html#InterfaceSVGImageElement
 */
package org.w3c.dom.svg;

import org.w3c.dom.events.EventTarget;

interface SVGImageElement 	implements SVGElement,
							implements SVGURIReference,
							implements SVGTests,
							implements SVGLangSpace,
							implements SVGExternalResourcesRequired,
							implements SVGStylable,
							implements SVGTransformable,
							implements EventTarget {
	var x(default, never):SVGAnimatedLength;
	var y(default, never):SVGAnimatedLength;
	var width(default, never):SVGAnimatedLength;
	var height(default, never):SVGAnimatedLength;
	var preserveAspectRatio(default, never):SVGAnimatedPreserveAspectRatio;
}