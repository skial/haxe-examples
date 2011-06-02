/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/text.html#InterfaceSVGTextPathElement
 */
package org.w3c.dom.svg;

interface SVGTextPathElement 	implements SVGTextContentElement,
								implements SVGURIReference {
	
	var startOffset(default, never):SVGAnimatedLength;
	var method(default, never):SVGAnimated<SVGTextPathMethodType>;
	var spacing(default, never):SVGAnimated<SVGTextPathSpacingType>;
}