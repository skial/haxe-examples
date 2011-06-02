/**
 * http://dev.w3.org/html5/spec/Overview.html#htmlelement
 * @author Cref
 */
package org.w3c.dom.html;

//typedef HTMLElement = js.browser.DOM.HTMLElement<Dynamic>
interface HTMLElement<TDoc,TNodeList,TElm> implements Element<TDoc,TNodeList,TElm> {
	
	var innerText:String;//not standard, Firefox doesn't have this, we will emulate this property because it's nice to have
	//inline function setInnerText(s:String):String return DOM.instance.setInnerText(this,s)
	var innerHTML:String;
	//var innerHTML(default, setInnerHTML):String;
	//inline function setInnerHTML(s:String):String return DOM.instance.setInnerHTML(this,s)
	var outerHTML:String;
	var id:String;
	var className:String;
	var offsetParent(default,never):TElm;
	var offsetWidth(default,never):Int;
	var offsetHeight(default,never):Int;
	var offsetLeft(default,never):Int;
	var offsetTop(default,never):Int;
	var style(default,never):org.w3c.dom.css.CSSStyleDeclaration;
	var title:String;
	function focus():Void;
  function getElementsByClassName(classNames:String):TNodeList;
}