package com.skialbainn.pseudo.db;

import haxe.rtti.Meta;

class Model {
	
	public function put() {
		var cls = Type.getClass(this);
		var meta = Meta.getFields(cls);
		var fields = Type.getInstanceFields(cls);
		var _temp_;
		
		checkName(cls);
		
		for (f in Reflect.fields(meta)) {
			_temp_ = Reflect.field(meta, f);
			checkKeyRequired(_temp_, f);
		}
	}
	
	// INTERNAL METHODS
	
	private function checkName(_cls) {
		var _meta = Meta.getType(_cls);
		var _name = Reflect.field(_meta, 'table');
		
		if (_name != null) {
			// pseudo db code
		} else {
			trace(err(this + ' requires table name'));
		}
	}
	
	private function checkKeyRequired(_meta, _field) {
		var _msg_;
		if (has(_meta, 'key')) {
			// pseudo db code
		}
		if (has(_meta, 'required')) {
			if (Reflect.field(this, _field) == null) {
				trace(err('Field ' + _field + ' cant be null'));
			}
			// pseudo db code
		}
	}
	
	private inline function has(_meta, _field):Bool {
		return Reflect.hasField(_meta, _field);
	}
	
	private inline function err(_msg):String {
		return _msg;
	}
	
}