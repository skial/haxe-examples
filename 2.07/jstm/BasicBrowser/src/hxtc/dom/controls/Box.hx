/**
 * ...
 * @author Cref
 */

package hxtc.dom.controls;
import hxtc.dom.Control;
import hxtc.dom.style.Selector;
import hxtc.dom.states.Floating;

using hxtc.dom.DOMTools;

class Box extends hxtc.dom.UIControl<Dynamic> {
	
	static function __init__() {
		var s = Selector.getControlSelector();
		s.writeStyles({
			width:'100%',
			height:'100%'
		});
		
		s.state(Floating.on).writeStyles({
			position:'absolute',
			zIndex:'1001',
			width:'auto',
			height:'auto',
			boxShadow:'1px 1px 5px #555'
		});
	}
	
	public function new(?d,?tagName:String,asLayer:Bool=false) {
		super(d,tagName);
		isLayer = asLayer;
		
	}
	
	/*private static function writeStyle(style:hxtc.dom.ControlStyle) {
		//var s = style.get('');
		//s.width = s.height = '100%';
		
		//TODO: move to default theme
		//s.padding = '.5em';
		var s = style.get('.islayer');
		s.position = 'absolute';
		s.zIndex = '1001';
		s.width = s.height = 'auto';
		s.boxShadow='1px 1px 5px #555';
		//var s = style.get('.islayer>*');
		//s.position = 'inherit';
	}*/
	
	public var isLayer(default, setIsLayer):Bool;
	function setIsLayer(b:Bool):Bool {
		//element.switchClass('islayer', b);
		setState(b?on:off);
		return b;
	}
	
}

/*state example:
enum ProjectState {
	waiting;
	busy;
	done;
}*/