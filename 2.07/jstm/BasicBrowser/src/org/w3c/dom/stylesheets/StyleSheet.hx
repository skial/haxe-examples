/**
 * http://dev.w3.org/csswg/cssom/#stylesheet
 * 
 * @author Cref
 */

package org.w3c.dom.stylesheets;

interface StyleSheet {
	public var type(default,never):String;
	public var href(default,never):String;
	//public var ownerNode(default,never):Node<Dynamic>;
	public var parentStyleSheet(default,never):StyleSheet;
	public var title(default,never):String;
	//TODO: public var media(default,never):MediaList;
	public var disabled:Bool;
}