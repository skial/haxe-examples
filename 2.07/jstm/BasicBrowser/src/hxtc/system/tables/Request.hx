/**
 * 
 * @author Cref
*/
package hxtc.system.tables;

import hxtc.orm.DataObject;
import hxtc.orm.Field;

class Request extends DataObject {
	public var id(default,never)					:Field<Int>;
	public var sessionId(default,never)		:Field<Int>;
	public var url(default,never)					:Field<String>;
	public var time(default,never)				:Field<Date>;
	public var referrerId(default,never)	:Field<Int>;
}