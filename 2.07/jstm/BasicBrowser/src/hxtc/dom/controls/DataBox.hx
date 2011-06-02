/**
 * ...
 * @author Cref
 */

package hxtc.dom.controls;

import hxtc.dom.style.Selector;

class DataBox extends Box {

	static function __init__() {
		var s = Selector.getControlSelector().writeStyle('backgroundColor','#DEEFEF');
	}
	
	var titleElm:HTMLHeadElement;
	public var title(default, setTitle):String;
	function setTitle(t:String):String {
		return titleElm.innerText = t;
	}
	
	public function new(?d) {
		super(d);
		titleElm = cast doc.createElement('h3');
		element.appendChild(titleElm);
	}
	
}