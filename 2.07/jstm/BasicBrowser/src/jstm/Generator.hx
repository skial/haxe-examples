/**
 * ...
 * @author Cref
 */
package jstm;

#if macro

import haxe.FileSystem;
import haxe.io.Path;
import haxe.io.File;
import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.JSGenApi;

using StringTools;
using hxtc.use.ForFileSystem;

class Generator {
	
	var options:Dynamic;
	
	//compile with: --macro jstm.Generator.run(true,true)
	public static function run(writeSplit:Bool, writeJoined:Bool, ?options:Dynamic) {
		//writeSplit:Bool, writeJoined:Bool, ?limitSplitOutput:Array<String>, ?useFolders:Bool, ?useStack:Bool, ?template: { input:String, output:String } 
		//Compiler.patchTypes('patch.diff');
		//Context.onGenerate(function(typeArray:Array<Type>) {
		//	for (t in typeArray) trace(t);
		//});
		if (options == null) options = { };
		Compiler.setCustomJSGenerator(function(js) {
			var
				c:Generator = new HostGenerator(js, options), 
				name = Path.withoutExtension(js.outputFile), 
				ext = Path.extension(js.outputFile)
			;
			/*#if debug
			ext = 'debug.' + ext;
			#end*/
			if (writeSplit) c.writeSplit(name,ext);
			if (writeJoined) c.writeJoined(name+'.'+ext);
			#if browser
			//trace('script include info weergeven');
			#elseif asp
			if (ext == 'js') Context.warning(
				'When using the .js extension for serverside applications, make sure the files can not be downloaded.\n'+
				'To be on the safe, use a different extension (.sjs for example) and make sure direct requests for this extension are not allowed.',
				Context.currentPos()
			);
			#end
		});
	}
	
	var mainClassName:String;
	public var js:JSGenApi;
	var hostReqTypes:Hash<String>;
	//for redirecting closure() and pos()
	public var runtimeClass:ClassType;
	//redirect Std access to this class
	public var replacementStdClass:ClassType;
	
	var classes:Hash<GeneratedClass>;
	var enums:Hash<GeneratedEnum>;

	public function new(js:JSGenApi, options:Dynamic) {
		classes = new Hash();
		enums = new Hash();
		mainClassName=js.generateExpr(js.main).replace('.main()', '');
		this.js = js;
		this.options = options;
		runtimeClass = getClassType(runtimeClassName.replace('$','.'));
		replacementStdClass = getClassType('Std__');
		
		for (type in js.types) {
			switch(type) {
				case TInst(t, _):
					var ct = t.get();
					if (ct.isExtern && ct.init == null) continue;
					var c = new GeneratedClass(ct,this);
					classes.set(c.argName,c);
				case TEnum(t, _):
					var et = t.get();
					if (et.isExtern) continue;
					var e = new GeneratedEnum(t.get());
					enums.set(e.argName,e);
				default:
			}
		}
		hostSrc=createHostSrc();
	}
	
	public static var runtimeClassName = 'jstm$Runtime';
	static var hostClassName = 'jstm$Host';
	var hostSrc:String;
	
	function createHostSrc():String {
		hostReqTypes = new Hash();
		getInitTypes(hostClassName);
		var runtime = hostReqTypes.get(runtimeClassName);
		hostReqTypes.remove(runtimeClassName);
		var hostSrcBuf = new StringBuf();
		hostSrcBuf.add(runtime);
		hostSrcBuf.add(';jstm(');
		for (src in hostReqTypes) {
			hostSrcBuf.add(src);
			hostSrcBuf.add(',' + nwln);
		}
		hostSrcBuf.add('"'+hostClassName.replace('$','.')+'")');
		return hostSrcBuf.toString();
	}
	
	function getInitTypes(n:String) {
		if (hostReqTypes.exists(n)) return;
		if (enums.exists(n)) {
			hostReqTypes.set(n, enums.get(n).string);
			enums.remove(n);
		}
		else {
			var c = classes.get(n);
			hostReqTypes.set(n, c.string);
			classes.remove(n);
			for (n in c.reqTypeArgs) getInitTypes(n);
		}
	}
	
	function getClassType(className:String):ClassType {
		return switch(Context.getType(className)) {
			case TInst(t, _): t.get();
			default: throw 'not a class';
		}
	}
	
	/**
	 * override this function to patch extern class access
	 * @param	c
	 * @return
	 */
	public function getNativeName(t:BaseType):String return t.pack.concat([t.name]).join('.')
	//public function forceExternClassInit(c:ClassType):Bool return false
	
	function writeFile(name:String, content:String) {
		Path.directory(name).buildPath();
		var file = File.write(name, false);
		writeUTF8BOM(file);
		file.writeString(content);
		file.close();
	}
	
	/**
	 * 
	 * @param	folderPath
	 * @param	ext
	 * @return an array of the filenames that were written
	 */
	public function writeSplit(folderPath:String,ext:String):Array<String> {
		writeFile(folderPath + '/' + hostClassName.replace('$','/') + '.' + ext, hostSrc);
		var filenames = [hostClassName.replace('$','/')+'.'+ext];
		var t = this;
		var write = function(types:Hash<GeneratedType>) {
			for (type in types) {
				var filename = type.argName.replace('$','/') + '.' + ext;
				t.writeFile(folderPath + '/' + filename,'jstm('+type.string+')');
				filenames.push(filename);
			}
		}
		write(cast enums);
		write(cast classes);
		return filenames;
	}
	
	static inline var nwln = #if debug '\n' #else '' #end;
	
	public function writeJoined(filePath:String) {
		var buf = new StringBuf();
		buf.add(hostSrc);
		buf.add(';jstm('+nwln);
		for (c in classes) {
			buf.add(c.string);
			buf.add(','+nwln);
		}
		for (e in enums) {
			buf.add(e.string);
			buf.add(','+nwln);
		}
		buf.add('"' + mainClassName + '")');
		var src = buf.toString();
		writeFile(filePath,src);
	}
	
	static function writeUTF8BOM(f:neko.io.FileOutput) {
		f.writeByte(239);
		f.writeByte(187);
		f.writeByte(191);
	}
	
}


class GeneratedType {
	public var string(default, null):String;
	public var argName(default, null):String;
	function new(t:BaseType) {
		argName = getPath(t);
	}
	function getPath( t : BaseType,sep='$' ):String return (t.pack.length==0 ? t.name : t.pack.join(sep) + sep + t.name)+(t.isExtern?'__init__':'')//NOT FOR ENUMS!
}

class GeneratedClass extends GeneratedType {
	var generator:Generator;
	var classType(default,null):ClassType;
	var reqTypes(default, null):Hash<Int>;
	public var reqTypeArgs(default, null):Array<String>;
	public function new(c:ClassType,g:Generator) {
		super(c);
		classType = c;
		generator = g;
		reqTypeArgs = [];
		reqTypes = new Hash();
		if (argName == Generator.runtimeClassName) {
			g.js.setTypeAccessor(runtimeTypeAccessor);
			var statics = c.statics.get();
			var c = c.constructor.get();
			c.name = '__new__';
			statics.push(c);
			string='(function(){var R='+Cleaner.cleanUp(generateFields(statics))+',$_=R.empty;R.init()}())';
			return;
		}
		g.js.setTypeAccessor(c==generator.runtimeClass?runtimeTypeAccessor:typeAccessor);
		//register self:
		getReqName(c);
		if (c.isExtern) {
			generator.js.setDebugInfos(c, '__init__', true);
			string = 'with(this){\n'+Cleaner.cleanInit(generator.js.generateExpr(c.init))+'\n}';
		}
		else {
			var args = [], body = [];
			//TODO: generate interfaces: function(MyIntf,MyImpl1,MyImpl2){return 'field1 field2'}
			//register superclass
			if (c.superClass != null) {
				var sc = c.superClass.t.get();
				body.push(sc.isExtern&&sc.init==null?generator.getNativeName(sc):getReqName(sc));
			}
			else body.push('');
			//register interfaces
			if (c.interfaces.length>0) {
				var impl = [];
				c.interfaces.reverse();
				for (i in c.interfaces) {
					var intf = i.t.get();
					impl.push(intf.isExtern?generator.getNativeName(intf):getReqName(intf));
				}
				body.push('['+impl.join(',')+']');
			}
			else body.push('');
			//generate constructor
			var constr = '';
			if (c.constructor != null) {
				var cns = c.constructor.get();
				if (cns.expr != null) constr=generateClassField(cns);
			}
			body.push(constr);
			//generate fields (prototype)
			body.push(generateFields(c.fields.get()));
			//generate init and statics
			//#if debug
			generator.js.setDebugInfos(c, '__init__', true);
			//#end
			var init = c.init == null?'':Cleaner.cleanInit(generator.js.generateExpr(c.init));
			var staticMethods:Array<ClassField>=[];
			var staticVars:Array<ClassField>=[];
			for (s in c.statics.get()) {
				switch(s.kind) {
					case FMethod(a):staticMethods.push(s);
					case FVar(a,b):staticVars.push(s);
				}
			}
			var sVars = generateFields(staticVars);
			if (sVars != '') init += ';\nreturn ' + sVars;
			body.unshift(init == ''?'':'function(){var $p=$_(arguments);\n' + init + '\n}');
			//static methods
			body.unshift(generateFields(staticMethods));
			body = hxtc.use.ForArray.rtrim(body, '');
			var src = body.join(',\n');
			if (closureCalls.match(src)) {
				//replace global $closure function calls
				var n = getReqName(generator.runtimeClass);
				src = closureCalls.replace(src, n+'.closure(');
			}
			if (posInfosRE.match(src)) {
				//replace PosInfos object literals by more compact calls
				//var n = getReqName(generator.runtimeClass);
				//src = posInfosRE.replace(src, n+'.pos("$3","$4","$1",$2)');
				src = posInfosRE.replace(src, '$p($2)');
			}
			string = 'with(this) return [\n' + src + '\n]';
		}
		string = 'function(' + reqTypeArgs.join(',') + '){' + string + '}';
		string = Cleaner.cleanUp(string);
	}
	
	/**
	 * called whenever an expression references a type
	 * @param	t
	 * @return
	 */
	function typeAccessor(t:Type):String {
		switch(t) {
			case TInst(t, _): {
				var c = t.get();
				return c.isExtern
					?c.init != null//||generator.forceExternClassInit(c)
						?getReqName(c)
						:generator.getNativeName(c)
					:getReqName(c.name=='Std'?generator.replacementStdClass:c);
			}
			case TEnum(t, _):
				var e = t.get();
				return e.isExtern?generator.getNativeName(e):getReqName(e);
			default: throw "assert";
		}
	}
	
	function runtimeTypeAccessor(t:Type):String {
		switch(t) {
			case TInst(t, _): {
				var c = t.get();
				if (c.name=='Runtime') return 'R';
				if (c.name=='Host') return 'H';
				if (c.isExtern&&c.init==null) return generator.getNativeName(c);
			}
			case TEnum(t, _):
				var e = t.get();
				if (e.isExtern) return generator.getNativeName(e);
			default:
		}
		throw "jstm.Runtime can not be dependent of other types: "+t;
	}
	
	function getReqName(t:BaseType):String {
		var n = getPath(t);
		if (!reqTypes.exists(n)) reqTypes.set(n, reqTypeArgs.push(n) - 1);
		return t.isExtern?generator.getNativeName(t):#if debug n #else '$' + reqTypes.get(n) #end;
	}
	
	static var closureCalls=~/\$closure\(/g;
	static var posInfosRE = ~/{ fileName : "([^\.]*)\.hx", lineNumber : ([^,]*), className : "([^"]*)", methodName : "([^"]*)"}/g;
	
	
	function generateFields(fields:Array<ClassField>):String {
		var r = [];
		//for (f in fields) r.push(pair(f.name, f.expr == null?'null':generateClassField(f)));
		for (f in fields) if (f.expr != null) r.push(pair(f.name, generateClassField(f)));
		return r.length == 0?'':'{\n' + r.join(',\n') + '}';
	}
	
	function pair(n:String, expr:String):String return (generator.js.isKeyword(n)?generator.js.quoteString(n):n) + ':' + expr
	
	function generateClassField(f:ClassField):String {
		//#if debug
		generator.js.setDebugInfos(classType, f.name, true);
		//#end
		var r = generator.js.generateExpr(f.expr);
		//#if debug
		switch(f.kind) {
			case FMethod(k):
						r = jstm.Cleaner.callStack.replace(r, 'function '+f.name+'$$$2($1){var $p=$_(arguments);\n');
						//r = fnStart.replace(r, '{');
						//r = jstm.Cleaner.callStack.replace(r, 'function _$2($1){\n');
			default:
		};
		//#end
		return r;
	}
	static var fnStart = ~/{/;
}

class GeneratedEnum extends GeneratedType {
	public var enumType(default,null):EnumType;
	public function new(e:EnumType) {
		super(e);
		enumType = e;
		var constructs=[argName+':{}'];//TODO: metadata
		for (n in e.names) {
			var c = e.constructs.get(n);
			var t = c.type,n=switch(t) {
				case TFun(args, ret): args.length;
				default: 0;
			}
			constructs.push(c.name+':'+n);
		}
		string='{' + constructs.join(',') + '}';
	}
}
#end