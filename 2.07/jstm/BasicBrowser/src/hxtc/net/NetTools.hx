/**
 * ...
 * @author Cref
 */

package hxtc.net;

class NetTools {
	public static function ipStringToInt(ip:String):Int {
		var d = ip.split('.');
		return (((((Std.parseInt(d[0]) * 256) + Std.parseInt(d[1])) * 256) + Std.parseInt(d[2])) * 256) + Std.parseInt(d[3]);
	}

	public static function ipIntToString(ip:Int):String {
		var d = ''+ip%256,i=3;
		for (i in 0...3) {
			ip = Math.floor(ip/256);
			d = ip % 256 + '.' + d;
		}
		return d;
	}
}