/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/coords.html#InterfaceSVGMatrix
 */
package org.w3c.dom.svg;

interface SVGMatrix {
	var a:Float;
	var b:Float;
	var c:Float;
	var d:Float;
	var e:Float;
	var f:Float;
	function multiply(secondMatrix:SVGMatrix):SVGMatrix;
	function inverse():SVGMatrix;
	function translate(x:Float, y:Float):SVGMatrix;
	function scale(scaleFactor:Float):SVGMatrix;
	function scaleNonUniform(scaleFactorX:Float, scaleFactorY:Float):SVGMatrix;
	function rotate(angle:Float):SVGMatrix;
	function rotateFromVector(x:Float, y:Float):SVGMatrix;
	function flipX():SVGMatrix;
	function flipY():SVGMatrix;
	function skewX(angle:Float):SVGMatrix;
	function skewY(angle:Float):SVGMatrix;
}