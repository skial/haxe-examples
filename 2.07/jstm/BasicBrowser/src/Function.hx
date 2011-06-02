/**
 * ...
 * @author Cref
 */
extern class Function < TReturn, TArgs, TProto > extends Object < Function < TReturn, TArgs, TProto >> {
	var prototype:TProto;
	var length:Int;
	var caller(default, null):Function<Dynamic,Dynamic,Dynamic>;
	function new(?args:Array<String>,?body:String):Void;
	function call(context:Dynamic,?a0:TArgs,?a1:TArgs,?a2:TArgs,?a3:TArgs,?a4:TArgs,?a5:TArgs,?a6:TArgs,?a7:TArgs,?a8:TArgs,?a9:TArgs):TReturn;
	function apply(context:Dynamic, args:Arguments<TArgs>):TReturn;
	function bind(context:Dynamic,?a0:TArgs,?a1:TArgs,?a2:TArgs,?a3:TArgs,?a4:TArgs,?a5:TArgs,?a6:TArgs,?a7:TArgs,?a8:TArgs,?a9:TArgs):Function<TReturn,TArgs,Object<Dynamic>>;
}