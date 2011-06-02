/**
 * ...
 * @author Cref
 */

extern class Text extends CharacterData, implements org.w3c.dom.Text {
	
  function splitText(offset:Int):org.w3c.dom.Text;//raises(DOMException);
  // Introduced in DOM Level 3:
  var isElementContentWhitespace(default,never):Bool;
  // Introduced in DOM Level 3:
  var wholeText(default,never):String;
  // Introduced in DOM Level 3:
  function replaceWholeText(content:String):org.w3c.dom.Text;//raises(DOMException);
	
}