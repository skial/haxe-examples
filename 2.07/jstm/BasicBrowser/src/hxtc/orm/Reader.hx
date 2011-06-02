/**
 * not a typedef because typedefs don't offer enough flexibility
 * (like optional arguments and descriptive argument names)
 * 
 * TODO: count
 * 
 * @author Cref
 */

package hxtc.orm;

class Reader {
	
	private var c:haxe.db.Connection;
	
	private var selection:IntHash<Selectable<Dynamic>>;
	
	public function new(cn) {
		c = cn;
		selection = new IntHash();
	}
	
	public function get(sel:Selectable<Dynamic>):Reader {
		//TODO: make ObjectHash class
		selection.set(hxtc.Tools.getInstanceId(sel),sel);
		return this;
	}
	
	public function selectSingle(?filter:Filter<Dynamic>, ?order:Array<Order>, ?distinct:Bool) {
		var r = select(filter, order, 1, distinct);
		return r.hasNext()?r.next():null;
	}
	
	/*
	 * tmpForceWhere: forces WHERE instead of GROUP BY + HAVING to work around Access bug that truncates memo fields when using GROUP BY
	 */
	public function select(?filter:Filter<Dynamic>, ?order:Array<Order>, ?limit:Int, ?distinct:Bool,?tmpForceWhere:Bool) {
		return c.request(getSQL(filter,order,limit,distinct,tmpForceWhere));
	}
	
	public function getSQL(?filter:Filter<Dynamic>, ?order:Array<Order>, ?limit:Int, ?distinct:Bool,?tmpForceWhere:Bool) {
		return ((untyped c.ms)?SQL.ms:SQL.std).getBuilder().buildSelectQuery(selection,filter,order,limit,distinct,tmpForceWhere);
	}
	
}