/**
 * TODO: fully support some hxtc js targets: WSH, Rhino, JScript,NET, JSDB etc.
 * @author Cref
 */
package haxe;

#if jscript
import activex.wscript.Shell;
import activex.wscript.Network;
#end

#if (js || flash)
class Sys {//TODO
	public static function time():Float {
		//prevent Date dependency just for a timestamp
		return #if js untyped __js__("new window['Date']")#else Date.now#end().getTime() / 1000;
		//return flash.Lib.getTimer() / 1000;//is there any difference?
	}
	#if jscript
	static var shell = new Shell();
	static var nw = new Network();
	
	public static inline function getCwd():String {
		return shell.currentDirectory;
	}
	public static inline function setCwd(dir:String):Void {
		shell.currentDirectory=dir;
	}
	public static inline function systemName():String {
		return nw.computerName;
	}
	public static inline function sleep(msec:Int):Void {
		#if asp
		//ASP doesn't support sleep but it does support Shell.popup! :)
		if (msec < 1000 || msec / 1000 % 1 > 0) throw 'please use a multiple of 1000';
		//it works... but only with whole seconds
		new Shell().popup('', untyped msec / 1000);
		//TODO: support msecs using activex.wscript.Shell.run('cscript.exe eval.js "WScript.sleep(123)"') ?
		#else
		WScript.sleep(msec);
		#end
	}
	#end
}
#elseif neko
typedef Sys = neko.Sys;
#elseif cpp
typedef Sys = cpp.Sys;
#elseif php
typedef Sys = php.Sys;
#end