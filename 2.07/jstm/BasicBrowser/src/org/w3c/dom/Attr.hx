/**
 * ...
 * @author Cref
 */

package org.w3c.dom;

interface Attr implements Node<Dynamic,Dynamic,Attr> {
  var name(default,never):String;
  var specified(default, never):Bool;
	var value:String;// raises(DOMException) on setting
  // Introduced in DOM Level 2:
  var ownerElement(default,never):Element<Dynamic,Dynamic,Dynamic>;
  // Introduced in DOM Level 3:
  var schemaTypeInfo(default,never):TypeInfo;
  // Introduced in DOM Level 3:
  var isId(default,never):Bool;
}