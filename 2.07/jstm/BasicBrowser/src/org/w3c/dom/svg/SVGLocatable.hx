/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/types.html#InterfaceSVGLocatable
 */
package org.w3c.dom.svg;

interface SVGLocatable {
	var nearestViewportElement(default, never):SVGElement;
	var farthestViewportElement(default, never):SVGElement;
	
	function getBBox():SVGRect;
	function getCTM():SVGMatrix;
	function getScreenCTM():SVGMatrix;
	function getTransformToElement(element:SVGElement):SVGMatrix;
}