/**
 * ...
 * @author Cref
 */

extern class CharacterData extends Node<Dynamic,Dynamic,Dynamic>, implements org.w3c.dom.CharacterData {
	var data:String;// raises(DOMException) on setting, raises(DOMException) on retrieval
  var length(default,never):Int;
  function substringData(offset:Int, count:Int):String;// raises(DOMException);
  function appendData(arg:String):Void;//raises(DOMException);
  function insertData(offset:Int, arg:String):Void;//raises(DOMException);
  function deleteData(offset:Int, count:Int):Void;//raises(DOMException);
  function replaceData(offset:Int, count:Int, arg:String):Void;//raises(DOMException);
}