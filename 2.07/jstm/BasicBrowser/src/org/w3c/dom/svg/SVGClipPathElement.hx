/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/masking.html#InterfaceSVGClipPathElement
 */
package org.w3c.dom.svg;

interface SVGClipPathElement 	implements SVGElement,
								implements SVGTests,
								implements SVGLangSpace,
								implements SVGExternalResourcesRequired,
								implements SVGStylable,
								implements SVGTransformable,
								implements SVGUnitTypes {
	var clipPathUnits(default, never):SVGAnimatedEnumeration;
}