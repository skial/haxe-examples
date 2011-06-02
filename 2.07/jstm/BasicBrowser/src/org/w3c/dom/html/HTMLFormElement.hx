/**
 * ...
 * @author Cref
 */

package org.w3c.dom.html;

interface HTMLFormElement<TDoc,TElm> implements HTMLElement<TDoc,TElm> {
	var target:String;
	var method:String;
	var action:String;
	var encoding:String;
	function submit():Void;
}