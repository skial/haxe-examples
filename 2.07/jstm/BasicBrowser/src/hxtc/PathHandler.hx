package hxtc;

using Reflect;
/**
 * ...
 * @author Cref
 */

typedef Next<T> = Dynamic<RunIndex<T>>->T;
typedef RunIndex<T> = Int->Next<T>->T;

class PathHandler<T> {

	var index(default,null):Int;
	public var path(default,null):Array<String>;
	public function new(path:Array<String>) {
		this.path = path;
		exec = getNext(0);
	}
	
	function getNext(index:Int):Next<T> {
		var called=false,t=this;
		return function(handlers:Dynamic<RunIndex<T>>):T {
			if (called) throw 'already called once';
			called = true;
			if (index == t.path.length) return null;
			var next = t.getNext(index+1);
			for (key in handlers.fields()) if (key == t.path[index]) return handlers.field(key)(index, next);
			var defaultHandler = handlers.field('_');
			return defaultHandler == null?null:defaultHandler(index,next);
		}
	}
	
	public var exec(default, null):Next<T>;
	
}