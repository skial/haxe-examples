/**
 * 
 * @author Cref
*/
package hxtc.system.tables;

import hxtc.orm.DataObject;
import hxtc.orm.Field;

class ErrorInstance extends DataObject {
	public var requestId(default,never)			:Field<Int>;
	public var errorId(default,never)				:Field<Int>;
	public var callstack(default,never)			:Field<String>;
}