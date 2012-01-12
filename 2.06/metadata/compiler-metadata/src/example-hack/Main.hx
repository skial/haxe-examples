package ;

import flash.Lib;

@:final
class ExtendMe {
	
	public function new() { }
	
	public function foo() {
		trace('Called from class ExtendMe, method foo, metadata @:final');
	}
	
}

@:hack
class Main extends ExtendMe {
	
	static function main() {
		var mn:Main = new Main();
		mn.foo();
		trace('Called from class Main, metadata @:hack');
	}
	
	public function new() {
		super();
	}
	
}