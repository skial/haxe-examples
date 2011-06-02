/**
 * ...
 * @author Cref
 */

/**
 * ...
 * @author Cref
 */

package hxtc.dom.controls;

import hxtc.dom.style.Selector;
import hxtc.dom.states.Align;
import hxtc.dom.states.Floating;
using hxtc.dom.style.Selector;

class ToolBox extends Box {

	static function __init__() {
		var s = Selector.getControlSelector();
		s.writeStyles({
			//TODO: move to default theme
			backgroundColor:'#EEE'
			//padding:'1px',
			//cssFloat:'left'
		});
		s.children(Selector.any.state(Align.right)).writeStyles( { cssFloat:'right' } );
		var floating = s.state(Floating.on);
		floating.writeStyles({
			border:'1px outset white',
			borderRadius:'5px'
		});
		floating.children().writeStyles({width:'100%'});
	}
}