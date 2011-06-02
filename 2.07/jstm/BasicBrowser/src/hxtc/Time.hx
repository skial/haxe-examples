/*
Functions for working with date and time

todo: nuttige functies uit D:\CWF\__CWF 1.0\Tijd\ overnemen

Met name nuttig voor benchmarking.
Enkele resultaten:
- een global replace is beduidend sneller dan splitten en joinen
- ...?
*/
package hxtc;

class Time {

	private static function msec():Float{
		return Date.now().getTime();
	}
	//returns milliseconds it takes to run function f n times
	public static function measure(f:Void->Void,?n:Int=1):Float{
		if (n<1) return 0;
		var t=msec();
		while(n>0){
			f();
			n--;
		}
		return msec()-t;
	}
	
}