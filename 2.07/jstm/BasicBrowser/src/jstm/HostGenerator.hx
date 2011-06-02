/**
 * 
 * @author Cref
 */

package jstm;

#if macro
import haxe.macro.Type;

class HostGenerator extends Generator {
	
	/**
	 * translate extern classes in the activex package for JScript targets
	 * @param	c
	 * @return
	 */
	/*override function forceExternClassInit(c:ClassType):Bool {
		//trace(c.name);
		if (c.name == '_gat') return true;
		if (c.pack[0] == 'google') return true;//tmp
		return super.forceExternClassInit(c);
	}*/
	
}
#end