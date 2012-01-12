// Class and Enum metadata example
package ;

import flash.Lib;
import haxe.rtti.Meta;

@source('http://haxe.org/ref/enums')
enum Colour {
	red;
	green;
	blue;
}

@author('Skial Bainn')
@version(0.1)
@nothing
class Main {
	
	static function main() {
		var meta_main = Meta.getType(Main);
		
		trace(meta_main);
		trace(meta_main.author[0]);
		trace(meta_main.version[0]);
		trace(meta_main.nothing);
		
		var meta_color = Meta.getType(Colour);
		
		trace(meta_color.source[0]);
	}
	
}

// Class member static field access metadata example
/*package ;

import flash.Lib;
import haxe.rtti.Meta;

class Main {
	
	@wiki('http://en.wikipedia.org/wiki/Author')
	static var author:String = 'Skial Bainn';
	@wiki('http://en.wikipedia.org/wiki/Version')
	static var version:Float = 0.1;
	
	@description('Entrance to your programme')
	static function main() {
		var meta_main = Meta.getStatics(Main);
		
		trace(meta_main);
		trace(meta_main.author.wiki[0]);
		trace(meta_main.version.wiki[0]);
		trace(meta_main.main.description[0]);
	}
	
}*/

// Class member fields and Enum constructors metadata example
/*package ;

import flash.Lib;
import haxe.rtti.Meta;

enum Colour {
	@_default('0xF20006')
	red;
	@_default('0x09F002')
	green;
	@_default('0x00A4F2')
	blue;
}

class Main {
	
	@_default('Skial Bainn')
	var author:String;
	
	@_default(0.1)
	var version:Float;
	
	@bugfix( { issue:123, committer:'Skial Bainn', date:'14/08/2010' } )
	public function foo() {
		
	}
	
	static function main() {
		var meta_main = Meta.getFields(Main);
		
		trace(meta_main);
		trace(meta_main.author._default[0]);
		trace(meta_main.version._default[0]);
		trace(meta_main.foo.bugfix[0]);
		
		var meta_colour = Meta.getFields(Colour);
		
		trace(meta_colour);
		trace(meta_colour.red._default[0]);
		trace(meta_colour.green._default[0]);
		trace(meta_colour.blue._default[0]);
	}
	
}*/