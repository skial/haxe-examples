/**
 * ...
 * @author Cref
 */

package org.w3c.dom;

interface NodeList<T> {
	var length(default, never):Int;
	function item(index:Int):T;
}