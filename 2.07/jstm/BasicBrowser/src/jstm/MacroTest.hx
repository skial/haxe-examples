package jstm;

import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Context;

using StringTools;

/*
 * testing the new macro features
 */
class MacroTest {
	
	@:macro public static function run(e:Expr):Expr {
		trace(e);
		return e;
	}
	
	@:macro public static function useType(e:ExprRequire<Class<Dynamic>>):Expr {
		var t = _getTypeName(e);
		return Context.parse('function(fn:Class<'+t+'>->Void)jstm.Runtime.loadClass("'+t+'",fn)',e.pos);
	}
	
	@:macro public static function getTypeName(e:ExprRequire<Class<Dynamic>>):Expr {
		return {expr:stringDef(_getTypeName(e)),pos:e.pos};
	}
	
	#if macro
	public static function _getTypeName(e:ExprRequire<Class<Dynamic>>):String {
		switch(Context.typeof(e)) {
			case TType(ref, _):
				return ref.toString().replace('#','');
			default:
		}
		Context.error('should be a type: ' + Context.typeof(e), e.pos);
		return null;
	}
	
	static function stringDef(s:String):ExprDef {
		return ExprDef.EConst(Constant.CString(s));
	}
	#end
}