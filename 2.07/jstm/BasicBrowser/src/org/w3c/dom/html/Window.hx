/**
 * HTML5 Window
 * 
 * extends org.w3c.dom.html.Window
 * 
 * http://dev.w3.org/html5/spec/browsers.html#window
 * 
 * Important info about target / currentTarget
 * http://mysticnomad.wordpress.com/2008/03/21/difference-between-eventtarget-and-eventcurrenttarget-properties-in-an-event-object/
 * 
 * @author Cref
 */
package org.w3c.dom.html;

interface Window<TWin,TDoc>
//implements org.w3c.dom.events.EventTarget
{

	var closed(default, never):Bool;//Returns a Boolean value indicating whether a window has been closed or not
	var defaultStatus:String;//Sets or returns the default text in the statusbar of a window
	var document(default, never):TDoc;//Returns the Document object for the window (See Document object)
	//TODO: var frames(default, never):HTMLCollection<Frame>;//Returns an array of all the frames (including iframes) in the current window
	var history(default, never):org.w3c.dom.html.Window.History;//Returns the History object for the window (See History object)
	var innerHeight:Int;//Sets or returns the the inner height of a window's content area
	var innerWidth:Int;//Sets or returns the the inner width of a window's content area
	var length(default, never):Int;//Returns the number of frames (including iframes) in a window
	var location(default, never):org.w3c.dom.html.Window.Location;// Returns the Location object for the window (See Location object)
	var name:String;//Sets or returns the name of a window
	var navigator(default, never):org.w3c.dom.html.Window.Navigator;//Returns the Navigator object for the window (See Navigator object)
	//TODO: WindowProxy
	var opener(default, never):TWin;//Returns a reference to the window that created the window
	var outerHeight:Int;//Sets or returns the outer height of a window, including toolbars/scrollbars
	var outerWidth:Int;//Sets or returns the outer width of a window, including toolbars / scrollbars
	var pageXOffset(default, never):Int;//Returns the pixels the current document has been scrolled (horizontally) from the upper left corner of the window
	var pageYOffset(default, never):Int;//Returns the pixels the current document has been scrolled (vertically) from the upper left corner of the window
	//TODO: WindowProxy
	var parent(default, never):TWin;//Returns the parent window of the current window
	var screen(default, never):org.w3c.dom.html.Window.Screen;// Returns the Screen object for the window (See Screen object)
	var screenLeft(default, never):Int;//Returns the x coordinate of the window relative to the screen
	var screenTop(default, never):Int;//Returns the y coordinate of the window relative to the screen
	var screenX(default, never):Int;//Returns the x coordinate of the window relative to the screen
	var screenY(default, never):Int;//Returns the y coordinate of the window relative to the screen
	//TODO: WindowProxy
	var self(default, never):TWin;//Returns the current window
	var status:String;//Sets the text in the statusbar of a window
	//TODO: WindowProxy
	var top(default, never):TWin;//Returns the topmost browser window
	function alert(v:Dynamic):Void;
	function prompt(?message:String,?defaultValue:String):String;
	function confirm(v:String):Bool;
	function blur():Void;
	function focus():Void;
	//function open(?url:String, ?name:String, ?specs:String, ?replace:Bool):Window;
	//TODO: check for same domain before calling initWindow
	//can also be moved to initWindow
	//TODO: WindowProxy
	function open(?url:String, ?name:String, ?specs:String, ?replace:Bool):TWin;
	//TODO: emulate in initWindow
	function close():Void;
	function print():Void;
	function moveBy(x:Int, y:Int):Void;
	function moveTo(x:Int, y:Int):Void;
	function resizeBy(w:Int, h:Int):Void;
	function resizeTo(w:Int, h:Int):Void;
	function scrollBy(w:Int, h:Int):Void;
	function scrollTo(w:Int, h:Int):Void;
	function setInterval(fn:Void -> Dynamic,msec:Int):Int;
	function clearInterval(intr:Int):Void;
	function setTimeout(fn:Void -> Dynamic,msec:Int):Int;
	function clearTimeout(tmout:Int):Void;
}

typedef History = {
	var length(default, never) : Int;
	function back() : Void;
	function forward() : Void;
	function go( p : Int ) : Void;//standard library defines p as Dynamic
}
typedef Location = {/* > hxtc.web.Location, //can't do this because property access will be generated with getters and setters!*/

	var protocol:String;
	var host:String;
	var port:Int;
	var hostname:String;
	var pathname:String;
	var search:String;
	var hash:String;
	var href:String;
	function toString():String;

	function assign( url : String ) : Void;
	function reload( ?forceReload : Bool ) : Void;
	function replace( url : String ) : Void;
}
typedef Navigator = {
	// var plugins : HtmlCollection<???>
	var appCodeName(default, never) : String;
	var appName(default, never) : String;
	var appVersion(default, never) : String;
	var cookieEnabled(default, never) : Bool;
	var platform(default, never) : String;
	var userAgent(default, never) : String;
	/* IE only ?
	var appMinorVersion : String
	var browserLanguage : String
	var cpuClass : String;
	var onLine : Bool;
	var systemLanguage : String;
	var userLanguage : String;
	*/
	function javaEnabled() : Bool;
	function taintEnabled() : Bool;
}
typedef Screen = {
	var availHeight(default, never) : Int;
	var availWidth(default, never) : Int;
	var colorDepth(default, never) : Int;
	var height(default, never) : Int;
	var width(default, never) : Int;
	// FF only ? var pixelDepth : Int;
	/* IE only ?
	var bufferDepth : Int;
	var deviceXDPI : Int;
	var deviceYDPI : Int;
	var logicalXDPI : Int;
	var logicalYDPI : Int;
	var updateInterval : Int;
	*/
}