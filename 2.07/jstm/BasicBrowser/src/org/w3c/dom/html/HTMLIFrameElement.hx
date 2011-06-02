/**
 * ...
 * @author Cref
 */

package org.w3c.dom.html;

interface HTMLIFrameElement<TWin,TDoc,TNodeList,TElm> implements HTMLElement<TDoc,TNodeList,TElm> {
	var src:String;
	var contentWindow(default, null):TWin;//TODO: should be WindowProxy: http://www.w3.org/TR/html5/browsers.html#the-windowproxy-object
}