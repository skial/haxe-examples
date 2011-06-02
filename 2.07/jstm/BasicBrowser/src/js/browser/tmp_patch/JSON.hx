/**
 * ...
 * @author Cref
 */

package js.browser.patch;

/*
 * optimized JSON handling for js targets that don't have native support.
 * when js_split is used, the dynamic loader will decide on whether it will load this class or not
 * depending on whether native JSON is available.
 * it should somehow also be possible to get native JSON for asp and wsh but I have no idea how
 * and Microsoft is of no help, see my post: http://msdn.microsoft.com/en-us/library/cc836458(VS.85).aspx
 */
class JSON {
	
	//adds toJSON functions to base prototypes
	static function __init__():Void {
		#if js_browser
		if (untyped window.JSON) throw new org.ecmascript.Error('incorrect usage');
		untyped window.JSON = JSON;
		#end
		
		//Format integers to have at least two digits.
		var f = function(n):Dynamic return untyped __js__("n<10?'0'+n:n");
		//Format integers to have at least three digits.
		var m = function(n):Dynamic return untyped __js__("n<100?'0'+n:n<10?'00'+n:n");
		untyped Date.prototype.toJSON = function() {
			return '"'+
				this.getUTCFullYear()				+'-'+
				f(this.getUTCMonth()+1)			+'-'+
				f(this.getUTCDate())				+'T'+
				f(this.getUTCHours())				+':'+
				f(this.getUTCMinutes())			+':'+
				f(this.getUTCSeconds())			+':'+
				m(this.getUTCMilliseconds())+'Z'+
			'"';
		}
		untyped String.prototype.toJSON = function() {
			//TODO: make a single replace call?
			return __js__("'\"'+this
				.replace(/\\\\/g,'\\\\\\\\')
				.replace(/\\\"/g,'\\\\\\\"')
				.replace(/\\n/g,'\\\\n')
				.replace(/\\r/g,'\\\\r')
				.replace(/\\t/g, '\\\\t') + '\"'
			");
		}
		untyped Array.prototype.toJSON = function() {
			var r=[],t:Array<Dynamic>=this;
			for (n in t) r.push(JSON.stringify(n));
			return '['+r.join(',')+']';
		}
		untyped Number.prototype.toJSON = Number.prototype.toString;
		untyped Boolean.prototype.toJSON = Boolean.prototype.toString;
	}
	
	//checks if a string can safely be parsed using eval
	static function isSafe(str:String):Bool {
		return !untyped __js__("str
		.replace(/\\\\(?:[\"\\\\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@')//weet niet precies waar t voor dient maar komt uit json2.js
		//todo: hexadecimalen: 0x3AEF
		.replace(/\"[^\"\\\\\\r\\n]*(?:\\\\.[^\"\\\\\\r\\n]*)*\"|'[^'\\\\\\r\\n]*(?:\\\\.[^'\\\\\\r\\n]*)*'|true|false|NaN|Infinity|-Infinity|null|undefined|-?\\d+(?:\\.\\d*)?(?:[eE][+\\-]?\\d+)?/g,'')//double quoted strings, single quoted strings, true, false, NaN, Infinity, -Infinity, null, undefined, Numbers
		.replace(/[\\{,]\\w+:/g,'')//keys zonder quotes toestaan - NIET VOLGENS DE STANDAARD! (evenals single quoted keys)
		.replace(/^[\\[\\],{:}\\s]*$/,'')//overgebleven toegestane karakters wissen
		.length
		");
	}
	
	//TODO: implement reviver
	public static function parse(json:String, ?reviver:String->Dynamic->Dynamic):Dynamic {
		if (!isSafe(json)) throw new org.ecmascript.SyntaxError('unsafe JSON');
		return org.ecmascript.ECMA.eval('(' + json + ')');//may throw SyntaxError
	}
	
	//nog iets doen met hasOwnProperty enzo...
	//TODO: prevent converting circular structure to JSON (throws TypeError)
	public static function stringify(value:Dynamic):String {
		//	return value.toJSON?value.toJSON():untyped Object.prototype.toJSON.apply(value);
		try {
			return value.toJSON?value.toJSON():_toJSON(value);
		}
		catch (e:Dynamic) {
			//objects that can not be stringified should return null
			return 'null';
		}
	}
	
	static function fixVarName(n:String) return untyped __js__("/^\\w*$/.test(n)?n:'\\''+n+'\\''")
	
	static function _toJSON(value:Dynamic) {
		var f=Reflect.fields(value),r=[];
		//eerst n via RegExp checken
		for (n in f) {
			var v = JSON.stringify(Reflect.field(value,n));
			if (v!='null') r.push('"'+fixVarName(n) + '":' + v);
		}
		return '{' + r.join(',') + '}';
	}
	
}