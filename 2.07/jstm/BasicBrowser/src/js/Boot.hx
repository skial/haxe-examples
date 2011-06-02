/**
 * ...
 * @author Cref
 */

package js;

//make sure jstm.Host is always compiled
import jstm.Host;
//we don't use js.Boot, jstm.Runtime does all the required initializations
//other functions are only used from within Std so those functions are simply
//moved to the Std replacement class: jstm.Std__.
class Boot {}