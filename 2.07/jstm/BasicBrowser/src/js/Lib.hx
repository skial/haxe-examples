/**
 * js.Lib in the std lib has some browser-specific properties and functions.
 * When using JSTM, please use the Browser class.
 * In JSTM we make the Lib class behave the same as for the other targets.
 * 
 * @author Cref
 */

package js;
import jstm.Host;

class Lib {

	/**
		Print the specified value on the default output.
	**/
	public static inline function print( v : Dynamic ) : Void Host.window.document.write(v)

	/**
		Print the specified value on the default output followed by a newline character.
	**/
	public static inline function println( v : Dynamic ) : Void Host.window.document.writeln(v)
	
}