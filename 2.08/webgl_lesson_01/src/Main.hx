package ;

import js.Lib;
import UserAgent;
import UserAgentContext;
/**
 * ...
 * @author Skial Bainn
 */
 
class Main {
	
	public static var fragment:String = ['precision mediump float;\n',
										'void main(void) {',
										'\tgl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);',
										'}'].join('\n');
	
	public static var vertex:String = ['attribute vec3 aVertexPosition;\n',
										'uniform mat4 uMVMatrix;',
										'uniform mat4 uPMatrix;\n',
										'void main(void) {',
										'\tgl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);',
										'}'].join('\n');
	
	public static function main() {
		webGLStart();
	}
	
	public static var gl:WebGLRenderingContext;
	
	public static function initGL(canvas:HTMLCanvasElement):Void {
		try {
			gl = untyped WebGLDebugUtils.makeDebugContext(canvas.getContext('experimental-webgl'));
			gl.viewport(0, 0, canvas.width, canvas.height);
		} catch (e:Dynamic) { }
		if (gl == null) {
			Lib.alert('Could not initialise WebGL, sorry :-(');
		}
	}
	
	//public static function getShader(str:String, type:GLenum) {
	public static function getShader(id:String) {
		/*var shader:WebGLShader = gl.createShader(type);
		gl.shaderSource(shader, str);
		gl.compileShader(shader);
		
		if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
			Lib.alert(gl.getShaderInfoLog(shader));
			return null;
		}
		
		return shader;*/
		var shaderScript:Node = UserAgent.document.getElementById(id);
        if (shaderScript == null) {
            return null;
        }

        var str = "";
        var k = shaderScript.firstChild;
        while (untyped k) {
            if (k.nodeType == 3) {
                str += k.textContent;
            }
            k = k.nextSibling;
        }

        var shader;
        if (shaderScript.type == "x-shader/x-fragment") {
            shader = gl.createShader(gl.FRAGMENT_SHADER);
        } else if (shaderScript.type == "x-shader/x-vertex") {
            shader = gl.createShader(gl.VERTEX_SHADER);
        } else {
            return null;
        }

        gl.shaderSource(shader, str);
        gl.compileShader(shader);

        if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
            Lib.alert(gl.getShaderInfoLog(shader));
            return null;
        }

        return shader;
	}
	
	public static var shaderProgram:WebGLProgram;
	
	public static function initShaders():Void {
		//var fragmentShader:WebGLShader = getShader(fragment, gl.FRAGMENT_SHADER);
		var fragmentShader:WebGLShader = getShader('shader-fs');
		//var vertexShader:WebGLShader = getShader(vertex, gl.VERTEX_SHADER);
		var vertexShader:WebGLShader = getShader('shader-vs');
		
		shaderProgram = gl.createProgram();
		gl.attachShader(shaderProgram, vertexShader);
		gl.attachShader(shaderProgram, fragmentShader);
		gl.linkProgram(shaderProgram);
		
		if (!gl.getProgramParameter(shaderProgram, gl.LINK_STATUS)) {
			Lib.alert('Could not initialise shaders');
		}
		
		gl.useProgram(shaderProgram);
		
		untyped shaderProgram.vertexPositionAttribute = gl.getAttribLocation(shaderProgram, 'aVertexPosition');
		untyped gl.enableVertexAttribArray(shaderProgram.vertexPositionAttribute);
		
		untyped shaderProgram.pMatrixUniform = gl.getUniformLocation(shaderProgram, 'uPMatrix');
		untyped shaderProgram.mvMatrixUniform = gl.getUniformLocation(shaderProgram, 'uMVMatrix');
	}
	
	public static var mvMatrix = untyped mat4.create();
	public static var pMatrix = untyped mat4.create();
	
	public static function setMatrixUniforms():Void {
		untyped gl.uniformMatrix4fv(shaderProgram.pMatrixUniform, false, pMatrix);
		untyped gl.uniformMatrix4fv(shaderProgram.mvMatrixUniform, false, mvMatrix);
	}
	
	public static var triangleVertexPositionBuffer:Dynamic;
	public static var squareVertexPositionBuffer:Dynamic;
	
	public static function initBuffers():Void {
		triangleVertexPositionBuffer = gl.createBuffer();
		gl.bindBuffer(gl.ARRAY_BUFFER, triangleVertexPositionBuffer);
		var vertices:Array<Float> = [0.0, 1.0, 0.0,
									-1.0, -1.0, 0.0,
									1.0, -1.0, 0.0];
		gl.bufferData(gl.ARRAY_BUFFER, cast new Float32Array(cast vertices), gl.STATIC_DRAW);
		triangleVertexPositionBuffer.itemSize = 3;
		triangleVertexPositionBuffer.numItems = 3;
		
		squareVertexPositionBuffer = gl.createBuffer();
		gl.bindBuffer(gl.ARRAY_BUFFER, squareVertexPositionBuffer);
		vertices = [1.0, 1.0, 0.0,
					-1.0, -1.0, 0.0,
					1.0, -1.0, 0.0,
					-1.0, -1.0, 0.0];
		gl.bufferData(gl.ARRAY_BUFFER, cast new Float32Array(cast vertices), gl.STATIC_DRAW);
		squareVertexPositionBuffer.itemSize = 3;
		squareVertexPositionBuffer.numItems = 4;
	}
	
	public static function drawScene():Void {
		gl.viewport(0, 0, untyped gl.viewportWidth, untyped gl.viewportHeight);
		gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
		
		untyped mat4.perspective(45, gl.viewportWidth / gl.viewportHeight, 0.1, 100.0, pMatrix);
		
		untyped mat4.identity(mvMatrix);
		
		untyped mat4.translate(mvMatrix, [ -1.5, 0.0, -7.0]);
		gl.bindBuffer(gl.ARRAY_BUFFER, triangleVertexPositionBuffer);
		gl.vertexAttribPointer(untyped shaderProgram.vertexPositionAttribute, triangleVertexPositionBuffer.itemSize, gl.FLOAT, false, 0, 0);
		setMatrixUniforms();
		gl.drawArrays(gl.TRIANGLES, 0, triangleVertexPositionBuffer.numItems);
		
		untyped mat4.translate(mvMatrix, [3.0, 0.0, 0.0]);
		gl.bindBuffer(gl.ARRAY_BUFFER, squareVertexPositionBuffer);
		gl.vertexAttribPointer(untyped shaderProgram.vertexPositionAttribute, squareVertexPositionBuffer.itemSize, gl.FLOAT, false, 0, 0);
		setMatrixUniforms();
		gl.drawArrays(gl.TRIANGLE_STRIP, 0, squareVertexPositionBuffer.numItems);
	}
	
	public static function webGLStart():Void {
		initGL(UserAgent.document.getElementById('hx_webgl_lesson_one'));
		initShaders();
		initBuffers();
		
		gl.clearColor(0.0, 0.0, 0.0, 1.0);
		gl.enable(gl.DEPTH_TEST);
		
		drawScene();
	}
	
}