/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/types.html#InterfaceSVGLength
 */
package org.w3c.dom.svg;

interface SVGLength {
	
	var unitType(default, never):SVGLengthType;
	var value:Float;
	var valueInSpecifiedUnits:Float;
	var valueAsString:String;
	
	function newValueSpecifiedUnits(unitType:Float, valueInSpecifiedUnits:Float):Void;
	function convertToSpecifiedUnits(unitType:Float):Void;
}