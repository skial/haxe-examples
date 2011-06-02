package jstm;

using hxtc.Tools;

class IE9__ {
	
	static function __init__() {
		xhr();
	}
	
	//IE only creates the console object when the user has activated it during the browsing session
	static var emptyConsole = { log:function() { }, clear:function() { }};
	
	var w:Window;
	var d:HTMLDocument;
	var eWin:HTMLElement;
	
	public function new(w:Window):Void {
		this.w = w;
		d = w.document;
		//used by various patches
		eWin=d.documentElement.appendChild(d.createElement('window'));
		if (w.console==null) untyped w['console'] = emptyConsole;
		//clear console logs for previous page load
		else w.console.clear();
		//IE9 doesn't define HTMLDocument, IE8 does!
		untyped if (!w.HTMLDocument) w.HTMLDocument=w.Document;
		//overwrite window.open so subwindows will be patched
		//TODO: apply to iframe contentWindows as well
		var C = untyped this.constructor;
		var _open:Dynamic = untyped __js__("w.open");
		untyped w.open = function(a,b,c,d) {
			var r = _open(a, b, c, d);
			try {
				//r.document;
				__new__(C,r);
			} catch (e:Dynamic) { };//ignore windows with inaccesible document
			return r;
		}
	}
	
	static var test:Class<Window>;
	
	//We need this in EVERY IE version because IE offers the option TO DISABLE NATIVE XMLHTTP! WHY?!?!?!
	//Does this include IE9?
	static function xhr():Void untyped {
		//use the more complete XDomainRequest instead of XMLHttpRequest when available (IE8 and IE9)
		//doesn't work!!! because XDomainRequest uses onload instead of onreadystatechange, fix later...
		//if (window.XDomainRequest) XMLHttpRequest=XDomainRequest;
		//else 
		if (!window.XMLHttpRequest) {
			__js__("
			var x=function(n){return new ActiveXObject(n+'.XMLHTTP')};
			XMLHttpRequest=function() {
				try{
					return x('MSXML2');
				}
				catch (e) {
					try{
						return x('Microsoft');
					}
					catch (e) {
						document.body.innerHTML = 'Unable to create XMLHttpRequest object, please change your browser settings.<br><a href=\"http://msdn.microsoft.com/en-us/library/ms537505(VS.85).aspx\">Click here</a> for more information.';
					}
				}
			}
			");
		}
	}
}