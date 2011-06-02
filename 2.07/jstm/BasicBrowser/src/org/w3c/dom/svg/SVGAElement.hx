/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/linking.html#InterfaceSVGAElement
 */
package org.w3c.dom.svg;

import org.w3c.dom.events.EventTarget;

interface SVGAElement 	implements SVGElement,
						implements SVGURIReference,
						implements SVGTests,
						implements SVGLangSpace,
						implements SVGExternalResourcesRequired,
						implements SVGStylable,
						implements SVGTransformable,
						implements EventTarget {
	var target(default, never):SVGAnimatedString;
}