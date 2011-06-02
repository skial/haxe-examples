/**
 * Faster Base64 encoding and decoding using activex objects.
 * @author Cref
 */

package hxtc;


class Base64_activex__ {
	private static var node = {
		//appears to have built-in utf-8 encoding and decoding
    var n = new activex.msxml2.DOMDocument().createElement('b');
    n.dataType = 'bin.base64';
		n;
	}
	public static function encode(string:String):String {
    node.nodeTypedValue = TMP.stringToByteArray(string, 'utf-8');
    return untyped node.text.replace(__js__('/\\n/g'),'');//faster then splitting and joining
		//return StringTools.replace(node.text,'\n','');
    //return node.text.split('\n').join('');
	}
	public static function decode(string:String):String {
		node.text = string;
    return TMP.byteArrayToString(node.nodeTypedValue,'utf-8');
	}
}
