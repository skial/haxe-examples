/**
 * ...
 * @author Cref
 */

extern class NodeList<TNode> implements ArrayAccess<TNode>, implements org.w3c.dom.NodeList<TNode> {
	var length(default, never):Int;
	function item(index:Int):TNode;
	//Note: shows what a mess it takes to make an extern class iterable:
	var iterator(getIterator,null) : Void->Iterator<TNode>;
	private inline function getIterator():Dynamic {
		return untyped __js__("function(l){return function(){return Array.prototype.iterator.call(l)}}")(this);
	}
	//still not working! "Can't create closure on an inline extern method"
	//inline function iterator():Iterator<T> return new NodeListIterator(this)
}