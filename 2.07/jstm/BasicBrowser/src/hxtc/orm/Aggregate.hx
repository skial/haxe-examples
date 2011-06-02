/**
 * NOTE: DISTINCT is not available in Access.
 * We could emulate this using a subquery:
 * http://blogs.msdn.com/b/access/archive/2007/09/19/writing-a-count-distinct-query-in-access.aspx
 * 
 * @author Cref
 */

package hxtc.orm;

class Aggregate<T> implements Selectable<T> {
	private var __id:Int;
	public var fn(default, null):String;
	public var field(default, null):Selectable<Dynamic>;
	public function new(n,f) {
		fn = n;
		field = f;
	}
}