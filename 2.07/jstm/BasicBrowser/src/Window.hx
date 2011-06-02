/**
 * ...
 * @author Cref
 */

import org.w3c.dom.events.EventListener;

extern class Window
	extends Object<Window>,
	implements org.w3c.dom.css.ViewCSS<HTMLElement>,
	implements org.w3c.dom.html.Window<Window,HTMLDocument> {
	//EventTarget
	function addEventListener(type:String, handler:EventListener<Dynamic>, capture:Bool):Void;
	function removeEventListener(type:String, handler:EventListener<Dynamic>, capture:Bool):Void;
	function dispatchEvent(event:org.w3c.dom.events.Event):Bool;
	//ViewCSS
	function getComputedStyle(element:HTMLElement, ?pseudoElt:String):org.w3c.dom.css.CSSStyleDeclaration;
	//Console
	var console(default,never):{
		function log(v0:Dynamic, ?v1:Dynamic, ?v2:Dynamic, ?v3:Dynamic, ?v4:Dynamic, ?v5:Dynamic, ?v6:Dynamic, ?v7:Dynamic, ?v8:Dynamic, ?v9:Dynamic):Void;
		function clear():Void;
		/*Chrome console:
		assert,count,debug,dir,dirxml,error,group,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn
		*/
	}
	
	var closed(default, never):Bool;//Returns a Boolean value indicating whether a window has been closed or not
	var defaultStatus:String;//Sets or returns the default text in the statusbar of a window
	var document(default, never):HTMLDocument;//Returns the Document object for the window (See Document object)
	//TODO: var frames(default, never):HTMLCollection<Frame>;//Returns an array of all the frames (including iframes) in the current window
	var history(default, never):org.w3c.dom.html.Window.History;//Returns the History object for the window (See History object)
	var innerHeight:Int;//Sets or returns the the inner height of a window's content area
	var innerWidth:Int;//Sets or returns the the inner width of a window's content area
	var length(default, never):Int;//Returns the number of frames (including iframes) in a window
	var location(default, never):org.w3c.dom.html.Window.Location;// Returns the Location object for the window (See Location object)
	var name:String;//Sets or returns the name of a window
	var navigator(default, never):org.w3c.dom.html.Window.Navigator;//Returns the Navigator object for the window (See Navigator object)
	var opener(default, never):Window;//Returns a reference to the window that created the window
	var outerHeight:Int;//Sets or returns the outer height of a window, including toolbars/scrollbars
	var outerWidth:Int;//Sets or returns the outer width of a window, including toolbars / scrollbars
	var pageXOffset(default, never):Int;//Returns the pixels the current document has been scrolled (horizontally) from the upper left corner of the window
	var pageYOffset(default, never):Int;//Returns the pixels the current document has been scrolled (vertically) from the upper left corner of the window
	var parent(default, never):Window;//Returns the parent window of the current window
	var screen(default, never):org.w3c.dom.html.Window.Screen;// Returns the Screen object for the window (See Screen object)
	var screenLeft(default, never):Int;//Returns the x coordinate of the window relative to the screen
	var screenTop(default, never):Int;//Returns the y coordinate of the window relative to the screen
	var screenX(default, never):Int;//Returns the x coordinate of the window relative to the screen
	var screenY(default, never):Int;//Returns the y coordinate of the window relative to the screen
	var self(default, never):Window;//Returns the current window
	var status:String;//Sets the text in the statusbar of a window
	var top(default, never):Window;//Returns the topmost browser window
	function alert(v:Dynamic):Void;
	function prompt(?message:String,?defaultValue:String):String;
	function confirm(v:String):Bool;
	function blur():Void;
	function focus():Void;
	//function open(?url:String, ?name:String, ?specs:String, ?replace:Bool):Window;
	//TODO: check for same domain before calling initWindow
	//can also be moved to initWindow
	function open(?url:String, ?name:String, ?specs:String, ?replace:Bool):Window;
	//TODO: emulate in initWindow
	function close():Void;
	function print():Void;
	function moveBy(x:Int, y:Int):Void;
	function moveTo(x:Int, y:Int):Void;
	function resizeBy(w:Int, h:Int):Void;
	function resizeTo(w:Int, h:Int):Void;
	function scrollBy(w:Int, h:Int):Void;
	function scrollTo(w:Int, h:Int):Void;
	//in reality, setInterval and setTimeout return an Int but you can't use these for anything else but
	//clearInterval and clearTimeout so we can safely add some type safety to it
	function setInterval(fn:Void -> Dynamic,msec:Int):Int;
	function clearInterval(intr:Int):Void;
	function setTimeout(fn:Void -> Dynamic,msec:Int):Int;
	function clearTimeout(tmout:Int):Void;
}