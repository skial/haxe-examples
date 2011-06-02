/**
 * ...
 * @author Cref
 */

package hxtc.orm;

class Scalar<T> implements Selectable<T> {
	private var __id:Int;
	public var fn(default, null):String;
	public var args(default, null):Array<Selectable<Dynamic>>;
	public function new(n,a) {
		fn = n;
		args = a;
	}
}

/*enum Scalar {
	ucase;
	lcase;
	mid(start:Int,?length:Int);
	len;
	round(nDecimals:Int);
	now;
	format(pattern:String);
}*/