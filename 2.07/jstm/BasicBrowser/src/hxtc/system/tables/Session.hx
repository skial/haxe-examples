/**
 * 
 * @author Cref
*/
package hxtc.system.tables;

import hxtc.orm.DataObject;
import hxtc.orm.Field;

class Session extends DataObject {
	public var id(default,never)					:Field<Int>;
	public var created(default,never)			:Field<Date>;
	public var clientId(default,never)		:Field<Int>;
}