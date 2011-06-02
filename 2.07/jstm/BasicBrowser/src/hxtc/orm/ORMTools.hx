/**
 * ...
 * Great resource for Access and SQL Server SQL features:
 * http://sqlserver2000.databases.aspfaq.com/what-are-the-main-differences-between-access-and-sql-server.html
 * And another great resource about SQL features:
 * http://www.1keydata.com/sql/sql.html
 * 
 * @author Cref
 */

package hxtc.orm;

import Type;

using StringTools;

class ORMTools {
	
	public static inline function getValue<T>(sel:Selectable<T>,row:Dynamic):T return Reflect.field(row, 's'+hxtc.Tools.getInstanceId(sel))

	public static inline function toField<T>(v:T):Value<T> return new Value<T>(v)
	
	//initialize a select query
	public static function get(cn,field):Reader return new Reader(cn).get(field)
	
	//initialize an insert or update query
	public static function set(cn,field,value):Writer return new Writer(cn).set(field, value)
	
	//deletes rows from a table
	public static function delete(cn:haxe.db.Connection,filter) {
		var b = ((untyped cn.ms)?SQL.ms:SQL.std).getBuilder();
		var where=b.filterToString(filter);
		var q = untyped 'DELETE FROM ' + b.getTables() + ' WHERE ' + where;
		//trace(q);
		cn.request(q);
	}
	
	/*
	//creates a table in the database if it doesn't exist
	public static function create(cn,table) {
		
	}
	
	public static function alter(cn,table) {
		
	}
	
	//verifies if a table in the database corresponds with the table instance
	public static function verify(cn,table) {
		
	}
	
	//removes an entire table from the database
	public static function drop(cn,table) {
		
	}
	*/

	
	//Filters:
	public static inline function isHigherThan<T>(f:Selectable<T>,v:Selectable<T>):Filter<Dynamic> return Filter.compare(f,'>', v)
	public static inline function isLowerThan<T>(f:Selectable<T>,v:Selectable<T>):Filter<Dynamic> return Filter.compare(f,'<', v)
	public static inline function isHigherThanOrEquals<T>(f:Selectable<T>,v:Selectable<T>):Filter<Dynamic> return Filter.compare(f,'>=', v)
	public static inline function isLowerThanOrEquals<T>(f:Selectable<T>,v:Selectable<T>):Filter<Dynamic> return Filter.compare(f,'<=', v)
	public static inline function equals<T>(f:Selectable<T>, v:Selectable<T>):Filter<Dynamic> return Filter.compare(f, '=', v)

	public static inline function isInQuery<T>(s1:Selectable<T>,s2:Selectable<T>,?filter:Filter<Dynamic>, ?order:Array<Order>, ?limit:Int, ?distinct:Bool,?tmpForceWhere:Bool):Filter<Dynamic> return Filter.isInQuery(s1,s2,filter,order,limit,distinct,tmpForceWhere)
	public static inline function isIn<T>(f:Selectable<T>,v:Iterable<T>):Filter<Dynamic> return Filter.isIn(f, v)
	
	public static inline function like(f:Selectable<String>, v:Selectable<String>):Filter<Dynamic> return Filter.compare(f, 'LIKE', v)
	//TODO: check if there are standard functions to do this so we don't have to escape the LIKE input
	public static inline function startsWith(f:Selectable<String>,v:Selectable<String>) return like(f,concat(v,new Value('%')))
	public static inline function endsWith(f:Field<String>,v:Selectable<String>) return like(f,concat(new Value('%'),v))
	public static inline function contains(f:Field<String>,v:Selectable<String>) return like(f,join([new Value('%'),v,new Value('%')]))
	//TODO: apply at other level:
	//private static function escLike(s:String):String return s.replace('[','[[]').replace('_','[_]').replace('%','[%]')
	
	public static inline function group(filters:Array<Filter<Dynamic>>,and:Bool) return Filter.group(filters,and)
	public static inline function and(filters:Array<Filter<Dynamic>>) return group(filters,true)
	public static inline function or(filters:Array<Filter<Dynamic>>) return group(filters,false)
	public static inline function not(filter:Filter<Dynamic>) return Filter.not(filter)
	
	public static inline function order(f:Selectable<Dynamic>,desc:Bool) return { field:f, desc:desc }
	public static inline function asc(f:Selectable<Dynamic>) return order(f,false)
	public static inline function desc(f:Selectable<Dynamic>) return order(f,true)
	
	//scalar functions
	private static function sc<T>(fn:String,arr:Array<Selectable<T>>):Selectable<T>
		return new Scalar(fn, arr)
	public static inline function toUpperCase(f:Selectable<String>):Selectable<String>
		return sc('ucase', [f])
	public static inline function toLowerCase(f:Selectable<String>):Selectable<String>
		return sc('lcase', [f])
	public static inline function length(f:Selectable<String>):Selectable<Int>
		return cast sc('len', [f])//Standard: 'char_length', MS: 'len'
	public static inline function replace(s1:Selectable<String>,s2:Selectable<String>,s3:Selectable<String>):Selectable<String>
		return sc('replace', [s1,s2,s3])
	//todo: create extra inlined functions that use mid
	public static inline function mid(f:Selectable<String>,start:Selectable<Int>,?length:Selectable<Int>):Selectable<String>
		return sc('mid', cast [f, start, length])
	//date functions
	public static inline function format(f:Selectable<Date>,pattern:Selectable<String>):Selectable<String>
		return sc('format', cast [f, pattern])
	//MS only? can easily be emulated
	public static inline function datePart(f:Selectable<Date>,part:Selectable<String>):Selectable<Int>//TODO: test if it returns a number or a string
		return sc('datepart', cast [part,f])
	public static inline function dateAdd(f:Selectable<Date>,part:Selectable<String>,n:Selectable<Int>):Selectable<Date>
		return sc('dateadd', cast [part, n, f])
	//different behavior for MS and Std? TODO: always use standard behaviour
	//http://www.1keydata.com/sql/sql-datediff.html
	public static inline function dateDiff(d1:Selectable<Date>,d2:Selectable<Date>):Selectable<Int>
		return cast sc('datediff', [d1,d2])//TODO: SQL Server: ['d',d2,d1]
	public static inline function systemDate(ctx:Dynamic):Selectable<Date>
		return cast sc('now',[])//TODO: Access: 'now', SQL Server: 'getdate', Std: 'sysdate'
	
	//so we can use Selectable<Float> functions with Selectable<Int>
	public static inline function toFloat(f:Selectable<Int>):Selectable<Float>
		return cast f
	
	//aggregate functions
	private static function ag<T>(fn:String,s:Selectable<Dynamic>):Selectable<T> return new Aggregate(fn, s)
	public static inline function sum(f:Selectable<Float>):Selectable<Float> return ag('sum', f)
	public static inline function avg(f:Selectable<Float>):Selectable<Float> return ag('avg', f)
	public static inline function min(f:Selectable<Dynamic>):Selectable<Float> return ag('min', f)
	public static inline function max(f:Selectable<Dynamic>):Selectable<Float> return ag('max', f)
	public static inline function first(f:Selectable<Dynamic>):Selectable<Float> return ag('first', f)
	public static inline function last(f:Selectable<Dynamic>):Selectable<Float> return ag('last', f)
	public static inline function count(f:Selectable<Dynamic>,?distinct:Bool):Selectable<Float> return ag('count'+(distinct?'D':''), f)
	public static inline function countAll(ctx:Dynamic):Selectable<Float> return ag('countA',null)
	
	//operator functions
	public function times(f:Selectable<Float>,v:Selectable<Float>):Selectable<Float>
		return sc('*', [f, v])
	
	public function divideBy(f:Selectable<Float>,v:Selectable<Float>):Selectable<Float>
		return sc('/', [f, v])
	
	public function plus(f:Selectable<Float>,v:Selectable<Float>):Selectable<Float>
		return sc('+', [f, v])
	
	public function minus(f:Selectable<Float>,v:Selectable<Float>):Selectable<Float>
		return sc('-',[f,v])
	
	public static inline function join(arr:Array<Selectable<String>>):Selectable<String>
		return sc('concat', arr)
	
	public static inline function concat(f:Selectable<String>, v:Selectable<String>):Selectable<String>
		return join([f,v])
}

