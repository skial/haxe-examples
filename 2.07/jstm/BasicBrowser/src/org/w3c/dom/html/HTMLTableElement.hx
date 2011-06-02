/**
 * https://developer.mozilla.org/en/DOM/table#Methods
 * http://www.w3.org/TR/DOM-Level-2-HTML/html.html#ID-64060425
 * @author Cref
 */

package org.w3c.dom.html;


extern class HTMLTableElement extends HTMLElement {
	// Modified in DOM Level 2:
	public var caption:HTMLTableCaptionElement;
                                        // raises(DOMException) on setting

	// Modified in DOM Level 2:
	public var tHead:HTMLTableSectionElement;
                                        // raises(DOMException) on setting

  // Modified in DOM Level 2:
	public var tFoot:HTMLTableSectionElement;
                                        // raises(DOMException) on setting

	public var rows(default,never):HTMLCollection;
	public var tBodies(default,never):HTMLCollection;
	public var align:String;
	//public var bgColor:String;//deprecated! use css
	public var border:String;
	public var cellPadding:String;
	public var cellSpacing:String;
	public var frame:String;
	public var rules:String;
	public var summary:String;
	public var width:String;
	public function createTHead():HTMLElement;
	public function deleteTHead():Void;
	public function createTFoot():HTMLElement;
	public function deleteTFoot():Void;
	public function createCaption():HTMLElement;
	public function deleteCaption():Void;
  // Modified in DOM Level 2:
	public function insertRow(index:Int):HTMLElement;
                                        //raises(DOMException);
  // Modified in DOM Level 2:
	public function deleteRow(index:Int):Void;
                                        //raises(DOMException);
}