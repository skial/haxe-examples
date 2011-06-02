/*
 * will be part of ECMAScript 5 standard in the near future so we define JSON here.
 * 
 * TODO: patch native IE JSON (replace single quotes with double quotes, add double quotes around keys)
 * TODO: make compatible with ECMA standard JSON output (only double-quoted names are allowed!)
 * TODO: add support for other targets
 */
import JSON__;//always compile

#if jscript //put all js platforms without native JSON here
typedef JSON = JSON__;
#elseif js //js platforms that SHOULD have native support (browsers are patched by jstm.Host by default)
extern class JSON {
	static function parse(json:String, ?reviver:String->Dynamic->Dynamic):Dynamic;
	static function stringify(value:Dynamic):String;
}
#else
//TODO: support other targets
#end