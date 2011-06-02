/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/paths.html#InterfaceSVGAnimatedPathData
 */
package org.w3c.dom.svg;

interface SVGAnimatedPathData {
	var pathSegList(default, never):SVGPathSegList;
	var normalizedPathSegList(default, never):SVGPathSegList;
	var animatedPathSegList(default, never):SVGPathSegList;
	var animatedNormalizedSegList(default, never):SVGPathSegList;
}