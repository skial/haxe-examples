/**
 * TODO: nog bepalen waar deze functies definitief moeten komen en hoe ze moeten heten
 * @author Cref
 */

package hxtc;

class TMP {
	
	private static var adTypeBinary = 1;
	private static var adTypeText = 2;
	public static function byteArrayToString(byteArray:Dynamic,charset:String):String {
		var stream = new activex.adodb.Stream();
		stream.type = adTypeBinary;
		stream.open();
		stream.write(byteArray);
		stream.position = 0;
		stream.type = adTypeText;
		if (charset!=null) stream.charset = charset;
		var r = stream.readText();
		stream.close();
		return r;
	}
	public static function stringToByteArray(string:String,charset:String):Dynamic {
		var stream = new activex.adodb.Stream();
		stream.type = adTypeText;
		if (charset!=null) stream.charset = charset;
		stream.open();
		stream.writeText(string);
		stream.position = 0;
		stream.type = adTypeBinary;
		if (charset.toLowerCase() == 'utf-8') stream.position=3;//skip BOM TODO: check length
		var r = stream.read();
		stream.close();
		return r;
	}
}