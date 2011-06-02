/**
 * TODO: 
 * @author Cref
 */

package hxtc.events;
import jstm.Host;

using hxtc.events.EventListener;

class KeyboardEvents {

	static var d:HTMLDocument;
	static var downListener:EventListener;
	
	public static function __init__() {
		d = Host.window.document;
		d.on('keydown', key);
		d.on('keyup', key);
		keys = new IntHash();
	}
	
	static function key(e:KeyboardEvent):Void {
		e.type=='keydown'?keys.set(e.keyCode, true):keys.remove(e.keyCode);
	}
	
	public static function isDown(keyCode:Int):Bool return keys.exists(keyCode)
	static function on(keyCode:Int, type:String, f:Int->Bool,?autoEnable:Bool):EventListener {
		var cb = function(e:KeyboardEvent ) {
			if (e.keyCode != keyCode) return;
			if (f(keyCode)) e.preventDefault();
		}
		var r = d.on('key' + type, cb, autoEnable);
		return r;
	}
	public static function onUp(keyCode:Int, f:Int->Bool):EventListener return on(keyCode, 'up', f)
	public static function onDown(keyCode:Int, f:Int->Bool):EventListener return on(keyCode, 'down', f)
	
	static var keys:IntHash<Bool>;
	
}
