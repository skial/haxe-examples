package org.w3c.dom.svg;

interface SVGAnimated<T> {
	var baseVal:T;
	var animVal(default, never):T;
}