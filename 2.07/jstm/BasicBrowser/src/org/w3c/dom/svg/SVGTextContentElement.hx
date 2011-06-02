/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/text.html#InterfaceSVGTextContentElement
 */
package org.w3c.dom.svg;

import org.w3c.dom.events.EventTarget;

interface SVGTextContentElement implements SVGElement,
								implements SVGTests,
								implements SVGLangSpace,
								implements SVGExternalResourcesRequired,
								implements SVGStylable,
								implements EventTarget {
	var textLength(default, never):SVGAnimatedLength;
	var lengthAdjust(default, never):SVGAnimated<SVGLengthAdjust>;
	function getNumberOfChars():Float;
	function getComputedTextLength():Float;
	function getSubStringLength(charnum:Float, nchars:Float):Float;
	function getStartPositionOfChar(charnum:Float):SVGPoint;
	function getEndPositionOfChar(charnum:Float):SVGPoint;
	function getExtentOfChar(charnum:Float):SVGRect;
	function getRotationOfChar(charnum:Float):Float;
	function getCharNumAtPosition(point:SVGPoint):Float;
	function selectSubString(charnum:Float, nchars:Float):Void;
}