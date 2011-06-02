/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/struct.html#InterfaceSVGDocument
 */
package org.w3c.dom.svg;

import org.w3c.dom.Document;
import org.w3c.dom.events.DocumentEvent;

interface SVGDocument implements Document<TDoc,TNodeList,TElm>, implements DocumentEvent {
	var title(default, never):String;
	var referrer(default, never):String;
	var domain(default, never):String;
	var URL(default, never):String;
	var rootElement(default, never):SVGSVGElement;
}