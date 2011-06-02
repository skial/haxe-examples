package org.w3c.dom.svg;

interface SVGList<T> {
	var numberOfItems:Float;
	
	function clear():Void;
	function initialize(newItem:T):T;
	function getItem(index:Float):T;
	function insertItemBefore(newItem:T, index:Float):T;
	function replaceItem(newItem:T, index:Float):T;
	function removeItem(index:Float):T;
	function appendItem(newItem:T):T;
}