/**
 * Extern classes for the browser platform.
 * gives access to the global window instance
 * @author Cref
 */

package js.browser;

//all browser-based targets
//#if (js_air || js_browser || js_hta)
#if js

import ECMAScript;

using hxtc.use.ForString;

class Browser {
	
	//public static inline var window:org.w3c.dom.html.Window = untyped __js__("window");
	public static inline var window:Window = untyped __js__("window");
	//is determined in js.Boot but made accessible here
	public static inline var ieVersion:Int = untyped js.Boot.ie;
	//tells you if the browser is a mobile version
	//matches iPhone, iPad, IEMobile, Nokia S60, Samsung, Opera, RIM Blackberry, HP WebOS
	public static var isMobile:Bool = ~/(mobile|symbian|opera mini|blackberry|webos)/i.match(window.navigator.userAgent);
	
	//returns the browser engine (a.k.a. layout engine, a.k.a. render engine)
	public static var engine:BrowserEngine = switch(untyped js.Boot.eng) {
		case 1: BrowserEngine.trident;
		case 2: BrowserEngine.presto;
		case 3: BrowserEngine.webkit;
		//TODO: verify if this check works for all Gecko-based browsers:
		default: untyped window.navigator.product=='Gecko'?BrowserEngine.gecko:BrowserEngine.unknown;
	}
	
	//TODO: scriptEngine?
	
	public static function readCookie(name:String):String {
		var re = new EReg('(?:^|;)\\s?' + ECMAScript.global.escape(name) + '=(.*?)(?:;|$)', 'i');
		return re.match(Browser.window.document.cookie)?ECMAScript.global.unescape(re.matched(1)):null;
	}
	//TODO: writeCookie(name:String, value, ?expires:Date, ?domain:String, ?path:String)
	
}



typedef CSSRule = js.browser.dom.CSSRule;
typedef CSSRuleList = js.browser.dom.CSSRuleList;
typedef CSSStyleDeclaration = js.browser.dom.CSSStyleDeclaration;
typedef CSSStyleRule= js.browser.dom.CSSStyleRule;
typedef CSSStyleSheet = js.browser.dom.CSSStyleSheet;
typedef Document<TDoc,TElm> = js.browser.dom.Document<TDoc,TElm>;
typedef Element<TDoc,TElm> = js.browser.dom.Element<TDoc,TElm>;
typedef Event = js.browser.dom.Event;
typedef HTMLAnchorElement = js.browser.dom.HTMLAnchorElement;
typedef HTMLBaseElement = js.browser.dom.HTMLBaseElement;
typedef HTMLBodyElement = js.browser.dom.HTMLBodyElement;
typedef HTMLDivElement = js.browser.dom.HTMLDivElement;
typedef HTMLDocument = js.browser.dom.HTMLDocument;
typedef HTMLElement = js.browser.dom.HTMLElement;
typedef HTMLFormElement = js.browser.dom.HTMLFormElement;
typedef HTMLHeadElement = js.browser.dom.HTMLHeadElement;
typedef HTMLHtmlElement = js.browser.dom.HTMLHtmlElement;
typedef HTMLIFrameElement = js.browser.dom.HTMLIFrameElement;
typedef HTMLImageElement = js.browser.dom.HTMLImageElement;
typedef HTMLInputElement = js.browser.dom.HTMLInputElement;
typedef HTMLScriptElement = js.browser.dom.HTMLScriptElement;
typedef HTMLSpanElement = js.browser.dom.HTMLSpanElement;
typedef HTMLTableElement = js.browser.dom.HTMLTableElement;
typedef HTMLTextAreaElement = js.browser.dom.HTMLTextAreaElement;
typedef KeyboardEvent = js.browser.dom.KeyboardEvent;
typedef MouseEvent = js.browser.dom.MouseEvent;
typedef Node<T:js.browser.dom.Node<T,TDoc>,TNodeList,TDoc> = js.browser.dom.Node<T,TNodeList,TDoc>;
typedef NodeList<T> = js.browser.dom.NodeList<T>;
typedef StyleSheet = js.browser.dom.StyleSheet;
typedef Text = js.browser.dom.Text;
typedef UIEvent = js.browser.dom.UIEvent;
typedef Window = js.browser.dom.Window;
typedef XMLHttpRequest = js.browser.dom.XMLHttpRequest;

#end