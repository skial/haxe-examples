/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/color.html#InterfaceSVGColorProfileRule
 */
package org.w3c.dom.svg;

interface SVGColorProfileRule 	implements SVGCSSRule,
								implements SVGRenderingIntent {
	var src:String;
	var name:String;
	var renderingIntent:Int;
}