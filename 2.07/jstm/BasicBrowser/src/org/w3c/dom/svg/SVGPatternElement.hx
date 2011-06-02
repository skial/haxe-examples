/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/pservers.html#InterfaceSVGPatternElement
 */
package org.w3c.dom.svg;

interface SVGPatternElement implements SVGElement,
							implements SVGURIReference,
							implements SVGTests,
							implements SVGLangSpace,
							implements SVGExternalResourcesRequired,
							implements SVGStylable,
							implements SVGFitToViewBox,
							implements SVGUnitTypes {
	var patternUnits(default, never):SVGAnimatedEnumeration;
	var patternContentUnits(default, never):SVGAnimatedEnumeration;
	var patternTransform(default, never):SVGAnimatedTransformList;
	var x(default, never):SVGAnimatedLength;
	var y(default, never):SVGAnimatedLength;
	var width(default, never):SVGAnimatedLength;
	var height(default, never):SVGAnimatedLength;
}