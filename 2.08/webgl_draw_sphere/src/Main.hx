package ;

import UserAgentContext;
import js.webgl.TypedArray;
import js.Lib;

/**
 * ...
 * @author Skial Bainn
 */

class Main {
	
	public static var gl:WebGLRenderingContext;
	
	public static var latitudeBands:Int = 30;
	public static var longitudeBands:Int = 30;
	public static var radius:Int = 2;
	
	public static var vertexPositionBuffer:Dynamic;
	public static var vertexNormalBuffer:Dynamic;
	public static var vertexTextureCoordBuffer:Dynamic;
	public static var vertexIndexBuffer:Dynamic;
	
	public static var vertexPositionData:Array<Dynamic> = [];
	public static var normalData:Array<Float> = [];
	public static var textureCoordData:Array<Dynamic> = [];
	
	public static var indexData:Array<Dynamic> = [];
	
	public static function main() {
		initGL(cast Lib.document.getElementById('hx_webgl_draw_sphere'));
		
		var latNumber:Int = 0;
		var longNumber:Int = 0;
		
		var theta:Float = 0;
		var sinTheta:Float = 0;
		var cosTheta:Float = 0;
		
		var phi:Float = 0;
		var sinPhi:Float = 0;
		var cosPhi:Float = 0;
		
		var x:Float = 0;
		var y:Float = 0;
		var z:Float = 0;
		var u:Float = 0;
		var v:Float = 0;
		
		while (latNumber <= latitudeBands) {
			theta = latNumber * Math.PI / latitudeBands;
			sinTheta = Math.sin(theta);
			cosTheta = Math.cos(theta);
			
			while (longNumber <= longitudeBands) {
				phi = longNumber * 2 * Math.PI / longitudeBands;
				sinPhi = Math.sin(phi);
				cosPhi = Math.cos(phi);
				
				x = cosPhi * sinTheta;
				y = cosTheta;
				x = sinPhi * sinTheta;
				u = 1 - (longNumber / longitudeBands);
				v = latNumber / latitudeBands;
				
				longNumber++;
			}
			
			latNumber++;
		}
		
		latNumber = 0;
		longNumber = 0;
		
		var first:Float = 0;
		var second:Float = 0;
		
		while (latNumber < latitudeBands) {
			while (longNumber < longitudeBands) {
				first = (latNumber * (longitudeBands + 1)) + longNumber;
				second = first + longitudeBands + 1;
				
				indexData.push(first);
				indexData.push(second);
				indexData.push(first + 1);
				
				indexData.push(second);
				indexData.push(second + 1);
				indexData.push(first + 1);
				
				longNumber++;
			}
			
			latNumber++;
		}
		
		vertexNormalBuffer = gl.createBuffer();
		gl.bindBuffer(gl.ARRAY_BUFFER, vertexNormalBuffer);
		gl.bufferData(gl.ARRAY_BUFFER, cast new Float32Array(cast normalData), gl.STATIC_DRAW);
		untyped vertexNormalBuffer.itemSize = 3;
		untyped vertexNormalBuffer.numItems = normalData.length / 3;
		
		vertexTextureCoordBuffer = gl.createBuffer();
		gl.bindBuffer(gl.ARRAY_BUFFER, vertexTextureCoordBuffer);
		gl.bufferData(gl.ARRAY_BUFFER, cast new Float32Array(cast textureCoordData), gl.STATIC_DRAW);
		untyped vertexTextureCoordBuffer.itemSize = 2;
		untyped vertexTextureCoordBuffer.numItems = textureCoordData.length / 2;
		
		vertexPositionBuffer = gl.createBuffer();
		gl.bindBuffer(gl.ARRAY_BUFFER, vertexPositionBuffer);
		gl.bufferData(gl.ARRAY_BUFFER, cast new Float32Array(cast vertexPositionData), gl.STATIC_DRAW);
		untyped vertexPositionBuffer.itemSize = 3;
		untyped vertexPositionBuffer.numItems = vertexPositionData.length / 3;
		
		vertexIndexBuffer = gl.createBuffer();
		gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, vertexIndexBuffer);
		gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, cast new Uint16Array(cast indexData), gl.STREAM_DRAW);
		untyped vertexIndexBuffer.itemSize = 3;
		untyped vertexIndexBuffer.numItems = indexData.length;
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
			untyped console.log('Could not initialise WebGL, sorry :-(');
		} else {
			untyped console.log('WebGL has been initialised!');
		}
	}
	
}