/**
 * ...
 * @author Cref
 */

package hxtc.use;

class ForEReg {

	public static function forEachMatch(re:EReg,str:String,doThis:EReg->Void):Void {
		while (re.match(str)) {
			doThis(re);
			str = re.matchedRight();
		}
	}
	
	//TODO: make optimized JS version
	public static function getMatches(re:EReg,str:String,matchGroupId:Int=0):Array<String> {
		var r = [];
		while (re.match(str)) {
			r.push(re.matched(matchGroupId));
			str = re.matchedRight();
		}
		return r;
	}
	
	public static function getMatch(re:EReg, str:String, matchGroupId:Int = 0):String {
		return re.match(str)?re.matched(matchGroupId):null;
	}
	
}