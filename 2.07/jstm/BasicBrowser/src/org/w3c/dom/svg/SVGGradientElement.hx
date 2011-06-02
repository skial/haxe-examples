/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/pservers.html#InterfaceSVGGradientElement
 */
package org.w3c.dom.svg;

interface SVGGradientElement 	implements SVGElement,
								implements SVGURIReference,
								implements SVGExternalResourcesRequired,
								implements SVGStylable,
								implements SVGUnitTypes {
	
	var gradientUnits(default, never):SVGAnimatedEnumeration;
	var gradientTransform(default, never):SVGAnimatedTransformList;
	var spreadMethod(default, never):SVGAnimated<SVGSpeadMethod>;
}