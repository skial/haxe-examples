/**
 * 
 * @author Cref
 */

package hxtc;

class DynamicHash<T> extends Hash<T>, implements Dynamic<T> {

	private function resolve(n:String):T return get(n)

	//unfortunately, __setfield is gone so this won't work :'(
	//private function __setfield(n:String,v:Dynamic) set(n,v)
	
}