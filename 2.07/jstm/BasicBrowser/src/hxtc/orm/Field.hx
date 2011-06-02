/**
 * ...
 * @author Cref
 */

package hxtc.orm;

class Field < T > implements Selectable<T> {
	private var __id:Int;
	public var name(default,null):String;
	public var dataObject(default, null):DataObject;
	public function new(dataObject, name) {
		this.name = name;
		this.dataObject = dataObject;
	}
}