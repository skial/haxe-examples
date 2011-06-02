/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/types.html#InterfaceSVGViewSpec
 */
package org.w3c.dom.svg;

interface SVGViewSpec implements SVGZoomAndPan, implements SVGFitToViewBox {
	var transform(default, never):SVGTransformList;
	var viewTarget(default, never):SVGElement;
	var viewBoxString(default, never):String;
	var preserveAspectRatioString(default, never):String;
	var transformString(default, never):String;
	var viewTargetString(default, never):String;
}