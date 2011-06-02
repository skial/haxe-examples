/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/paths.html#InterfaceSVGPathSegArcAbs
 */
package org.w3c.dom.svg;

interface SVGPathSegArcAbs {
	var x:Float;
	var y:Float;
	var r1:Float;
	var r2:Float;
	var angle:Float;
	var largeArcFlag:Bool;
	var sweepFlag:Bool;
}