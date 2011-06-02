/*
 * Generic Error class.
 * 
 * proposal: make Error.hx part of the standard API and make
 * all Error classes extend it on every target.
 */
extern class Error<T> extends Object<T> {
	//The JScript engine has an optional first argument number:Int but that doesn't work consistent across all engines
	public function new(?message:String):Void;
	//a string that describes the error.
	public var message:String;
	//a long value that is the unique number that identifies an Error object.
	//public var number:Int;
	/*
	 * public var name(default,null):String;
	 * the above property should return the name of the Error class but the JScript engine
	 * always returns 'Error' instead of, for instance 'SyntaxError'
	 * so exposing this attribute could lead to inconsistencies across javascript engines and since
	 * there is no need in haXe to use this property, we don't expose it.
	 * also, the JScript engine exposes:
	 * public var description:String;
	 * which is the same as the message property
	 * WebKit exposes:
	 * public var stack:String;
	 * which contains the exception stack
	 */
}
