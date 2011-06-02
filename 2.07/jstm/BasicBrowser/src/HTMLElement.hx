/**
 * ...
 * @author Cref
 */
extern class HTMLElement extends Element<HTMLDocument,HTMLElement>,implements org.w3c.dom.html.HTMLElement<HTMLDocument,NodeList<HTMLElement>,HTMLElement> {
	
	var innerText:String;//not standard, Firefox doesn't have this, we will emulate this property because it's nice to have
	//inline function setInnerText(s:String):String return DOM.instance.setInnerText(this,s)
	var innerHTML:String;
	//var innerHTML(default, setInnerHTML):String;
	//inline function setInnerHTML(s:String):String return DOM.instance.setInnerHTML(this,s)
	var outerHTML:String;
	var id:String;
	var className:String;
	var offsetParent(default,never):HTMLElement;
	var offsetWidth(default,never):Int;
	var offsetHeight(default,never):Int;
	var offsetLeft(default,never):Int;
	var offsetTop(default,never):Int;
	var style(default,never):org.w3c.dom.css.CSSStyleDeclaration;
	var title:String;
	function focus():Void;
  function getElementsByClassName(classNames:String):NodeList<HTMLElement>;
	/*
	//Element:
	var tagName(default, never):String;
	function getAttribute(name:String):String;
  function setAttribute(name:String,value:String):Void;
  function removeAttribute(name:String):Void;
  function scrollIntoView(?alignWithTop:Bool):Void;
	*/
}