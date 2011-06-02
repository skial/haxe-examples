/**
 * http://code.google.com/intl/nl-NL/apis/maps/documentation/javascript/basics.html
 * 
 * @author Cref
 */

package google.maps;

extern class Map extends MVCObject {
	//makes sure the loader 'sees' this extern class is needed
	private static function __init__():Void;

	public function new(elm:HTMLElement,?options:Dynamic):Void;
}