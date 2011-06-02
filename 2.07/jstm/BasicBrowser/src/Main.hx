package ;

import js.Lib;
import jstm.Host;

/**
 * ...
 * @author Skial Bainn
 */

class Main {
	
	public static var doc = Host.window.document;
	
	static function main() {
		doc.addEventListener('click', onClick, false);
	}	
	
	static function onClick(e:Event):Void {
		doc.body.innerText = 'Hello from Skial - made with JSTM';
	}
}