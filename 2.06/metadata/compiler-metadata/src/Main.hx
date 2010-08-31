package ;

import flash.Lib;

@:final
class ExtendMe {
	
	public function new() { }
	
	public function foo() {
		trace('bar bar');
	}
	
} 

class Main extends ExtendMe {
	
	static function main() 	{
		var mn:Main = new Main();
		mn.foo();
	}
	
	public function new() {
		super();
	}
	
}