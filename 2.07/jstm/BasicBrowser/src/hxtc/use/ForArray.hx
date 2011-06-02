/**
 * ...
 * @author Cref
 */

package hxtc.use;

class ForArray {

	public static function random<T>(arr:Array<T>):T {
		return arr[Std.random(arr.length)];
	}

	//almost the same as Lambda.map
	//usage: myFunction.each([1,2,3,4]);
	public static function each < T1, T2 > (f:T1->T2, arr:Array<T1>):Array<T2> {
		var r = [];
		for (x in arr) r.push(f(x));
		return r;
	}
	
	public static function nPages(a:Array<Dynamic>, itemsPerPage:Int):Int {
		if (itemsPerPage>=a.length) return 1;
		var r=a.length/itemsPerPage;
		if (r % 1 > 0) r++;
		return Std.int(r);
	}
	
	public static function getPage<T>(a:Array<T>, nr:Int, itemsPerPage:Int):Array<T> {
		if (itemsPerPage>=a.length) return a.copy();
		var first=(nr-1)*itemsPerPage;
		return a.slice(first,first+itemsPerPage);
	}
	
	public static function getPages<T>(a:Array<T>, itemsPerPage:Int):Array<Array<T>> {
		if (itemsPerPage>=a.length) return [a.copy()];
		var np = nPages(a, itemsPerPage), r = [];
		for (i in 0...np) r[i] = getPage(a, i+1, itemsPerPage);
		return r;
	}
	
	//not really sure about this name...
	public static function rtrim<T>(a:Array<T>,?value:Dynamic):Array<T> {
		var x=a.length-1;
		while(a[x]==value&&x>-1) x--;
		return a.slice(0,x+1);
	}
}