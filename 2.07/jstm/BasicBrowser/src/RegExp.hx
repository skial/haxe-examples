/**
 * ...
 * @author Cref
 */
extern class RegExp extends Object<RegExp> {
	public function new(?pattern:String, ?modifiers:String):Void;
	
	public var global:Bool;//Specifies if the "g" modifier is set
	public var ignoreCase:Bool;//Specifies if the "i" modifier is set
	public var lastIndex:Int;//The index at which to start the next match
	public var multiline:Bool;//Specifies if the "m" modifier is set
	public var source(default,null):String;//The text of the RegExp pattern
	
	public function compile(pattern:String, ?modifiers:String):Void;//Compiles a regular expression
	public function exec(?str:String):Array<String>;//Tests for a match in a string. Returns the first match
	public function test(?str:String):Bool;//Tests for a match in a string. Returns true or false
	/*Compiler doesn't allow this: Invalid character '$' TODO: solve through inline
	public static var $1(default,null):String;
	public static var $2(default,null):String;
	public static var $3(default,null):String;
	public static var $4(default,null):String;
	public static var $5(default,null):String;
	public static var $6(default,null):String;
	public static var $7(default,null):String;
	public static var $8(default,null):String;
	public static var $9(default,null):String;
	*/
	public static var input(default,null):String;
	public static var lastMatch(default,null):String;
	public static var lastParen(default,null):String;
	public static var leftContext(default,null):String;
	public static var rightContext(default,null):String;
}