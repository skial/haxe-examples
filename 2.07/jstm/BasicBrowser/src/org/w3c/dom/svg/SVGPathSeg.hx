/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/paths.html#InterfaceSVGPathSeg
 */
package org.w3c.dom.svg;

interface SVGPathSeg {
	var pathSegType(default, never):SVGPathSegType;
	var pathSetAsLetter(default, never):String;
}