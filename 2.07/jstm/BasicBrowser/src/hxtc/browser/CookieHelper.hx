package hxtc.browser;

using ES5;

class CookieHelper implements Dynamic<Cookie> {
	public static function getCookieHelper(doc:HTMLDocument):CookieHelper {
		//each document should only have one associated CookieHelper instance
		return doc.__cookieHelper == null?doc.__cookieHelper = new CookieHelper(doc):doc.__cookieHelper;
	}
	//shortcut for easy cookie creation (since we can not specify optional typedef properties)
	public static function createCookie(?value:String, ?expires:Date, ?path:String, ?domain:String, ?secure:Bool):Cookie {
		return { value:value, expires:expires, path:path, domain:domain, secure:secure };
	}
	function new(doc:HTMLDocument):Void {
		var initialNames = [];
		//read all cookies
		var arr = doc.cookie.split('; ');
		for (pair in arr) {
			var cookie = pair.split('='), name = cookie[0];
			initialNames.push(name);
			set(ES5.global.unescape(name), { value:ES5.global.unescape(cookie[1]) } );
		}
		var t = this;
		//update document.cookie
		doc.defaultView.addEventListener('unload', function(e) {
			//first, expire all cookies that were removed since page load:
			for (name in initialNames) {
				var c = t.get(name);
				if (c == null||c.value==null) doc.cookie = name + '=; expires=01/01/1970 00:00:00';
			}
			//write all cookies:
			t.forEach(function(name:String, f) {
				var c:Cookie = t.get(name);
				if (c != null && c.value != null) {
					var arr = [ES5.global.escape(name) + '=' + ES5.global.escape(c.value)];
					if (c.expires != null) arr.push('expires=' + c.expires.toGMTString());
					if (c.path != null) arr.push('path='+ES5.global.escape(c.path));
					if (c.domain != null) arr.push('domain='+ES5.global.escape(c.domain));
					if (c.secure) arr.push('secure');
					doc.cookie = arr.join('; ');
					trace(arr.join('; '));
				}
			});
			doc.defaultView.alert('done!');
		}, false);
	}
	public function resolve(name:String):Cookie {
		if (!has(name)) set(name, { } );
		return get(name);
	}
}

typedef Cookie = { value:String, expires:Date, path:String, domain:String, secure:Bool }
