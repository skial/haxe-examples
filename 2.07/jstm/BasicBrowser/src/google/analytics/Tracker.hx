/**
 * This class is a dummy for the real class that's loaded from Google.
 * 
 * TODO: add all Tracker methods.
 * 
 * @author Cref
 */

package google.analytics;

class Tracker {
	
	public static function _createTracker(?account:String, ?name:String):Tracker return null
	public static function _getTrackerByName(?name:String):Tracker return null
	public static function _anonymizeIp():Void {
		
	}

	//ga.js Basic Methods - http://code.google.com/intl/nl-NL/apis/analytics/docs/gaJS/gaJSApiBasicConfiguration.html
	public function _deleteCustomVar(index:Int):Void {
		
	}
	public function _getName():String return null
	public function _getAccount():String return null
	public function _getVersion():String return null
	public function _getVisitorCustomVar(index:Int):String return null
	//public function _initData() deprecated
	public function _setAccount(accountID:String):Void return null
	//public function _setCookiePersistence(milliseconds) deprecated
	public function _setCustomVar(index:Int, name:String, value:String, ?scope:Int):Bool return null
	public function _setSampleRate(newRate:Int):Void{}//documentation says String but I think Int is just fine...
	//public function _setSessionTimeout(newTimeout) deprecated
	public function _setSessionCookieTimeout(cookieTimeoutMillis:Int):Void{}
	//public function _setVar(newVal) deprecated
	public function _setVisitorCookieTimeout(cookieTimeoutMillis:Int):Void{}
	public function _trackPageview(?pageURL:String):Void{}
	//........
}