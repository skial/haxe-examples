/**
 * ...
 * @author Cref
 */

package hxtc.db;

using hxtc.use.ForString;

class ConnectionTools {
	
	/*
	 * example output:
	 * [
	 * 	[1,2,3],
	 * 	["a","b","c"]
	 * ]
	 * 
	 * this format is ideal combined with JSON.stringify()
	 * */
	public static function getColumns(rs:haxe.db.ResultSet):Array<Array<Dynamic>> {
		if (!rs.hasNext()) return [];
		var cols:Array<Array<Dynamic>> = [];
		var first = rs.next(),colNames=Reflect.fields(first);
		for (n in colNames) cols.push([Reflect.field(first, n)]);
		for (r in rs) {
			var i = 0;
			for (n in colNames) cols[i++].push(Reflect.field(r, n));
		}
		return cols;
	}
	
	//Delimiter Separated Values
	public static function toDSV(rs:haxe.db.ResultSet, ?withHeader:Bool, colSep:String = '\t', rowSep:String = '\n', ?nullString:String = ''):String {
		#if jscript
		//the getString method in adodb is way faster!
		//NOTE: be careful with dates. To be on the safe side, always format dates in your SQL query!
		var adors:activex.adodb.RecordSet = untyped rs.rs;
		if (adors.eof) return '';
		//TODO: withHeader
		return adors.getString(2, -1, colSep, rowSep, nullString).replaceEnd(rowSep);
		#else
		if (!rs.hasNext()) return '';
		var first = rs.next(),colNames=Reflect.fields(first);
		var rows = [];
		if (withHeader) rows.push(colNames.join(colSep));
		var row = [];
		for (n in colNames) {
			var f = Reflect.field(first, n);
			row.push(f==null?nullString:''+f);
		}
		rows.push(row.join(colSep));
		for (r in rs) {
			var row = [];
			for (n in colNames) {
				var f = Reflect.field(r, n);
				row.push(f==null?nullString:''+f);
			}
			rows.push(row.join(colSep));
		}
		return rows.join(rowSep);
		#end
	}
	
}