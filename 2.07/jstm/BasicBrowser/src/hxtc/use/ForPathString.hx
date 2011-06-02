/**
 * ...
 * @author Cref
 */

package hxtc.use;
using StringTools;
using hxtc.use.ForString;
using hxtc.use.ForPathString;
//import haxe.FileSystem;

class ForPathString{

	/*
	 * convert /My\Example//Path/ to My/Example/path
	 * only slashes, nothing more, nothing less.
	 */
	public static function correctSlashes(path:String, ?useBackslash:Bool):String {
		var s1 = '\\', s2 = '/';
		if (useBackslash) {
			s1 = '/';
			s2 = '\\';
		}
		return path.replace(s1,s2).replace(s2+s2,s2).replaceStart(s2).replaceEnd(s2);
	}
	/*
	 * reduces a path to a canonical form that's SEO friendly
	 * use for path parts of web URL's.
	 * does not perform any URL encoding/decoding!
	 * expects a string that is not urlEncoded.
	 * 
	 * TODO: special characters?
	 */
	public static function toCanonical(str:String):String {
		return str.correctSlashes().toLowerCase().replace(' ','-').replace('?','');
	}
	
}