/**
 * TODO: somehow integrate with CSS3 transitions
 * 
 * @author Cref
 */

package hxtc.dom;

import org.w3c.dom.css.CSSStyleDeclaration;
import hxtc.Animation;

class TweenTools {

	public static function fadeIn(s:CSSStyleDeclaration, ?onend:Void->Dynamic, ?duration:Int = 200) {
		//var end = Std.parseFloat(s.opacity);
		//if (Math.isNaN(end)) end = 1;
		Animation.tween(0,1,duration,null,function(v) s.opacity=''+v,onend==null?null:function(n) onend(),true);
	}

	public static function fadeOut(s:CSSStyleDeclaration, ?onend:Void->Dynamic, ?duration:Int = 200) {
		//var start = Std.parseFloat(s.opacity);
		//if (Math.isNaN(start)) start = 1;
		Animation.tween(1,0,duration,null,function(v) s.opacity=''+v,onend==null?null:function(n) onend(),true);
	}
	
}