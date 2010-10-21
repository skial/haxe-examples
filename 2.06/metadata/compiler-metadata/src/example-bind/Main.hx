package ;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.Lib;
import flash.net.URLRequest;
import flash.events.Event;

@:bind
class Pow extends MovieClip { 
	
	public function new() {
		super();
	}
	
}

@:bind
class Dummy extends MovieClip {

	public function new() {
		super();
		
		var pow1 = new Pow();
		var pow2 = new Pow();
		
		pow1.x = 18;
		pow1.y = 60;
		pow1.rotation = -50;
		
		pow2.x = 280;
		pow2.y = 138;
		pow2.rotation = 50;
		
		addChild(pow1);
		addChild(pow2);
	}
	
}

class Main {
	
	static function main() {
		var dummy:Dummy = new Dummy();
		Lib.current.addChild(dummy);
	}
	
}