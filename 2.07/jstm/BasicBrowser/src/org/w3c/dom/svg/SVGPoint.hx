/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/coords.html#InterfaceSVGPoint
 */
package org.w3c.dom.svg;

interface SVGPoint {
	var x:Float;
	var y:Float;
	function matrixTransform(matrix:SVGMatrix):SVGPoint;
}