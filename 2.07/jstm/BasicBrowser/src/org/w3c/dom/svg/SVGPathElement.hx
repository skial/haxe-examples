/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/paths.html#InterfaceSVGPathElement
 */
package org.w3c.dom.svg;

import org.w3c.dom.events.EventTarget;

interface SVGPathElement 	implements SVGElement,
							implements SVGTests,
							implements SVGLangSpace,
							implements SVGExternalResourcesRequired,
							implements SVGStylable,
							implements SVGTransformable,
							implements EventTarget,
							implements SVGAnimatedPathData {
	var pathLength(default, never):SVGAnimatedNumber;
	function getTotalLength():Float;
	function getPointAtLength(distance:Float):SVGPoint;
	function getPathSegAtLength(distance:Float):Float;
	function createSVGPathSegClosePath():SVGPathSegClosePath;
	function createSVGPathSegMovetoAbs(x:Float, y:Float):SVGPathSegMovetoAbs;
	function createSVGPathSegMovetoRel(x:Float, y:Float):SVGPathSegMovetoRel;
	function createSVGPathSegLinetoAbs(x:Float, y:Float):SVGPathSegLinetoAbs;
	function createSVGPathSegLinetoRel(x:Float, y:Float):SVGPathSegLinetoRel;
	function createSVGPathCurvetoCubicAbs(x:Float, y:Float, x1:Float, y1:Float, x2:Float, y2:Float):SVGPathSegCurvetoCubicAbs;
	function createSVGPathCurvetoCubicRel(x:Float, y:Float, x1:Float, y1:Float, x2:Float, y2:Float):SVGPathSegCurvetoCubicRel;
	function createSVGPathCurvetoQuadraticAbs(x:Float, y:Float, x1:Float, y1:Float):SVGPathSegCurvetoQuadraticAbs;
	function createSVGPathCurvetoQuadraticRel(x:Float, y:Float, x1:Float, y1:Float):SVGPathSegCurvetoQuadraticRel;
	function createSVGPathSegArcAbs(x:Float, y:Float, r1:Float, r2:Float, angle:Float, largeArcFlag:Bool, sweepFlag:Bool):SVGPathSegArcAbs;
	function createSVGPathSegArcRel(x:Float, y:Float, r1:Float, r2:Float, angle:Float, largeArcFlag:Bool, sweepFlag:Bool):SVGPathSegArcRel;
	function createSVGPathSegLinetoHorizontalAbs(x:Float):SVGPathSegLinetoHorizontalAbs;
	function createSVGPathSegLinetoHorizontalRel(x:Float):SVGPathSegLinetoHorizontalRel;
	function createSVGPathSegLinetoVerticalAbs(y:Float):SVGPathSegLinetoVerticalAbs;
	function createSVGPathSegLinetoVerticalRel(y:Float):SVGPathSegLinetoVerticalRel;
	function createSVGPathSegCurvetoCubicSmoothAbs(x:Float, y:Float, x2:Float, y2:Float):SVGPathSegCurvetoCubicSmoothAbs;
	function createSVGPathSegCurvetoCubicSmoothRel(x:Float, y:Float, x2:Float, y2:Float):SVGPathSegCurvetoCubicSmoothRel;
	function createSVGPathSegCurvetoQuadraticSmoothAbs(x:Float, y:Float):SVGPathSegCurvetoQuadraticSmoothAbs;
	function createSVGPathSegCurvetoQuadraticSmoothRel(x:Float, y:Float):SVGPathSegCurvetoQuadraticSmoothRel;
}