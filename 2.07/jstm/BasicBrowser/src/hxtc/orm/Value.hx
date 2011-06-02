/**
 * ...
 * @author Cref
 */

package hxtc.orm;

class Value <T> implements Selectable<T> {
	private var __id:Int;

	public function new(v:T) {
		value = v;
	}
	public var value(default, null):T;
	
}