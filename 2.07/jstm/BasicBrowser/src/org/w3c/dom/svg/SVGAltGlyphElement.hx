/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/text.html#InterfaceSVGAltGlyphElement
 */
package org.w3c.dom.svg;

interface SVGAltGlyphElement 	implements SVGTextPositioningElement,
								implements SVGURIReference {
	var glyphRef:String;
	var format:String;
}