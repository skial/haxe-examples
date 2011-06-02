/*
 * optimized JSON implementation for js targets that don't have native support.
 * when js_split is used, the dynamic loader will decide on whether it will load this class or not
 * depending on whether native JSON is available.
 * it should somehow also be possible to get native JSON for asp and wsh but I have no idea how
 * and Microsoft is of no help, see my post: http://msdn.microsoft.com/en-us/library/cc836458(VS.85).aspx
 */
class JSON__ {
	
	#if browser
	function new() {
		ES5.global.JSON = JSON__;
	}
	#end
	
	//adds toJSON functions to base prototypes
	static function __init__():Void {
		if (ES5.global.JSON) throw new Error('incorrect usage');
	}
	
	//TODO: implement reviver
	public static function parse(json:String, ?reviver:String->Dynamic->Dynamic):Dynamic {
		if (!isSafe(json)) throw new SyntaxError('unsafe JSON');
		return ES5.global.eval('(' + json + ')');//may throw SyntaxError
	}
	
	//nog iets doen met hasOwnProperty enzo...
	//TODO: prevent converting circular structure to JSON (throws TypeError)
	//TODO: use toSource where available? (Moz)
	public static function stringify(v:Dynamic):String {
		//	return value.toJSON?value.toJSON():untyped Object.prototype.toJSON.apply(value);
		try {
			return switch(v.constructor) {
				case Date: jsonDate(v);
				case String: jsonString(v);
				case Array: jsonArray(v);
				case Number,Bool: v.toString();
				default: jsonObject(v);
			}
		}
		catch (e:Dynamic) {
			//objects that can not be stringified should return null
			return 'null';
		}
	}
	

	//Format integers to have at least two digits.
	static function f(n):Dynamic return untyped __js__("n<10?'0'+n:n")
	//Format integers to have at least three digits.
	static function m(n):Dynamic return untyped __js__("n<100?'0'+n:n<10?'00'+n:n")
	
	static function jsonDate(v:Date):String untyped {
		return '"'+
			v.getUTCFullYear()		+'-'+
			f(v.getUTCMonth()+1)	+'-'+
			f(v.getUTCDate())		+'T'+
			f(v.getUTCHours())		+':'+
			f(v.getUTCMinutes())	+':'+
			f(v.getUTCSeconds())	+':'+
			m(v.getUTCMilliseconds())+'Z'+
		'"';
	}
	
	//weet niet precies waar t voor dient maar komt uit json2.js
	static var re1 = untyped __js__("/\\\\(?:[\"\\\\\\/bfnrt]|u[0-9a-fA-F]{4})/g");
	//double quoted strings, single quoted strings, true, false, NaN, Infinity, -Infinity, null, undefined, Numbers
	//todo: hexadecimalen: 0x3AEF
	static var re2 = untyped __js__("/\"[^\"\\\\\\r\\n]*(?:\\\\.[^\"\\\\\\r\\n]*)*\"|'[^'\\\\\\r\\n]*(?:\\\\.[^'\\\\\\r\\n]*)*'|true|false|NaN|Infinity|-Infinity|null|undefined|-?\\d+(?:\\.\\d*)?(?:[eE][+\\-]?\\d+)?/g");
	//keys zonder quotes toestaan - NIET VOLGENS DE STANDAARD! (evenals single quoted keys)
	static var re3 = untyped __js__("/[\\{,]\\w+:/g");
	//overgebleven toegestane karakters wissen
	static var re4 = untyped __js__("/^[\\[\\],{:}\\s]*$/");
	
	//checks if a string can safely be parsed using eval
	static function isSafe(str:String):Bool {
		return untyped str.replace(re1, '@').replace(re2,'').replace(re3,'').replace(re4,'').length==0;
	}
	
	static function fixVarName(n:String) return untyped __js__("/^\\w*$/.test(n)?n:'\\''+n+'\\''")
	
	static function jsonString(v:String):String untyped {
		//TODO: make a single replace call?
		return __js__("'\"'+v
			.replace(/\\\\/g,'\\\\\\\\')
			.replace(/\\\"/g,'\\\\\\\"')
			.replace(/\\n/g,'\\\\n')
			.replace(/\\r/g,'\\\\r')
			.replace(/\\t/g, '\\\\t') + '\"'
		");
	}
	
	static function jsonArray(v:Array<Dynamic>):String {
		var r=[];
		for (n in v) r.push(JSON.stringify(n));
		return '['+r.join(',')+']';
	}

	static function jsonObject(o:Dynamic) {
		var f=Reflect.fields(o),r=[];
		//eerst n via RegExp checken
		for (n in f) {
			var v = JSON.stringify(Reflect.field(o,n));
			if (v!='null') r.push('"'+fixVarName(n) + '":' + v);
		}
		return '{' + r.join(',') + '}';
	}
	
}