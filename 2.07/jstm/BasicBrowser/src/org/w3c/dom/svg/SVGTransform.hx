/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/coords.html#InterfaceSVGTransform
 */
package org.w3c.dom.svg;

interface SVGTransform {
	var type(default, never):SVGTransformType;
	var matrix(default, never):SVGMatrix;
	var angle(default, never):Float;
	function setMatrix(matrix:SVGMatrix):Void;
	function setTranslate(tx:Float, ty:Float):Void;
	function setScale(sx:Float, sy:Float):Void;
	function setRotate(angle:Float, cx:Float, cy:Float):Void;
	function setSkewX(angle:Float):Void;
	function setSkewY(angle:Float):Void;
}