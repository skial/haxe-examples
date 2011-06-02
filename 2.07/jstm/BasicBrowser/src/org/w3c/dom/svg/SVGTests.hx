/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/types.html#InterfaceSVGTests
 */
package org.w3c.dom.svg;

interface SVGTests {
	var requiredFeatures(default, never):SVGStringList;
	var requiredExtensions(default, never):SVGStringList;
	var systemLanguage(default, never):SVGStringList;
	
	function hasExtension(extension:String):Bool;
}