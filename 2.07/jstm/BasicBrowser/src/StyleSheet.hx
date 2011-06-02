/**
 * ...
 * @author Cref
 */

extern class StyleSheet implements org.w3c.dom.stylesheets.StyleSheet {
	public var type(default,never):String;
	public var href(default,never):String;
	//public var ownerNode(default,never):Node<Dynamic>;
	public var parentStyleSheet(default,never):org.w3c.dom.stylesheets.StyleSheet;
	public var title(default,never):String;
	//TODO: public var media(default,never):MediaList;
	public var disabled:Bool;
}