package ;

import UserAgentContext;
import js.Lib;

/**
 * ...
 * @author Skial Bainn
 */

class Main {
	
	// http://learningwebgl.com/cookbook/index.php/How_to_initialise_WebGL
	
	public static var gl:WebGLRenderingContext;
	
	public static function main() {
		initGL(cast Lib.document.getElementById('hx_webgl_initialise'));
	}
	
	public static function initGL(canvas:HTMLCanvasElement):Void {
		untyped console.log(canvas.width);
		untyped console.log(canvas.height);
		try {
			gl = canvas.getContext('experimental-webgl');
			gl.viewport(0, 0, canvas.width, canvas.height);
		} catch (e:Dynamic) {
			
		}
		if (gl == null) {
			Lib.alert('Could not initialise WebGL, sorry :-(');
		} else {
			Lib.alert('WebGL has been initialised!');
		}
	}
	
}