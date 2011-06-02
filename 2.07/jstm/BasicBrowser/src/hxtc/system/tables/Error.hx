/**
 * 
 * @author Cref
*/
package hxtc.system.tables;

import hxtc.orm.DataObject;
import hxtc.orm.Field;

class Error extends DataObject {
	public var id(default,never)					:Field<Int>;
	public var file(default,never)				:Field<String>;
	public var line(default,never)				:Field<Int>;
	public var description(default,never)	:Field<String>;
}