/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/types.html#InterfaceSVGElement
 */
package org.w3c.dom.svg;

import org.w3c.dom.Element;

interface SVGElement implements Element<TDoc,TNodeList,TElm> {
	var id(default, never):String;
	var xmlbase(default, never):String;
	var ownerSVGElement(default, never):SVGSVGElement;
	var viewportElement(default, never):SVGElement;
}