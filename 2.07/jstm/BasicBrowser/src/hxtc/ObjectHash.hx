/**
 * ...
 * @author Cref
 */

package hxtc;

class ObjectHash<T> {

	var hash:Hash<T>;
	
	public function new() {
		hash = new Hash();
	}
	
	//override this function to tell the class how to get a unique hash code for each added instance
	private dynamic function getId(item:T):String return hxtc.Tools.getInstanceId(cast item)+''
	
	//this function deliberately does NOT check if an existing value is the same object!
	//getId is responsible for returning a unique hash code for each object.
	public function add(item:T) {
		hash.set(getId(item),item);
		return this;
	}
	
	public function getById(id:String):T {
		return hash.get(id);
	}
	
	public function addMultiple(items:Iterable<T>) {
		for (item in items) add(item);
		return this;
	}
	
	public function exists(item:T) return hash.exists(getId(item))
	
	public function remove(item:T) return hash.remove(getId(item))
	
	public function iterator() return hash.iterator()
	
	public function keys() return hash.keys()
	
	public function toString() return hash.toString()
	
}