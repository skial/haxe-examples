/**
 * ...
 * @author Cref
 */

package hxtc.use;

using StringTools;
using ES5;

class ForDate {
	
	//http://www.w3.org/TR/NOTE-datetime
	//TODO: can be optimized a bit
	public static function toW3CString(date:Date):String {
		var o = date.getTimezoneOffset();
		var sign = o > 0?'-':'+';
		var d = new Date(null, null, null, null,cast Math.abs(o), null);
		return date.toString().replace(' ', 'T')+sign+formatTime(d, 'hh:mm');
	}
	
	public static function hasTimePart(date:Date):Bool {
		return date.getHours() + date.getMinutes() + date.getSeconds() > 0;
	}
	
	public static function getMonthLength(month:Int, year:Int) {
		return new Date(year, month + 1, 0,0,0,0).getDate();
	}
	public static function getMonthFirstDay(month:Int, year:Int) {
		return new Date(year, month, 1,0,0,0).getDay();
	}
	
	public static function formatDate(date:Date, format:String) {
		return _format(date, format, dArr);
	}
	public static function formatTime(date:Date, format:String) {
		return _format(date, format, tArr);
	}
	public static function formatDateTime(date, dateFormat, timeFormat,?noTime:String) {
		return _format(date, dateFormat, dArr) + (noTime==null||hasTimePart(date)?_format(date, timeFormat, tArr):noTime);
	}
	public static function formatTimeDate(date, timeFormat,?noTime:String, dateFormat) {
		return (noTime==null||hasTimePart(date)?_format(date, timeFormat, tArr):noTime) + _format(date, dateFormat, dArr);
	}
	
	private static var dArr = 'yyyy,yy,mm,m,dd,d'.split(',');
	private static var tArr = 'hh,h,mm,m,ss,s'.split(',');
	private static var obj={y:'FullYear',m:'Month',d:'Date',h:'Hours',s:'Seconds'};
	private static function _format(date:Date,format:String='',arr:Array<String>){
		for (n in arr){
			var re=new EReg(n,'g');
			if (re.match(format)){
				var c=n.charAt(0),v:Dynamic;
				v=c=='m'
					?arr==dArr
						?date.getMonth()+1
						:date.getMinutes()
					:untyped __js__("date['get'+this.obj[c]]()")//js only for now...
				;
				if (n.length==2) v=c=='y'
					?(''+v).substr(2)
					:(v>9?'':'0')+v
				;
				format=re.replace(format,v);
			}
		}
		return format;
	}
}