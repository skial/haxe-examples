/**
 * http://www.w3.org/TR/2003/REC-SVG11-20030114/text.html#InterfaceSVGTextPositioningElement
 */
package org.w3c.dom.svg;

interface SVGTextPositioningElement implements SVGTextContentElement {
	var x(default, never):SVGAnimatedLengthList;
	var y(default, never):SVGAnimatedLengthList;
	var dx(default, never):SVGAnimatedLengthList;
	var dy(default, never):SVGAnimatedLengthList;
	var rotate(default, never):SVGAnimatedNumberList;
}