/**
 * ...
 * @author Cref
 */

package org.w3c.dom;

interface Text implements CharacterData {
  function splitText(offset:Int):Text;//raises(DOMException);
  // Introduced in DOM Level 3:
  var isElementContentWhitespace(default,never):Bool;
  // Introduced in DOM Level 3:
  var wholeText(default,never):String;
  // Introduced in DOM Level 3:
  function replaceWholeText(content:String):Text;//raises(DOMException);
}