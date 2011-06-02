/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/struct.html#InterfaceSVGSVGElement
 */
package org.w3c.dom.svg;

import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.w3c.dom.events.EventTarget;
import org.w3c.dom.events.DocumentEvent;
import org.w3c.dom.css.ViewCSS;
//import org.w3c.dom.css.DocumentCSS;

interface SVGSVGElement implements SVGElement, 
						implements SVGTests,
						implements SVGLangSpace,
						implements SVGExternalResourcesRequired,
						implements SVGStylable,
						implements SVGLocatable,
						implements SVGFitToViewBox,
						implements SVGZoomAndPan,
						implements EventTarget,
						implements DocumentEvent,
						implements ViewCSS<TElm>/*,
						implements DocumentCSS*/{
	var x(default, never):SVGAnimatedLength;
	var y(default, never):SVGAnimatedLength;
	var width(default, never):SVGAnimatedLength;
	var height(default, never):SVGAnimatedLength;
	var contentScriptType:String;
	var contentStyleType:String;
	var viewport(default, never):SVGRect;
	var pixelUnitToMillimeterX(default, never):Float;
	var pixelUnitToMillimeterY(default, never):Float;
	var screenPixelUnitToMillimeterX(default, never):Float;
	var screenPixelUnitToMillimeterY(default, never):Float;
	var useCurrentView:Bool;
	var currentView(default, never):SVGViewSpec;
	var currentScale:Float;
	var currentTranslate(default, never):SVGPoint;
	function suspendRedraw(max_wait_milliseconds:Float):Float;
	function unsuspendRedraw(suspend_handle_id:Float):Void
	function unsuspendRedrawAll():Void;
	function forceRedraw():Void;
	function pauseAnimations():Void;
	function unpauseAnimations():Void;
	function animationsPaused():Bool;
	function getCurrentTime():Float;
	function setCurrentTime(seconds:Float):Void
	function getIntersectionList(rect:SVGRect, referenceElement:SVGElement):NodeList;
	function getEnclosureList(rect:SVGRect, referenceElement:SVGElement):NodeList;
	function checkIntersection(element:SVGElement, rect:SVGRect):Bool;
	function checkEnclosure(element:SVGElement, rect:SVGRect):Bool;
	function deselectAll():Void;
	function createSVGNumber():SVGNumber;
	function createSVGLength():SVGLength;
	function createSVGAngle():SVGAngle;
	function createSVGPoint():SVGPoint;
	function createSVGMatrix():SVGMatrix;
	function createSVGRect():SVGRect;
	function createSVGTransform():SVGTransform;
	function createSVGTransformFromMatrix(matrix:SVGMatrix):SVGTransform;
	function getElementById(elementId:String):Element;
}