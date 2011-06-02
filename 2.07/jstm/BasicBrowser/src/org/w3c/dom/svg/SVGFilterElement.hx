/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFilterElement
 */
package org.w3c.dom.svg;

interface SVGFilterElement 	implements SVGElement,
							implements SVGURIReference,
							implements SVGLangSpace,
							implements SVGExternalResourcesRequired,
							implements SVGStylable,
							implements SVGUnitTypes {
	var filterUnits(default, never):SVGAnimatedEnumeration;
	var primitiveUnits(default, never):SVGAnimatedEnumeration;
	var x(default, never):SVGAnimatedLength;
	var y(default, never):SVGAnimatedLength;
	var width(default, never):SVGAnimatedLength;
	var height(default, never):SVGAnimatedLength;
	var filterResX(default, never):SVGAnimatedInteger;
	var filterResY(default, never):SVGAnimatedInteger;
	function setFilterRes(filterResX:Float, filterResY:Float):Void;
}