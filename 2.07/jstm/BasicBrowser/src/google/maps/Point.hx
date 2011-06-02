/**
 * ...
 * @author Cref
 */

package google.maps;

extern class Point {
	//makes sure the loader 'sees' this extern class is needed
	private static function __init__():Void;
	//A point on a two-dimensional plane.
	public function new(x:Int, y:Int):Void;
	//Compares two Points
	public function equals(other:Point):Bool;
	//string	Returns a string representation of this Point.
	public function toString():String;
	//The X coordinate
	public var x:Int;
	//The Y coordinate
	public var y:Int;
}