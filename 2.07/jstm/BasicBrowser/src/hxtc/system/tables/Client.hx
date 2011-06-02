/**
 * 
 * @author Cref
*/
package hxtc.system.tables;

import hxtc.orm.DataObject;
import hxtc.orm.Field;

class Client extends DataObject {
	public var id(default,never)					:Field<Int>;
	public var token(default,never)				:Field<String>;
	public var IP(default,never)					:Field<Int>;
	public var userAgent(default,never)		:Field<String>;
	public var data(default,never)				:Field<String>;
}