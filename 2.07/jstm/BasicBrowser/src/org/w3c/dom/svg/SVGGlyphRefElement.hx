/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/text.html#InterfaceSVGGlyphRefElement
 */
package org.w3c.dom.svg;

interface SVGGlyphRefElement 	implements SVGElement,
								implements SVGURIReference,
								implements SVGStylable {
	var glyphRef:String;
	var format:String;
	var x:Float;
	var y:Float;
	var dx:Float;
	var dy:Float;
}