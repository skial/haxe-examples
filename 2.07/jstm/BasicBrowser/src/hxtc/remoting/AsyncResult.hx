/**
 * ...
 * @author Cref
 */

package hxtc.remoting;

class AsyncResult<T> {
	
	public function new():Void;
	
	public dynamic function onready(v:T):Void;

	//resolves the return value and runs the callback
	public static function use<T>(result:T,onready:T->Void):Void {
		Std.is(result, AsyncResult)
			?untyped result.onready=onready
			:js.browser.Browser.window.setTimeout(function() onready(result), 0)//consistently run callback asynchronous
		;
	}
	
}