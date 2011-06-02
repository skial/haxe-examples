/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/struct.html#InterfaceSVGElementInstance
 */
package org.w3c.dom.svg;

import org.w3c.dom.events.EventTarget;

interface SVGElementInstance implements EventTarget {
	var correspondingElement(default, never):SVGElement;
	var correspondingUseElement(default, never):SVGUseElement;
	var parentNode(default, never):SVGElementInstance;
	var childNodes(default, never):SVGElementInstanceList;
	var firstChild(default, never):SVGElementInstance;
	var lastChild(default, never):SVGElementInstance;
	var previousSibling(default, never):SVGElementInstance;
	var nextSibling(default, never):SVGElementInstance;
}