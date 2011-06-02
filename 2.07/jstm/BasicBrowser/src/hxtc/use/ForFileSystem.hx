/**
 * ...
 * @author Cref
 */

package hxtc.use;

using StringTools;
using hxtc.use.ForString;
using hxtc.use.ForPathString;
import haxe.FileSystem;

class ForFileSystem {
	/*
	 * makes sure a certain path exists within the local FileSystem
	 * ofcourse, this requires a FileSystem.
	 * TODO: apply compiler directives.
	 * */
	public static function buildPath(path:String) {
		if (FileSystem.exists(path)) return;
		path = path.correctSlashes();
		var arr = [];
		while (!FileSystem.exists(path)) {
			arr.push(path.afterLast('/'));
			path = path.beforeLast('/');
		}
		while (arr.length > 0) {
			path += '/' + arr.pop();
			//trace(path);
			FileSystem.createDirectory(path);
		}
	}
	
}