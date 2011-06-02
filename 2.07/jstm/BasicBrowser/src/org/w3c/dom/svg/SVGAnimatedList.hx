package org.w3c.dom.svg;

interface SVGAnimatedList<T> {
	var baseVal(default, never):T;
	var animVal(default, never):T;
}