/**
 * TODO: delegate events
 * @author Cref
 */

package hxtc.dom.controls;

import hxtc.dom.style.Selector;
import hxtc.dom.states.Align;
import hxtc.dom.states.Pinned;

using hxtc.dom.DOMTools;
using hxtc.events.EventListener;

class Menu<T> extends hxtc.dom.UIControl<Dynamic> {

	public var maxActive(default, setMaxActive):Int;
	function setMaxActive(n:Int):Int {
		return maxActive=n;
	}
	
	public var minActive(default, setMinActive):Int;
	function setMinActive(n:Int):Int {
		return minActive=n;
	}
	
	function new(?d,?minActive:Int,?maxActive:Int) {
		this.minActive = minActive;
		this.maxActive = maxActive;
		activeHash = new hxtc.ObjectHash();
		super(d,'menu');
	}
	
	//TODO: should be private
	public var activeHash:hxtc.ObjectHash<MenuItem>;
	
	static function __init__() {
		Selector.getControlSelector().children(new Selector('.splitter')).writeStyles({
			backgroundColor:'#DDD',
			margin:'1px'
		});
	}
	
	public function addItem(i:MenuItem):T {
		//element.appendChild(i.element);
		return cast i.parentControl = this;
	}
	
	public function addSplitter():T {
		element.appendChild(doc.buildElement({div:[],className:'splitter'}));
		return cast this;
	}
	
}

class HMenu extends Menu<HMenu> {
	
	
	public function new(?d,?minActive:Int,?maxActive:Int) {
		super(d, minActive, maxActive);
		//this.element.getSelector().hover().writeStyle('border','20px solid green');
	}

	static function __init__() {
		var s = Selector.getControlSelector();
		s.children().writeStyle('cssFloat','left');
		s.children(new Selector('.splitter')).writeStyles({
			width:'1px',
			height:'24px'
		});
	}
	
}

class VMenu extends Menu<VMenu> {
	
	public function new(?d,?minActive:Int,?maxActive:Int) {
		super(d,minActive,maxActive);
	}

	public function addHMenu(m:HMenu):VMenu {
		return m.parentControl = this;
	}
	
	static function __init__() {
		var s = Selector.getControlSelector();
		s.children().writeStyle('clear','both');
		s.children(new Selector('.splitter')).writeStyle('height', '1px');
		s.state(Align.right).children().writeStyle('textAlign', 'right');
	}
	
}

class MenuItem extends hxtc.dom.UIControl<Menu<Dynamic>> {

	public function new(?d) {
		super(d);
		label = new Label(d);
		element.appendChild(label.element);
		contentElm=cast doc.buildElement({span:[],className:'hover-content'});
		element.appendChild(contentElm);
		element.on('click', switchActive);
		isActive = false;
	}
	
	public var isActive(default, setActive):Bool;
	
	//TODO: kijken naar parent menu en eventueel andere items de-activeren
	function setActive(b:Bool):Bool {
		dispatch((b?'':'de') + 'activate');
		if (parentControl == null) return b;
		var h = parentControl.activeHash;
		var nActive = Lambda.count(h);
		//TODO: implement minActive>1
		if (isActive && nActive <= parentControl.minActive) return b;
		//TODO: minActive (first item activated by default)
		switch(parentControl.maxActive) {
			case null:
			case 0: return b;
			case 1: if (b && nActive > 0) {
				var t = parentControl.minActive;
				parentControl.minActive = null;
				for (i in h) i.isActive = false;
				parentControl.minActive = t;
			}
			default: if (b && parentControl.maxActive == nActive) return b;
		}
		isActive = b;
		b?h.add(this):h.remove(this);
		this.setState(b?down:up);
		dispatch('statuschanged');
		return b;
	}
	
	function switchActive(e:MouseEvent ) {
		//if (!isActive||(e.target == label.element||e.target==e.currentTarget)) setActive(!isActive);
		if (e.target == label.element||e.target==e.currentTarget) setActive(!isActive);
	}
	
	public var label(default, null):Label;
	
	var contentElm:HTMLDivElement;
	public function setContent(c:hxtc.dom.UIControl<Dynamic>):MenuItem {
		contentElm.clear().appendChild(c.element);
		return this;
	}
	
	//TODO
	//public var popout(getPopout, null):Popout;
	
	public override var parentControl(default,setParentControl):Menu<Dynamic>;
	
	override function setParentControl(menu:Menu<Dynamic>):Menu<Dynamic> {
		menu.element.appendChild(element);
		return this.parentControl=menu;
	}

	static function __init__() {
		var s = Selector.getControlSelector();
		var buttonHeight = 16,buttonPadding=2;
		
		//TODO: move to default theme
		s.writeStyles({
			padding:'2px',
			cursor:'default',
			//height:buttonHeight + 'px',
			borderRadius:'4px',
			border:'1px outset transparent',
			//whiteSpace:'nowrap',//niet doen! maakt in potentie hovercontent te breed!
			//display:'inline-block',
			verticalAlign:'bottom'
		});
		var pinned = s.state(Pinned.down);
		s.hover().or(pinned).writeStyles({
			borderColor:'#FF8C00',
			backgroundColor:'#FFC273'
		});
		s.active().or(pinned).writeStyles({
			borderStyle:'inset',
			backgroundColor:'#FFAC40'
		});
		var hoverContent = new Selector('.hover-content');
		s.children(hoverContent).writeStyles({
			//s.position = 'absolute';
			//s.whiteSpace = 'normal';
			display:'none',
			//s.position = 'relative';//anders wordt de inhoud te breed om wat voor reden dan ook
			//s.top=(buttonHeight + 2 * buttonPadding) + 'px';
			marginLeft:'-2px'//borderWidth
			//s = style.get(' .cimple-toolbar .cimple-button>.hover-content');
			//s.zIndex='1001';
		});
		s.descendants(hoverContent).children().writeStyles({
			marginTop:'3px',//padding van button
			opacity:'.95'
		});
		
		//s = style.get(' .hover-content.open-left');
		//s.left='auto';
		//s.right = '-1px';
		s.hover().children(hoverContent).or(pinned.children(hoverContent)).writeStyles({display:'block'});
	}
	
}