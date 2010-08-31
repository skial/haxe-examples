package com.skialbainn.pseudo.db;

import haxe.rtti.Meta;

class Model {
	
	public function put() {
		/*
		 * We get the objects class by passing 'this' instead of
		 * passing class Model as Model is ment to be extended.
		 */
		var cls = Type.getClass(this);
		/*
		 * We get all fields that have metadata, which we will 
		 * check loop through to check the values are correct.
		 */
		var meta = Meta.getFields(cls);
		var _temp_;
		/*
		 * Here we call the method checkName() passing in the class.
		 */
		checkName(cls);
		/*
		 * Here we get all fields as strings which have metadata, by
		 * using the Reflect method fields, then loop through them.
		 */
		for (f in Reflect.fields(meta)) {
			/*
			 * We get the value of the field name, which we then pass
			 * to checkKeyRequired for further processing.
			 */
			_temp_ = Reflect.field(meta, f);
			checkKeyRequired(_temp_, f);
		}
	}
	
	// INTERNAL METHODS
	
	/*
	 * This method takes the object class then which uses that
	 * to get its metadata.
	 */
	private function checkName(_cls) {
		/*
		 * Here we are getting the metadata attached to the class.
		 */
		var _meta = Meta.getType(_cls);
		/*
		 * We then check to see if @table has a value or not. If
		 * its true, then we continue with the pseudo db code, if
		 * false, we raise an error describing the issue.
		 */
		if (_meta.table != null) {
			// pseudo db code
		} else {
			trace(err(this + ' requires table name'));
		}
	}
	
	/*
	 * Here we check for any @key and @required tags.
	 */
	private function checkKeyRequired(_meta, _field) {
		/*
		 * If @key is found, we continue with the pseudo db code.
		 */
		if (has(_meta, 'key')) {
			// pseudo db code
		}
		/*
		 * If @required is found, we check to see if the value is
		 * 'null'. If it is then we raise an error, describing
		 * which field needs editing. If not we continue with the
		 * pseudo db code.
		 */
		if (has(_meta, 'required')) {
			if (Reflect.field(this, _field) == null) {
				trace(err('Field ' + _field + ' cant be null'));
			}
			// pseudo db code
		}
	}
	
	/* 
	 * This checks the variable if it has a metadata tag.
	 */
	private inline function has(_meta, _field):Bool {
		return Reflect.hasField(_meta, _field);
	}
	
	/*
	 * This returns the error message passed to it. For better 
	 * use, replace 'return _msg' with 'throw _msg'.
	 */
	private inline function err(_msg):String {
		return _msg;
	}
	
}