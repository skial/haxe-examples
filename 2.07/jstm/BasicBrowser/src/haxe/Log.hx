#if js
/*
 * uses the browser's native console.
 * 
 * advantages over std solution:
 * - doesn't interfere with the document as no haxe:trace element is required
 * - most browsers show a nice object tree for each log which is way more useful then a string representation
 *   (a JSON.stringify() fallback is used for browsers that don't show an object tree)
 * - trace is inline so that clicking the log in the console shows the line in the source file where the trace occurred
 *   (can not be also dynamic but is it really necessary to overwrite this behavior? if you have to, you can overwrite console.log)
 */
package haxe;
import jstm.Host;

class Log {
	
	public static inline function trace( value : Dynamic, ?info : haxe.PosInfos ) : Void {
		//WebKit browsers have console.dir and use this to show a neat object tree.
		//for other browsers, we output JSON
		Host.window.console.log(value,untyped Host.window.console.dir?info:'\n'+JSON.stringify(info));
	}
	
	//not all browsers have this, loader takes care of this
	public static inline function clear() : Void Host.window.console.clear()

}
#else

/*
 * Copyright (c) 2005, The haXe Project Contributors
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE HAXE PROJECT CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE HAXE PROJECT CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */
package haxe;

class Log {

	public static dynamic function trace( v : Dynamic, ?infos : PosInfos ) : Void {
		#if flash
		untyped flash.Boot.__trace(v,infos);
		#elseif neko
		untyped __dollar__print(infos.fileName+":"+infos.lineNumber+": ",v,"\n");
		#elseif js
		untyped js.Boot.__trace(v,infos);
		#elseif php
		untyped __call__('_hx_trace', v,infos);
		#elseif cpp
		untyped __trace(v,infos);
		#end
	}

	public static dynamic function clear() : Void {
		#if flash
		untyped flash.Boot.__clear_trace();
		#elseif js
		untyped js.Boot.__clear_trace();
		#end
	}

	#if flash
	public static dynamic function setColor( rgb : Int ) {
		untyped flash.Boot.__set_trace_color(rgb);
	}
	#end

}
#end