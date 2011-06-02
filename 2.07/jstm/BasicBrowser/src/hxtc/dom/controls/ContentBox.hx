/**
 * ...
 * @author Cref
 */

package hxtc.dom.controls;

import hxtc.dom.style.Selector;
import hxtc.dom.states.Floating;

class ContentBox extends Box {
	
	static function __init__() {
		Selector.getControlSelector().writeStyles({
			overflow:'auto',
			//TODO: move to default theme
			backgroundColor:'white'
			//border:'1px inset'
		}).state(Floating.on).writeStyles({
			border:'1px outset #DDD',
			overflow:'visible'
			//padding:buttonPadding + 'px',
			//display:'inline-block'
		});
	}
	
}