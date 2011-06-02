/**
 * ...
 * @author Cref
 */

package hxtc.use;
using StringTools;
using hxtc.use.ForString;

class ForString {
	/*
	#if js
	//short inlined notation form that I know is supported in js, don't know yet about other targets
	//TODO: check if inline doesn't introduce bugs!
	public static inline function format(str:Dynamic, ifEmpty:String = '', before:String = '', after:String = ''):String
		return untyped str?before+str+after:ifEmpty
	#else
	//empty in this case means: null or ''
	//str:Dynamic because it should wordk for any value that can be translated to a string
	public static function format(str:Dynamic, ifEmpty:String = '', before:String = '', after:String = '')
		return str == null||str==''?ifEmpty:before+str+after
	#end
	*/
	public static function times(str:String, n:Int) {
		var a = [];
		for (x in 0...n) a.push(str);
		return a.join('');
	}
	public static function contains(str:String, strFind)
		return str.indexOf(strFind) > -1
	
	//TODO: check if all escapes are really necessary
	static var ERegChars = ~/([\[\\\^\$\.|\?\*\+\(\){}])/g;
	
	public static function escapeERegChars(str:String)
		return ERegChars.replace(str,'\\$1')
	
	//converts this-notation to thisNotation, useful for translating CSS styles
	public static function camelize(str:String, char = '-'):String {
		return new EReg(char.escapeERegChars() + '(.)', '').customReplace(str, function(re) return re.matched(1).toUpperCase() );
	}
	
	//converts thisNotation to this-Notation, useful for translating CSS styles and HTTP headers
	//since JavaScript doesn't support lookbehinds, we use two capturing groups
	public static function uncamelize(str:String, char = '-'):String {
		char = char.escapeERegChars();
		return ~/([^^\W])([A-Z])/.customReplace(str, function(re) return re.matched(1) + char + re.matched(2) );
	}
	
	//makes first letter uppercase
	public static function capitalize(str:String):String
		return str.charAt(0).toUpperCase() + str.substr(1)
	
	//makes first letter lowercase
	public static function uncapitalize(str:String):String
		return str.charAt(0).toLowerCase() + str.substr(1)
	
	public static function replaceStart(str:String, strFind:String, ?strReplace:String=''):String
		return str.startsWith(strFind)?strReplace+str.substr(strFind.length):str
	
	public static function replaceEnd(str:String, strFind:String, ?strReplace:String=''):String
		return str.endsWith(strFind)?str.substr(0,str.length-strFind.length)+strReplace:str
	
	//TODO: wel of niet lege string retourneren als s2 niet in s1 voorkomt?
	//TODO: optioneel argument voor aantal karakters?
	public static function before(s1:String,s2:String,?optionalMode:Bool):String{
		var i=s1.indexOf(s2);
		return (i==-1)?optionalMode?s1:'':s1.substr(0,i);
	}
	public static function beforeLast(s1:String,s2:String,?optionalMode:Bool):String{
		var i=s1.lastIndexOf(s2);
		return (i==-1)?optionalMode?s1:'':s1.substr(0,i);
	}
	public static function after(s1:String,s2:String,?optionalMode:Bool):String{
		var i=s1.indexOf(s2);
		return (i==-1)?optionalMode?s1:'':s1.substr(i+s2.length);
	}
	public static function afterLast(s1:String,s2:String,?optionalMode:Bool):String{
		var i=s1.lastIndexOf(s2);
		return (i==-1)?optionalMode?s1:'':s1.substr(i+s2.length);
	}
	//TODO: support other targets
	#if (js||flash)
	public static inline function escape(s:String) return ES5.global.escape(s)
	public static inline function unescape(s:String) return ES5.global.unescape(s)
	#end
}