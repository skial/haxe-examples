/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/shapes.html#InterfaceSVGAnimatedPoints
 */
package org.w3c.dom.svg;

interface SVGAnimatedPoints {
	var points(default, never):SVGPointList;
	var animatedPoints(default, never):SVGPointList;
}