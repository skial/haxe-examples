/**
 * Contains shortcuts for working with the feffects.Tween class.
 * 
 * TODO:
 * - color tweening functions (rgb(a) and hsl(a))
 * - loop and pingpong
 * - event-driven tweening
 * - 2D and 3D coordinate system tweens (oval, circle, square etc.)
 * - sprite-based animation
 * 
 * @author Cref
 */

package hxtc;

import feffects.Tween;

class Animation {

	//short way to initialize an feffects.Tween
	public static function tween(start:Float,end:Float,duration:Int,?easing:Easing,onupdate:Float -> Void,?onend:Tween -> Void,?autoStart:Bool=true):Tween {
		var t = new Tween(start, end, duration, easing);
		t.setTweenHandlers(onupdate, onend==null?null:function(n)onend(t));
		if (autoStart) t.start();
		return t;
	}
	
}