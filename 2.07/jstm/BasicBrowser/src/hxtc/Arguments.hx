/**
 * Generic method for getting arguments.
 * 
 * @author Cref
 */

package hxtc;

class Arguments implements Dynamic {

	public static inline function get(name:String):String {
		#if browser
		return untyped js.Boot.scriptElement.getAttribute('data-'+name);
		//else commandline arguments etc.
		#end
	}
	
}