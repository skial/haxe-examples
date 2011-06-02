/**
 * ...
 * @author Cref
 */

package hxtc.dom;

extern class ControlEvent extends Event {
	var control(getControl,never):Dynamic;
	private inline function getControl():Dynamic return untyped this.target.ctrl
	
	public static inline var SHOW = 'show';
	public static inline var HIDE = 'hide';
}