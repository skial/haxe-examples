/**
 * JavaScript Type Manager Runtime
 * 
 * NOTE: classnames/paths use '$' instead of '.' everywhere internally
 * External (public) methods should accept '.'
 * 
 * TODO: integrate resource loading
 * 
 * @author Cref
 */
package jstm;

#if js
import jstm.Host;
//make sure jstm.Std__ is always compiled
import Std__;

using ES5;

class Runtime {
	
	static var host:Runtime;
	function new() {
		host = this;
	}
	
	static function useType(tn:String,callbck:Dynamic->Void):Void {
		on(tn,READY,function() callbck(getType(tn)));
	}
	
	public static inline function useClass<T>(className:String, ?callbck:Class<T>->Void) useType(className,callbck)
	
	//global variable will be generated
	public static var global:ES5 = untyped this;
	//functions that are part of ECMAScript. TODO: adapt Reflect class
	static function has(o:Dynamic,n:String):Bool return untyped __js__("n in o")
	static function forEach(o:Dynamic, f:String->(Void->Void)->Void):Void untyped {
		var x = function() x = null;
		__js__("for(var n in o){f(n,x); if (!x) break}");
	}
	
	//copies all fields of o2 to o1 and returns o1
	static function setFields(o1:Dynamic, o2:Dynamic):Dynamic {
		if (o2 != null) o2.forEach(function(n, x) o1.set(n, o2.get(n)));
		return o1;
	}
	
	static function first(o:Dynamic):String untyped {
		__js__("for(var n in o)break");
		return n;
	}
	
	public static function closure(o:Dynamic,f:Dynamic) {
		var m:Dynamic = o.get(f);
		if(m == null) return null;
		var r:Dynamic = function() { return m.apply(o,ES5.arguments); };//TODO: use ObjectHash for object/function combinations
		r.scope = o;
		r.method = m;
		r._name = f;//this was added to support typed function wrapping
		return r;
	}
	
	static function init():Void {
		//the global type loader function
		untyped jstm=function() {
			var a:Array<Dynamic> = cast ES5.arguments;
			//typeof is faster than constructor check
			for (x in a) switch(x.typeof()) {
				case 'function':
					//untyped console.log('jstm: '+getTypeArgs(x).join(' - '));
					//var fName = getFunctionName(x);
					//if (fName == 'run') loadAndRunWithReqTypes(x);//TODO: restore!
					//in this case, if fName!='', fName refers to the name of the .hx file in which the class was declared (for debugging)
					//else 
					registerClass(x);
				case 'object': registerEnum(x);
				case 'string': runClass(x);
			}
		};
		initStd();
		initBoot();
		//from Math.__init__
		untyped Math.__name__ = ["Math"];
		//TODO: use macro to get className
		var n = 'jstm.Runtime';
		registerType(n, untyped R=setFields(constr(),Runtime));
		//registerType(n, Runtime);
		setReadyState(n,READY);
		//untyped rs = readyStates;//DEBUG!
	}
	
	//Std.__init__
	//TODO: make compact
	//TODO: registerType instead of global (Int, Dynamic, Float, Bool, Class, Enum, Void)
	//TODO: add initMath and initDate
	static function initStd() : Void untyped {
		String.prototype.__class__ = String;
		String.__name__ = ["String"];
		Array.prototype.__class__ = Array;
		Array.__name__ = ["Array"];
		Int = { __name__ : ["Int"] };
		Dynamic = { __name__ : ["Dynamic"] };
		Float = __js__("Number");
		Float.__name__ = ["Float"];
		Bool = { __ename__ : ["Bool"] };
		//Class = { __name__ : ["Class"] };//removed extern
		//Enum = {};//removed extern
		Void = { __ename__ : ["Void"] };
	}

	//js.Boot.__init
	//TODO: make compact
	static function initBoot() {
		untyped {
			Array.prototype.copy = Array.prototype.slice;
			Array.prototype.insert = function(i,x) {
				this.splice(i,0,x);
			};
			Array.prototype.remove = if( Array.prototype.indexOf ) function(obj) {
				var idx = this.indexOf(obj);
				if( idx == -1 ) return false;
				this.splice(idx,1);
				return true;
			} else function(obj) {
				var i = 0;
				var l = this.length;
				while( i < l ) {
					if( this[i] == obj ) {
						this.splice(i,1);
						return true;
					}
					i++;
				}
				return false;
			};
			Array.prototype.iterator = function() {
				return {
					cur : 0,
					arr : this,
					hasNext : function() {
						return this.cur < this.arr.length;
					},
					next : function() {
						return this.arr[this.cur++];
					}
				}
			};
			//this is BAD! replace by hxCharCodeAt, inline in String class
			if( String.prototype.cca == null )
				String.prototype.cca = String.prototype.charCodeAt;
			String.prototype.charCodeAt = function(i) {
				var x = this.cca(i);
				if( x != x ) // fast isNaN
					return null;
				return x;
			};
			//this is BAD! replace by hxsubstr, inline in String class
			var oldsub = String.prototype.substr;
			String.prototype.substr = function(pos,len){
				if( pos != null && pos != 0 && len != null && len < 0 ) return "";
				if( len == null ) len = this.length;
				if( pos < 0 ){
					pos = this.length + pos;
					if( pos < 0 ) pos = 0;
				}else if( len < 0 ){
					len = this.length + len - pos;
				}
				return oldsub.apply(this,[pos,len]);
			};
		}
	}
	
	//used for determining whether to run a function or register a class
	//static var functionNameRE = untyped __js__("/^function\\s*([^\\(\\s]*)/");
	//static function getFunctionName(f:Dynamic) return functionNameRE.exec(f)[1]
	//static var classNameRE = untyped __js__("/^[^(]*\\(\\s*([^),]*)/");
	//static function getClassName(f:Dynamic):String return classNameRE.exec(f)[1].replace(fixNameRE,'.')
	//used for determining the types required to run a function
	//WATCH OUT! Function.prototype.toString() in WSH sometimes adds brackets and/or whitespace, ASP doesn't do this! :S
	static var typeArgsRE:RegExp = untyped __js__("/^\\(?[^(]*?\\(\\s*([^\\)]*)/");
	static var namesRE:RegExp = untyped __js__("/[\\w\\.]+/g");
	static var fixNameRE:RegExp = untyped __js__("/\\$/g");
	static function getTypeArgs(f:Dynamic):Array<String> {
		var r = typeArgsRE.exec(f);
		return r==null?[]:r[1].replace(fixNameRE,'.').match(namesRE);
	}
	
	//types that are available
	static var types:Dynamic<Dynamic> = { };
	
	//registered callbacks for each type
	static var callbacks:Array<Dynamic<Array<Dynamic->Void>>> = cast [{},{}];
	
	//indicates that an instance should be created with no side effects
	static var empty = untyped __js__("
		function(argObj,methodLine) {
			return function(posLine) {
				var method = argObj.callee;
				var c = method.ownerClass;
				return { fileName:(c.filename||(c.__name).split('.').pop()) + '.hx', lineNumber:posLine, className:c.__name, methodName:method.__name};
			}
		}
	");
	//static var empty = function(argObj:Dynamic, methodLine:Int) {
		//return function(posLine:Int) return { fileName:'[todo].hx', lineNumber:posLine, className:argObj.callee.ownerClass.__name__.join('.'), methodName:argObj.callee.__name__ }
	//};
	
	static function constr():Dynamic {
		return function(x) {
			if (x!=empty&&untyped arguments.callee.__new__) untyped arguments.callee.__new__.apply(this,arguments);
		}
	}
	
	//register a class as available for building when needed
	static function registerClass(f:Dynamic){
		var C:Dynamic=constr();
		var reqs = getTypeArgs(f);
		var cn=C.__name = reqs.shift();
		setReadyState(cn,AVAILABLE);
		registerType(cn, C);
		C.builder=f;
		C.__name__ = cn.split('.');//haXe std compatibility
		var load=0;
		var cb=function(){
			load--;
			if (load==0) setReadyState(cn,READY);
		}
		for (tn in reqs) {
			if (getReadyState(tn)<AVAILABLE) {
				load++;
				on(tn,READY,cb);
			}
		}
		if (load==0) setReadyState(cn,READY);
	}

	static function buildClass(C:Dynamic) {
		var b = C.builder;
		C.builder.delete();
		var ctx = {};
		//ctx.set('$p', function(methodName:String, lineNumber:Int):Dynamic return { fileName:'[todo].hx', lineNumber:lineNumber, className:n, methodName:methodName });
		ctx.set('$_', empty);
		var arr:Array<Dynamic> = runWithReqTypes(b, ctx);
		//setReady(n);
		if (arr != null){
			C.__interfaces__ = arr[3];
			//as static method as constructor calls this method and can not be
			//a member because super calls would initiate an endless loop
			C.__new__ = untyped mountMethod(arr[4],'__new__',C);// || (C.__super__?function() { C.__super__.__new__.apply(this, arguments); } :null);//TODO: do supercall for empty (cleaned) constructors
			var proto = mountMethods(arr[5], C);
			var S = arr[2];
			if (S) {
				C.__super__ = S;
				if (untyped S.__name__) C.prototype = untyped __new__(S, R.empty);
				//else untyped console.log(S);
				setFields(C.prototype,proto);
			}
			else if (arr[5]) C.prototype = proto;
			//TODO: toString, valueOf etc...
			C.prototype.__class__ = C.prototype.constructor = C;//haXe std compatibility, not needed when Std and Type classes get updated (can use constructor)
			setFields(C,mountMethods(arr[0],C));//static methods
			if (arr[1]!=null) setFields(C,mountMethod(arr[1],'__init__',C)());//init and static vars
		}
	}
	
	static function mountMethod(f:Dynamic,n:String, c:Dynamic) {
		if (f.typeof() == 'function') {
			f.__name = n;
			f.ownerClass = c;
		}
		return f;
	}
	
	static function mountMethods(o:Dynamic,c:Dynamic) {
		o.forEach(function(n,x) {
			mountMethod(o.get(n),n,c);
		});
		return o;
	}
	
	static function getReadyState(n:String):Int {
		return readyStates.has(n)?readyStates.get(n):NONE;
	}
	
	static function setReadyState(n:String,state:Int) {
		readyStates.set(n, state);
		var cb:Dynamic = callbacks[state-2];
		var cbArr:Array<Void->Void> = cb.get(n);
		if (cbArr != null) {
			cb.get(n).delete();
			for (cb in cbArr) cb();
		}
	}
	
	static inline var NONE = 0;
	static inline var LOADING = 1;
	static inline var AVAILABLE = 2;
	static inline var READY = 3;
	
	static var readyStates = { };
	
	//register an enum as available when needed
	static function registerEnum(o:Dynamic) {
		var n = o.first();
		o.get(n).delete();
		var e = buildEnum(o);
		e.__ename__ = n.split('$');//haXe std compatibility
		var n = e.__ename__.join('.');
		registerType(n, e);
		setReadyState(n,READY);
	}
	
	//makes sure each type can only be registered once (prevents wrong usage)
	static function registerType(n:String, o:Dynamic) {
		//untyped console.log('reg: '+n);
		if (types.has(n)) throw new Error<Dynamic>('type already registered: ' + n);
		types.set(n, o);
	}
	
	//calls the static main function for the class or creates an instance when no main is available
	public static function runClass(className:String/*,forceSync?*/) {
		useType(className, function(C) {
			if (C.main != null) C.main();
			else untyped __new__(C);
		});
	}
	
	//runs the callback function for the given readyState
	static function on(tn:String, state:Int, callbck:Void->Void):Void {
		if (getReadyState(tn) >= state) callbck();
		else {
			var cb:Dynamic = callbacks[state-2];
			var cbarr = cb.get(tn);
			if (cbarr == null) cb.set(tn,cbarr = []);
			cbarr.push(callbck);
			var h = host;
			if (h!=null && untyped __js__("h.loadType") && getReadyState(tn)<LOADING) {
				readyStates.set(tn,LOADING);
				//if (untyped __js__("h && h.loadType")) h.loadType(tn);
				//untyped console.log('readystate '+tn+': '+getReadyState(tn));
				host.loadType(tn);
			}
		}
	}
	
	//should be overridden by jstm.Host when dynamic type loading is supported
	public function loadType(typeName:String):Void throw new Error('dynamic type loading not implemented')
	
	//determines all required types and runs the function
	static function runWithReqTypes(f:Dynamic,context:Dynamic):Dynamic {
		var typeNames = getTypeArgs(f), args = [], i = 0;
		for (n in typeNames) {
			var t = getType(n);
			args.push(t);
			//#if !debug
			context.set('$' + (i++), t);
			//#end
		}
		return f.apply(context, args);
	}
	
	//returns a type that's already available
	//Type.resolveClass and Type.resolveEnum should call this (inlined)
	static function getType(tn:String):Dynamic {
		var t = types.get(tn);
		if (t!=null&&t.builder) buildClass(t);
		return t;
	}
	
	//for now, we build enums justs like std haxe but this can be optimized
	static function buildEnum(o:Dynamic):Dynamic {
		var c = [], r:Dynamic = { };
		r.__constructs__=c;
		o.forEach(function(n, x) {
			var nArgs = o.get(n),i=c.push(n) - 1;
			r.set(n,nArgs == 0
				?buildEnumOption(r, n, i)
				:buildEnumOptionFunction(r, n, i)
			);
		});
		return cast r;
	}
	
	//creates an enum option without arguments
	static function buildEnumOption(e:Dynamic,name:String,index:Int):Dynamic {
		var r=[name,index];
		//untyped r.toString= enumOptionToString;
		untyped r.__enum__=e;
		return r;
	}
	
	//static function enumOptionToString():String return untyped this[0] //TODO: base on js.Boot.__string_rec output
	
	//creates an enum option that accepts arguments
	static function buildEnumOptionFunction(e:Dynamic,name:String,index:Int):Dynamic{
		return function(){
			var r = buildEnumOption(e, name, index), a:Array<Dynamic> = cast ES5.arguments;
			for (v in a) r.push(v);
			return r;
		}
	}
	
}

#end