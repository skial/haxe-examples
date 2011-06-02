/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/types.html#InterfaceSVGICCColor
 */
package org.w3c.dom.svg;

interface SVGICCColor {
	var colorProfile:String;
	var colors(default, never):SVGNumberList;
}