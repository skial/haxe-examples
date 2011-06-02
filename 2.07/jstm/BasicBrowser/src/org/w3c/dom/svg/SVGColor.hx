/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/types.html#InterfaceSVGColor
 */
package org.w3c.dom.svg;

interface SVGColor {
	
	var colorType(default, never):SVGColorType;
	var rgbColor(default, never):Float; // css:RGBColor
	var iccColor(default, never):SVGICCColor;
	
	function setRGBColor(rgbColor:String):Void;
	function setRGBColorICCColor(rgbColor:String, iccColor:String):Void;
	function setColor(colorType:Float, rgbColor:String, iccColor:String):Void;
}