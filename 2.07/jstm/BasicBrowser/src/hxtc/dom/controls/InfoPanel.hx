/**
 * ...
 * @author Cref
 */

package hxtc.dom.controls;

import hxtc.dom.style.Selector;

using hxtc.events.EventListener;

class InfoPanel extends hxtc.dom.UIControl<Dynamic> {

	public function new(?d,?text:String) {
		super(d);
		setText(defaultText=text);
	}
	
	private var defaultText:String;
	
	//TODO: escaping etc?
	//TODO: Firefox innerText emu?
	private function setText(t:String):String
		return element.innerText = t
		
	function bindTextListener(e:hxtc.dom.ControlEvent) {
		var d = e.control.description;
		if (d != null) setText(e.type == 'mouseenter'?d:defaultText);
	}

	static function __init__() {
		Selector.getControlSelector().writeStyles({
			textAlign:'center',
			//TODO: move to default theme
			backgroundColor:'#FFA',
			height:'90%',
			border:'1px inset #FFA',
			paddingLeft:'.5em',
			paddingRight:'.5em',
			//position:'relative',
			color:'#444',
			boxSizing:'border-box'
		});
	}
	
	//binds a control so its description will show up in the InfoBox on hover
	//TODO: emulated events are still a bit buggy
	//TODO: EventTarget typedef (will only work when IE eventmodel patch is solved differently)
	public function bind(ctrl:org.w3c.dom.events.EventTarget) {
		ctrl.on('mouseenter', bindTextListener);
		ctrl.on('mouseleave', bindTextListener);
	}
	
}