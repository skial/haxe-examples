/**
 * ...
 * @author Cref
 */

package hxtc.orm;

using hxtc.orm.ORMTools;
using hxtc.db.ConnectionTools;

class Mapper<Src,Cls> {

	var cn:haxe.db.Connection;
	var cache:IntHash<Cls>;
	public var source:Src;
	
	public function new(cn:haxe.db.Connection,src:Src) {
		this.cn = cn;
		source = src;
		cache = new IntHash();
	}
	
	function mapResult(result:Dynamic):Cls return null
	
	//function getId(result:Dynamic) return result.id
	
	public function select(?filter:hxtc.orm.Filter<Dynamic>,?order:Array<hxtc.orm.Order>,?limit:Int) {
		var ids = getIds(filter,order,limit);
		var idArr = [],newIds = [],detailsCache=null;
		//determine unavailable details
		for (id in ids) {
			idArr.push(id);
			if (!cache.exists(id)) newIds.push(id);
		}
		//query unavailable details
		if (newIds.length > 0) {
			var details = getDetailsRS(newIds);
			detailsCache = new IntHash();
			for (result in details) detailsCache.set(idField.getValue(result),result);
			//while (details.loadNext()) cache.set(idSel.id.value,adapter(fields));
		}
		//return iterator that loads adapter results from cache based on id results
		var c = cache, t = this;
		return {
			length:idArr.length,
			iterator:function() {
				var i = 0;
				return {
					next:function() {
						var id = idArr[i++];
						var r = c.get(id);
						if (r == null) c.set(id,r=t.mapResult(detailsCache.get(id)));
						return r;
					},
					hasNext:function() return i < idArr.length
				}
			}
		}
	}
	
	public function selectSingle(?filter:hxtc.orm.Filter<Dynamic>,?order:Array<hxtc.orm.Order>):Cls {
		//TODO: optimize?
		var r = select(filter, order, 1).iterator();
		return r.hasNext()?r.next():null;
	}
	
	public function getIds(?filter:hxtc.orm.Filter<Dynamic>,?order:Array<hxtc.orm.Order>,?limit:Int,?distinct:Bool,?tmpForceWhere:Bool):Array<Int> {
		var r = cast getIdsRS(filter,order,limit,distinct,tmpForceWhere).getColumns()[0];
		return r == null?[]:r;
	}
	
	var idField:hxtc.orm.Field<Int>;
	
	//important note on when NOT to use DISTINCT: http://weblogs.sqlteam.com/jeffs/archive/2007/12/13/select-distinct-order-by-error.aspx
	function getIdsRS(?filter:hxtc.orm.Filter<Dynamic>,?order:Array<hxtc.orm.Order>, ?limit:Int,?distinct:Bool,?tmpForceWhere:Bool):haxe.db.ResultSet {
		return cn.get(idField).select(filter,order,limit,distinct,tmpForceWhere);
	}
	
	function getDetailsRS(ids:Iterable<Int>):haxe.db.ResultSet {
		//TODO: solve Access memo field truncating issue for GROUP BY
		return getReader().select(idField.isIn(ids),null,null,null,true);
	}
	
	function getReader():hxtc.orm.Reader return null
	
}