/**
 * ...
 * @author Cref
 */

package hxtc.dom;

using hxtc.dom.DOMTools;

class LayoutHelper {

		/*
		expects an array of td objects.
		true closes a tr and opens a new one for the next td.
		example: table([{td:''},{td:''},true,{td:'',colSpan:2}]);
		*/
		public static function table(tdArray:Array<Dynamic>,?attr:Dynamic) {
			var rows=[],cells=null,tr=null;
			for (td in tdArray) {
				if (tr==null) rows.push(tr={tr:cells=[]});
				if (td==true) tr=null;//new row
				else {
					//td.className='table-layout-section';
					//vAlign defaults to top
					if (td.vAlign==null) td.vAlign='top';
					cells.push(td);
				}
			}
			if (attr != null) hxtc.ECMAObject.forEach(attr, function(n, v) Reflect.setField(table, n, v));
			return {table:[{tbody:rows}]/*,className:'table-layout'*/};
		}
	
}