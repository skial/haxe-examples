/**
 * Class for working with the Command Line Interface.
 * Should work the same for every target that has access to a CLI.
 * Currently only focusses on neko/cpp but will support Rhino, WSH, .NET, JSDB etc.
 * Cross-target support should be taken care of as low-level as possible so for
 * instance, every target should implement haxe.Sys.exit which is in turn being called
 * from hxtc.CLI.exit.
 * 
 * TODO: read textstrings from resource file, use compiler directive for language selection
 * 
 * @author Cref
 */

package hxtc;
using hxtc.use.ForString;

class CLI {
	private static var stdin =  haxe.io.File.stdin();
	//returns the current path (the path from where the executable was called)
	//TODO: fix slashes, check results on different platforms
	public static inline var currentPath:String = haxe.Sys.getCwd();
	//returns the absolute path of the executable file that is currently running
	public static var executableFilename:String;
	//returns the filename of the executable file that is currently running
	public static inline var executablePath:String = {
		var execPath = haxe.Sys.executablePath().split('\\');
		executableFilename=execPath.pop();
		execPath.join('\\');
	}
	public static var arguments:Hash<String> = {
		var arr=haxe.Sys.args();
		var h=new Hash<String>();
		for (arg in arr) {
			arg = arg.toLowerCase().replaceStart('?').replaceStart('/').replaceStart('-');
			arg.contains('=')?h.set(arg.before('='),arg.after('=')):h.set(arg,null);
		}
		h;
	}
	public static inline function write(str:String):Void {
		haxe.Lib.print(str);
	}
	public static inline function writeln(str:String):Void {
		haxe.Lib.println(str+'\n');
	}
	public static inline function readChar(echo:Bool=false):Int {
		return haxe.io.File.getChar(echo);
	}
	public static inline function readln():String {
		return stdin.readLine();
	}
	public static inline function exit(code:Int):Void {
		haxe.Sys.exit(code);
	}
	public static function pause():Void {
		write('Press any key to continue. . . ');
		readChar();
		writeln('');
	}
	public static function prompt(str:String):String {
		write(str+' ');
		return readln();
	}
	public static function confirm(str:String):Bool {
		write(str + ' (y/n) ');
		var y = 121, Y=89, n=110, N=78,input=null;
		while (true){ switch(input=readChar()) {
			case y, Y, n, N: break;
		}}
		var r = input == y || input == Y;
		writeln(r?'yes':'no');
		return r;
	}
	/*
	public static function choise(options:Array<String>) {
		if (options.length < 2 || options.length > 9) throw ('options.length out of range 2-9');
		for (n in 0...options.length) writeln((n+1) + ': ' + options[n]);
		write('please choose: (1 - '+options.length+') ');
		TODO..... besluiten wat een handige manier is om dit te gaan gebruiken
	}
	*/

}