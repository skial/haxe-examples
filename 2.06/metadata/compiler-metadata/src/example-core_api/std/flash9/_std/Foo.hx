package ;

@:core_api 
class Foo {
	
	public static function poke(what:String):String {
		return 'Foo pokes ' + what;
	}
	
	public static function shake(what:String):String {
		return 'Foo shakes ' + what;
	}
	
}