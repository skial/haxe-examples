/**
 * ...
 * @author Cref
 */

package google.maps;

extern interface IOverlayView implements MVCObject {

	private function getMap():Map;
	
	private function setMap(map:Map):Void;
	
	private function getPanes():MapPanes;
	
	private function getProjection():MapCanvasProjection;
	
	private function draw():Void;
	
	private function onAdd():Void;
	
	private function onRemove():Void;
	
}