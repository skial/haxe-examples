/**
 * 
 * @author Cref
*/
package hxtc.system.tables;

import hxtc.orm.DataObject;
import hxtc.orm.Field;

class Referrer extends DataObject {
	public var id(default,never)				:Field<Int>;
	public var url(default,never)				:Field<String>;
}