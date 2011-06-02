/**
 * Can be anything: from a table in a database to a file on the filesystem to a google search query result
 * Anything you want to be able to query.
 * 
 * useful for:
 * SQL, REST, JSON, SOAP, YQL etc.
 * 
 * @author Cref
 */

package hxtc.orm;

class DataObject {
	private var __id:Int;
	private var __name:String;
	
	public function new(?name:String) {
		var cls = Type.getClass(this);
		__name = name == null?Type.getClassName(cls).split('.').pop():name;
		//initialize __id here or else it will be made into a field!
		hxtc.Tools.getInstanceId(this);
		queryArgs = { filter:null, order:null, limit:null };
		var fields = Type.getInstanceFields(cls);
		//makes every member that wasn't initialized a Field instance. We might not want to do this???
		for (fn in fields) if (Reflect.field(this,fn) == null) Reflect.setField(this,fn, new Field(this, fn));
	}
	
	public var queryArgs(default,null):{filter:Filter<Dynamic>,order:Array<Order>,limit:Int};
	//public var distinct:Bool;
	
}