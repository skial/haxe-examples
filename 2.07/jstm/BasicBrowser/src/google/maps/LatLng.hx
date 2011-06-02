/**
 * ...
 * @author Cref
 */

package google.maps;

extern class LatLng {
	//makes sure the loader 'sees' this extern class is needed
	private static function __init__():Void;

	public function new(lat:Float, lng:Float, ?noWrap:Bool):Void;
	//Comparison function.
	public function equals(other:LatLng):Bool;
	//Returns the latitude in degrees.
	public function lat():Float;
	//Returns the longitude in degrees.
	public function lng():Float;
	//Converts to string representation.
	public function toString():String;
	//Returns a string of the form "lat,lng" for this LatLng. We round the lat/lng values to 6 decimal places by default.
	public function toUrlValue(?precision:Int):String;
}