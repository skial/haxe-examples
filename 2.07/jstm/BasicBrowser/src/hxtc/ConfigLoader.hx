package hxtc;

/**
* ...
* @author Cref
*/

class ConfigLoader extends DynamicHash<String> {

	public function new(config:String,preset:Dynamic<String>):Void {
		super();
		#if debug
		//loading debug settings made easy
		set("debug", "-debug");
		#end
		if (preset != null) for (key in Reflect.fields(preset)) set(key, Reflect.field(preset, key));
		load(config);
	}
	
	public function load(config:String):Void {
		for (pair in config.split("\n")) {
			pair = resolveRefs(pair);
			var sep = pair.indexOf("=");
			if (sep > 0) {
				var key = pair.substr(0, sep), value = pair.substr(sep + 1);
				sep = key.indexOf('?');
				if (sep > -1) {
					if (get(key.substr(0, sep))==null) continue;
					key = key.substr(sep + 1);
				}
				value==''?remove(key):set(key,value);
			}
		}
	}
	
	function resolveRefs(v:String):String {
		while(valueRef.match(v)) v = valueRef.customReplace(v,replaceRef);
		return v;
	}
	
	function replaceRef(er:EReg):String return get(er.matched(1))
	
	static var valueRef = ~/{=([^{]*?)}/;
}


class HierarchicalConfigLoader extends ConfigLoader {
	
	public function new(startAt:String,path:Array<String>,name:String,preset:Dynamic<String>):Void {
		if(startAt == null) startAt = haxe.Sys.getCwd();
		var p = [startAt];
		p.concat(path);
		super(getPathCfg(p,name),preset);
	}
	
	function getPathCfg(path:Array<String>,name:String):String {
		var cfg = [], p = "";
		for (part in path) {
			p += part + "/";
			cfg.push("currentFolder=" + p);
			var f = p + "bin/" + name + ".cfg";
			if (haxe.FileSystem.exists(f)) cfg.push(StringTools.replace(haxe.io.File.getContent(f), "\r", ""));
		}
		return cfg.join("\n");
	}
	
}