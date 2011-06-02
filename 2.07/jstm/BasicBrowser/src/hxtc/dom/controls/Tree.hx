/**
 * ...
 * @author Cref
 */

package hxtc.dom.controls;


import jstm.Host;
import hxtc.dom.style.Selector;

using hxtc.dom.DOMTools;
using hxtc.events.EventListener;
using hxtc.Proxy;
/**
 * TODO: combine with Menu?
 * TODO: DOMBehaviors.makeEditable(ctrl,editType)//editType=plain/rich
 * TODO: DOMBehaviors.makeResizable(ctrl,direction,limits)//direction=h/v/both
 * TODO: DOMBehaviors.makeDraggable(ctrl,direction,limits,handle)//direction=h/v/both
 * 
 * @author Cref
 */

class Tree<T> extends hxtc.dom.UIControl<Dynamic> {
		
	static function __init__() {
		var s = Selector.getControlSelector();
		var a = new Selector('a');
		var span = new Selector('span');
		var links = s.descendants(a);
		links.writeStyles({
			textDecoration:'none',
			cursor:'default'
		});
		links.hover().descendants(span).writeStyles({textDecoration:'underline'});
		//var link = style.get(' a:hover span');
		//link.textDecoration = 'underline';
		//TODO: ControlParts
		s.descendants(new Selector('div.subs')).writeStyles({
			whiteSpace:'nowrap',
			marginLeft:'1em'
		});
		s.descendants(new Selector('span.toggler')).writeStyles({
			display:'inline-block',
			cursor:'default',
			textAlign:'center',
			//width:'.8em',
			margin:'.4em',
			width:'7px',
			height:'8px',
			lineHeight:'7px',
			fontSize:'85%',
			border:'1px solid #CCC',
			borderRadius:'2px'
		});
		s.descendants(new Selector('span.nosubs')).writeStyles({visibility:'hidden'});//TODO: state
		s.descendants(new Selector('span.icon')).writeStyles({
			width:'16px',
			height:'16px',
			//display:'block',
			display:'inline-block',
			marginRight:'2px',
			verticalAlign:'bottom',
			backgroundRepeat:'no-repeat'
		});
	}
	
	function new(?d,root:T) {
		super(d);
		element.appendChild(buildTree(root));
		//event delegation:
		element.on('click', onClick);
	}
	
	function onClick(e:MouseEvent ) {
		var elm:HTMLDivElement = e.target;
		if (elm.hasClass('toggler')) togglerClick(elm);
		//e.stopPropagation();
	}
	
	function getSubs(node:T):Iterable<T> return null
	function hasSubs(node:T):Bool return false
	function createNode(node:T):Dynamic return {a:[{span:[],className:'icon'},{span:[createNodeContent(node)]}] }
	function createNodeContent(node:T):Dynamic return node
	
	function buildTree(node:T) {
		return doc.buildElement( { div:[
			{span:[closed[0]],node:node,className:'toggler'+(hasSubs(node)?'':' nosubs')},createNode(node)
		]});
	}
	
	function togglerClick(toggler:HTMLDivElement) {
		var subs:HTMLDivElement = cast toggler.nextSibling.nextSibling;
		if (subs == null) {
			subs = cast doc.buildElement( { div:[], className:'subs' } ).placeIn(toggler.parentNode);
			var t = this;
			//support both sync and async data arrival
			getSubs(untyped toggler.node).use(function(nodes) for (c in nodes) subs.appendChild(t.buildTree(c)));
			untyped toggler.innerHTML = opened[0];
		}
		else {
			var s = subs.style.display == 'none'?opened:closed;
			toggler.innerHTML = s[0];
			subs.style.display = s[1];
		}
	}
	
	static var opened = ['‒','block'];//note: this is NOT a minus sign!
	static var closed = ['+','none'];
	
}
