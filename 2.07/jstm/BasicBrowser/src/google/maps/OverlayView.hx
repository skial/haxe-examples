/**
 * ...
 * @author Cref
 */

package google.maps;

extern class OverlayView extends MVCObject {
	//makes sure the loader 'sees' this extern class is needed
	private static function __init__():Void;
	
	private function getMap():Map;
	
	private function setMap(map:Map):Void;
	
	private function getPanes():MapPanes;
	
	private function getProjection():MapCanvasProjection;
	
}