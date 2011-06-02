/**
 * Hash that makes each key canonical before using it.
 * Used by hxtc.net.HTTPServer
 * @author Cref
 */

package hxtc;

using hxtc.use.ForPathString;

class CanonicalHash<T> extends Hash<T> {
	public override function set(key:String,value:T) {
		super.set(key.toCanonical(),value);
	}
	public override function get(key:String):T {
		return super.get(key.toCanonical());
	}
	public override function exists(key:String):Bool {
		return super.exists(key.toCanonical());
	}
	public override function remove(key:String):Bool {
		return super.remove(key.toCanonical());
	}
}