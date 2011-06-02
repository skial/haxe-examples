/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/linking.html#InterfaceSVGViewElement
 */
package org.w3c.dom.svg;

interface SVGViewElement 	implements SVGElement,
							implements SVGExternalResourcesRequired,
							implements SVGFitToViewBox,
							implements SVGZoomAndPan {
	var viewTarget(default, never):SVGStringList;
}