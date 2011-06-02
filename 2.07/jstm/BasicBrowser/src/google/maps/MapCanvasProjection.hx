/**
 * ...
 * @author Cref
 */

package google.maps;

extern class MapCanvasProjection {
	//makes sure the loader 'sees' this extern class is needed
	private static function __init__():Void;
	//Computes the geographical coordinates from pixel coordinates in the map's container.
	public function fromContainerPixelToLatLng(pixel:Point):LatLng;
	//Computes the geographical coordinates from pixel coordinates in the div that holds the draggable map.
	public function fromDivPixelToLatLng(pixel:Point):LatLng;
	//Computes the pixel coordinates of the given geographical location in the DOM element the map's outer container.
	public function fromLatLngToContainerPixel(latLng:LatLng):Point;
	//Computes the pixel coordinates of the given geographical location in the DOM element that holds the draggable map.
	public function fromLatLngToDivPixel(latLng:LatLng):Point;
	//The width of the world in pixels in the current zoom level.
	public function getWorldWidth():Int;
}