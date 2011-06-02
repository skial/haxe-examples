/**
 * 
 * @author Cref
 */

package hxtc.dom.controls;

import hxtc.dom.style.Selector;

using hxtc.dom.DOMTools;

class Label extends hxtc.dom.UIControl<Dynamic> {

	public function new(d,?text:String,?icon:String) {
		super(d,'label');
		setText(text);
		setIcon(icon);
	}

	static function __init__() {
		var s = Selector.getControlSelector();
		//TODO: determine default behaviour (layout flow etc)
		s.writeStyles({
			cursor:'default',
			color:'black',
			overflow:'hidden',
			//TODO: move to default theme
			textShadow:'-1px 1px 0px #FFF',
			userSelect:'none',
			height:'16px',
			display:'inline-block'
		});
		s.firstLetter().writeStyle('textTransform', 'uppercase');
		s.state(Icon.show).writeStyles({
			backgroundRepeat:'no-repeat',
			//backgroundPosition:'center center',//TODO: alternative style
			backgroundPosition:'2px center',
			paddingLeft:'17px'
		}).state(Text.show).writeStyles({
			paddingLeft:'20px',
			textOverflow:'ellipsis'//,overflow:'hidden' //IE<8 verliest backgroundImage maar is ook niet handig ivm submenu's
		});
	}
	
	public var text(default, setText):String;
	//TODO: escaping etc?
	private function setText(t:String):String {
		setState(t != null && t != ''?Text.show:Text.hide);
		return element.innerText = t==null?'':t;
	}
	
	public var icon(default, setIcon):String;
	private function setIcon(url:String):String {
		setState(url != null?Icon.show:Icon.hide);
		element.style.backgroundImage = url == null?'none':'url(' + ES5.global.encodeURI(url) + ')';
		return url;
	}
	
}

enum Icon {
	show;
	hide;
}

enum Text {
	show;
	hide;
}