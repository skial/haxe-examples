/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/color.html#InterfaceSVGColorProfileElement
 */
package org.w3c.dom.svg;

interface SVGColorProfileElement 	implements SVGElement,
									implements SVGURIReference,
									implements SVGRenderingIntent {
	var _local:String;
	var name:String;
	var renderingIntent:Int;
}