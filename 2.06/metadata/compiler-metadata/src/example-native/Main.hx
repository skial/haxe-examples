package ;

import flash.Lib;

@:native('com.skialbainn.metadata.Examples')
class NativeMe {
	
	public function new() {
		trace('new NativeMe()');
		
		var _class = Type.getClass(this);
		var _path = Type.getClassName(_class);
		
		trace('This class name is: ' + _class);
		trace('Full path: ' + _path + '\n');
	}
}

class Main {
	
	static function main() {
		var nm:NativeMe = new NativeMe();
		var mn:Main = new Main();
	}
	
	public function new() {
		trace('new Main()');
		
		var _class = Type.getClass(this);
		var _path = Type.getClassName(_class);
		
		trace('This class name is: ' + _class);
		trace('Full path: ' + _path + '\n');
	}
	
}