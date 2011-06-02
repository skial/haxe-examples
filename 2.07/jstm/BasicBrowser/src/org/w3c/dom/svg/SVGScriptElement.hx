/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/script.html#InterfaceSVGScriptElement
 */
package org.w3c.dom.svg;

interface SVGScriptElement 	implements SVGElement,
							implements SVGURIReference,
							implements SVGExternalResourcesRequired {
	var type:String;
}