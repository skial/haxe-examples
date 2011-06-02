/**
 * ...
 * @author Cref
 */

package hxtc;

class System {
	/**
	 * can be used when a global variable named config exists.
	 */
	 /*
	public static var config:{
		debug:Bool,
		debugEmail:String,
		smtp:{
			host:String,
			port:Int,
			user:String,
			pwd:String
		},
		mimeMap:Dynamic<String>,
		log:hxtc.db.ConnectionParameters,
		admin:{
			name:String,
			email:String
		}
	}=untyped __js__('config');
	
	public static dynamic function getSMTPConnection() {
		var c = config.smtp, cn = hxtc.net.SMTP.connect(c.host, c.port, c.user, c.pwd);
		getSMTPConnection = function() return cn;
		return cn;
	}
	
	public static function getMime(filename:String):String {
		var m = Reflect.field(config.mimeMap, haxe.io.Path.extension(filename));
		return m == null?'text/plain':m;
	}
	*/
	/*
	public static dynamic function getDatabaseConnection() {
		var cn = haxe.db.Mysql.connect(config.database);
		getDatabaseConnection = function() return cn;
		return cn;
	}
	*/
}