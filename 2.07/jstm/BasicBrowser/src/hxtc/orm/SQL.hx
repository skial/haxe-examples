/**
 * SQL dialects.
 * Currently: standard (MySQL, SQLite) and Microsoft (Access, SQL Server, Windows Search)
 * 
 * TODO: support more dialects? Firebird, PostgreSQL, DB2, Oracle
 * 
 * @author Cref
 */

package hxtc.orm;

import Type;

using hxtc.Tools;

class SQL {

	private static function __init__() {
		std = new SQL('1','0','\'','');
		ms = new SQL('true','false','#','AS ');
	}
	public static var std(default, null):SQL;
	public static var ms(default, null):SQL;
	private function new(t,f,d,a) {
		trueVal = t;
		falseVal = f;
		dateChar = d;
		as = a;
	}
	private var trueVal:String;
	private var falseVal:String;
	private var dateChar:String;
	private var as:String;
	
	public function bool(b:Bool):String return b?trueVal:falseVal
	public function date(d:Date):String return dateChar + d + dateChar
	public function alias(f:Selectable<Dynamic>):String return ' '+as+'s'+f.getInstanceId()
	
	public function getBuilder() return new Builder(this)
	
}

private class Builder {
	
	public var sql:SQL;
	var usedFields:IntHash<Field<Dynamic>>;
	var forSubQuery:Bool;
	
	public function new(sql:SQL,?forSubQuery:Bool=false) {
		this.sql = sql;
		this.forSubQuery = forSubQuery;
		usedFields = new IntHash();
	}
	
	public function buildSelectQuery(selection:Iterable<Selectable<Dynamic>>, ?filter:Filter<Dynamic>, ?order:Array<Order>, ?limit:Int, ?distinct:Bool, ?tmpForceWhere:Bool) {
		/*
		 * Forcing WHERE instead of HAVING by default for the time being.
		 * TODO: make seperate WHERE and HAVING arguments.
		 * */
		tmpForceWhere = true;
		var selectArr = [];
		for (f in selection) selectArr.push(getSelector(f) + sql.alias(f));
		if (selectArr.length == 0) throw 'nothing to select';
		var select = selectArr.join(',');
		//we use HAVING so we can combine field filters with aggregate filters in boolean operations
		var having = filterToString(filter);
		having=having.length > 0?' '+(tmpForceWhere?'WHERE':'HAVING')+' ' + having:'';
		var orderBy = '';
		if (order != null && order.length > 0 ) {
			var oArr = [];
			for (s in order) oArr.push(getSelector(s.field)+(s.desc?' DESC':''));
			orderBy = ' ORDER BY ' + oArr.join(',');
		}
		if (limit != null) {
			if (sql==SQL.ms) select = 'TOP ' + limit + ' ' + select;
			else orderBy += ' LIMIT ' + limit;
		}
		//DISTINCT is UNIQUE in Oracle (not supported yet)
		var q = 'SELECT ' + (distinct?'DISTINCT ':'') + select + ' FROM ' + getTables() + (tmpForceWhere?'':getGroupBy()) + having + orderBy;
		//trace(q);
		return q;
	}
	
	public function getGroupBy():String {
		var groupByArr = [];
		for (f in usedFields) groupByArr.push(getFieldSelector(f));
		return ' GROUP BY ' + groupByArr.join(',');
	}
	
	public function getTables():String {
		var usedTables = new IntHash(),fromArr=[];
		for (f in usedFields) {
			var tableId = f.dataObject.getInstanceId();
			if (usedTables.exists(tableId)) continue;
			usedTables.set(tableId, true);
			//TODO: subqueries and joins
			var d = f.dataObject;
			var from = (!forSubQuery&&isSubQuery(d))?buildSubQuery(d)+' AS q'+tableId:untyped '`'+d.__name+'` AS o'+tableId;
			fromArr.push(from);
		}
		return fromArr.join(',');
	}
	
	function isSubQuery(d:DataObject):Bool {
		var q = d.queryArgs;
		return q.filter != null || q.order != null || q.limit != null;
	}
	
	private function buildSubQuery(d:hxtc.orm.DataObject):String {
		var fields = [];
		for (n in Reflect.fields(d)) {
			var f:hxtc.orm.Selectable<Dynamic> = Reflect.field(d, n);
			if (Std.is(f, hxtc.orm.Selectable) && usedFields.exists(f.getInstanceId())) {
				fields.push(f);
				trace(untyped __js__("f.name"));
			}
		}
		var q = d.queryArgs;
		var select = new Builder(sql,true).buildSelectQuery(fields, q.filter, q.order, q.limit);
		return '(' + select + ')';
	}
	
	//comes from haxe.db.Connection
	private static function esc( s : String ) return s.split("'").join("''")
	
	private function getFieldSelector(f:Field<Dynamic>):String {
		return 'o' + f.dataObject.getInstanceId() + '.`' + f.name + '`';
	}
	
	function getSubQuerySelector(sel:Field<Dynamic>):String {
		return 'o' + sel.dataObject.getInstanceId() + '.s'+sel.getInstanceId();
	}
	
	public function getSelector(sel:Selectable<Dynamic>):String {
		return switch(Type.getClass(sel)) {
			case Field:
				var s:Field<Dynamic> = cast sel;
				usedFields.set(s.getInstanceId(), s);
				(!forSubQuery && untyped isSubQuery(s.dataObject))
					?getSubQuerySelector(s)
					:getFieldSelector(s)
				;
			case Aggregate:
				var s:Aggregate<Dynamic> = cast sel;
				s.fn + '('+getSelector(s.field)+')';
				switch(s.fn) {
					case 'countA': 'count(*)';
					case 'countD': 'count(distinct ' + getSelector(s.field) + ')';
					default: s.fn + '('+getSelector(s.field)+')';
				}
			case Scalar:
				var s:Scalar<Dynamic> = cast sel;
				var args = [];
				for (a in s.args) args.push(getSelector(a));
				switch(s.fn) {
					case '+', '-', '/', '*': args.join('+');
					case 'concat': sql == SQL.ms?args.join('+'):s.fn + '(' + args.join(',') + ')';
					case 'len': (sql == SQL.ms?'len':'char_length') + '(' + args.join(',') + ')';
					default: s.fn + '(' + args.join(',') + ')';
				}
			case Value:
				var s:Value<Dynamic> = cast sel;
				escapeValue(s.value);
		}
	}
	
	function escapeValue(v:Dynamic):String {
		return switch(Type.typeof(v)) {
			case ValueType.TNull:
				'NULL';
			case ValueType.TBool:
				sql.bool(v);
			case ValueType.TInt,ValueType.TFloat:
				''+v;
			default:
				switch(Type.getClass(v)) {
					case cast String:
						'\'' + esc(v) + '\'';
					case cast Date:
						sql.date(v);
					default:
						#if debug
						trace(v);
						#end
						throw new Error('invalid field type');
				}
		}
	}
	
	public function filterToString(filter:Filter<Dynamic>):String {
		if (filter == null) return '';
		switch(filter) {
			//Grouping filters:
			case group(value,and):
				var fs = [];
				for (f in value) if (f!=null) fs.push(filterToString(f));
				return '(' + fs.join(' '+(and?'AND':'OR')+' ') + ')';
			case not(value):
				return 'NOT '+filterToString(value);
			case isInQuery(s1,s2,filter,order,limit,distinct,tmpForceWhere):
				return getSelector(s1) + ' IN (' + new Builder(sql).buildSelectQuery([s2],filter,order,limit,distinct,tmpForceWhere) + ')';
			case isIn(inst, arr):
				var newArr = [];
				for (v in arr) newArr.push(escapeValue(v));
				return getSelector(inst) + ' IN (' + newArr.join(',') + ')';
			case compare(s1, operator, s2):
				return getSelector(s1) + ' ' + operator + ' ' + getSelector(s2);
		}
	}
}