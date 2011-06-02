/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFEImageElement
 */
package org.w3c.dom.svg;

interface SVGFEImageElement implements SVGElement,
							implements SVGURIReference,
							implements SVGLangSpace,
							implements SVGExternalResourcesRequired,
							implements SVGFilterPrimitiveStandardAttributes {
	var preserveAspectRatio(default, never):SVGAnimatedPreserveAspectRatio;
}