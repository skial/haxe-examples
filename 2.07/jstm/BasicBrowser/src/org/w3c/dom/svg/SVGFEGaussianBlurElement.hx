/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/filters.html#InterfaceSVGFEGaussianBlurElement
 */
package org.w3c.dom.svg;

interface SVGFEGaussianBlurElement 	implements SVGElement,
									implements SVGFilterPrimitiveStandardAttributes{
	var in1(default, never):SVGAnimatedString;
	var stdDeviationX(default, never):SVGAnimatedNumber;
	var stdDeviationY(default, never):SVGAnimatedNumber;
	function setStdDeviation(stdDeviationX:Float, stdDeviationY:Float):Void;
}