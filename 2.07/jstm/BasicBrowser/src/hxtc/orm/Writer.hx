/**
 * not a typedef because typedefs don't offer enough flexibility
 * (like optional arguments and descriptive argument names)
 * 
 * @author Cref
 */

package hxtc.orm;

using hxtc.Tools;

class Writer {
	private var c:haxe.db.Connection;
	private var sql:SQL;
	//hash and not 2 arrays so values can be overwritten
	private var writes:IntHash<{field:Field<Dynamic>,value:Selectable<Dynamic>}>;
	public function new(cn) {
		c = cn;
		sql = (untyped c.ms)?SQL.ms:SQL.std;//TODO: test on non-js targets
		writes = new IntHash();
	}
	public function set<T>(field:Field<T>, value:Selectable<T>):Writer {
		writes.set(field.getInstanceId(),{field:field,value:value});
		return this;
	}
	
	//TODO: insert from select
	public function insert():Void {
		var b = sql.getBuilder();
		var fields = [], values = [];
		var table:DataObject = null;
		for (w in writes) {
			if (table == null) table = w.field.dataObject;
			else if (table != w.field.dataObject) throw 'invalid insert';
			fields.push('`'+w.field.name+'`');
			values.push(b.getSelector(w.value));
		}
		var n = untyped table.__name;
		var q = 'INSERT INTO `' + n + '`(' + fields.join(',') + ') VALUES(' + values.join(',') + ')';
		//trace(q);
		c.request(q);
	}
	
	//TODO: update from select
	public function update(?filter:Filter<Dynamic>):Void {
		var b = sql.getBuilder();
		var updates = [];
		for (w in writes) updates.push(b.getSelector(w.field)+'='+b.getSelector(w.value));
		var where = b.filterToString(filter);
		//can not use having with update
		if (where.length > 0) where = ' WHERE ' + where;
		var q = 'UPDATE '+b.getTables()+' SET '+updates.join(',')+where;
		//trace(q);
		c.request(q);
	}
}