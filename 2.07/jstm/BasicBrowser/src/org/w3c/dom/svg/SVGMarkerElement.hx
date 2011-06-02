/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/painting.html#InterfaceSVGMarkerElement
 */
package org.w3c.dom.svg;

interface SVGMarkerElement 	implements SVGElement,
							implements SVGLangSpace, 
							implements SVGExternalResourcesRequired,
							implements SVGStylable, 
							implements SVGFitToViewBox {
	
	var refX(default, never):SVGAnimatedLength;
	var refY(default, never):SVGAnimatedLength;
	var markerWidth(default, never):SVGAnimatedLength;
	var markerHeight(default, never):SVGAnimatedLength;
	var markerUnits(default, never):SVGAnimated<SVGMarkerUnits>;
	var orientType(default, never):SVGAnimated<SVGMarkerOrient>;
	var orientAngle(default, never):SVGAnimatedAngle;
	function setOrientToAuto():Void;
	function setOrientToAngle(angle:SVGAngle):Void;
}