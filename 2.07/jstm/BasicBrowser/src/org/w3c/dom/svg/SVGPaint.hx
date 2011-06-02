/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/painting.html#InterfaceSVGPaint
 */
package org.w3c.dom.svg;

interface SVGPaint implements SVGColor {
	
	var paintType(default, never):SVGPaintType;
	var uri(default, never):String;
	
	function setPaint(paintType:SVGPaintType, uri:String, rgbColor:String, iccColor:String):Void;
	function setUri(uri:String):Void;
}