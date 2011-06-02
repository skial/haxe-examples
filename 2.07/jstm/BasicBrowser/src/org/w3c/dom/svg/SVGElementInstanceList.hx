/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/struct.html#InterfaceSVGElementInstanceList
 */
package org.w3c.dom.svg;

interface SVGElementInstanceList {
	var length(default, never):Float;
	function item(index:Float):SVGElementInstance;
}