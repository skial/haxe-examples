/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/script.html#InterfaceSVGZoomEvent
 */
package org.w3c.dom.svg;

import org.w3c.dom.events.UIEvent;

interface SVGZoomEvent implements UIEvent {
	var zoomRectScreen(default, never):SVGRect;
	var previousScale(default, never):Float;
	var previousTranslate(default, never):SVGPoint;
	var newScale(default, never):Float;
	var newTranslate(default, never):SVGPoint;
}