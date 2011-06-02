/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/masking.html#InterfaceSVGMaskElement
 */
package org.w3c.dom.svg;

interface SVGMaskElement 	implements SVGElement, 
							implements SVGTests,
							implements SVGLangSpace,
							implements SVGExternalResourcesRequired,
							implements SVGStylable,
							implements SVGUnitTypes {
	var maskUnits(default, never):SVGAnimatedEnumeration;
	var maskContentUnits(default, never):SVGAnimatedEnumeration;
	var x(default, never):SVGAnimatedLength;
	var y(default, never):SVGAnimatedLength;
	var width(default, never):SVGAnimatedLength;
	var height(default, never):SVGAnimatedLength;
}