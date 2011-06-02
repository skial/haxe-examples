/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/struct.html#InterfaceSVGUseElement
 */
package org.w3c.dom.svg;

import org.w3c.dom.events.EventTarget;

interface SVGUseElement implements SVGElement,
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
	var instanceRoot(default, never):SVGElementInstance;
	var animatedInstanceRoot(default, never):SVGElementInstance;
}