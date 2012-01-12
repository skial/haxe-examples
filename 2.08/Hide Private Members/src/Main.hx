package ;

import js.Lib;

/**
 * ...
 * @author Skial Bainn
 */

class Main {
	
	static function main() {
		var sm:Something = new Something();
		sm.sayHello();
		sm.foo = 'BAR!';
		trace(sm.foo);
	}
	
}


class Something {
	
	public var foo(getFoo, setFoo):String;
	
	public function new():Void {
		
	}
	
	public function sayHello():String {
		return 'hello!';
	}
	
	#if !display
	public function getFoo():String {
		return foo;
	}
	
	public function setFoo(value:String):String {
		foo = value;
		return value;
	}
	#end
	
}