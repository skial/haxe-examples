package hxtc.dom.controls;
import jstm.Host;
import hxtc.dom.style.Selector;


using hxtc.use.ForString;
using hxtc.dom.style.Selector;
/**
 * ...
 * @author Cref
 */

class Application extends ContentBox {
	static function __init__() {
		var s = Selector.getControlSelector();
		s.descendants().havingClass('_').writeStyle('display','none');
	}

	public function new(w:Window) {
		super(w.document);
		window = w;
		var t = this;
		var onload = function(?e) {
			//TODO: apply fixes here
			t.start();
		}
		window.document.body == null?window.addEventListener('load', onload,false):onload();
	}
	
	//checks for any embedded controls that need redrawing
	function redraw() {
		var ctrls = element.getElementsByClassName('_');
		//TODO: -{display:none}
		for (ctrl in ctrls) {
			ctrl.style.border = '2px solid green';
			//if (ctrl.id != '') lookupIdInConfig();
			var cn = ctrl.className.split(' ')[1];
			ctrl.innerText = ctrl.id == ''?cn:ctrl.id;//Reflect.field(getConfig(), ctrl.id)._;
			ctrl.className = cn;
		}
	}
	
	function getConfig():Dynamic{}
	
	function start():Void {}
	
	public var window(default, null):Window;
}