$estr = function() { return js.Boot.__string_rec(this,''); }
IntIter = function(min,max) {
	if( min === $_ ) return;
	this.min = min;
	this.max = max;
}
IntIter.__name__ = ["IntIter"];
IntIter.prototype.min = null;
IntIter.prototype.max = null;
IntIter.prototype.hasNext = function() {
	return this.min < this.max;
}
IntIter.prototype.next = function() {
	return this.min++;
}
IntIter.prototype.__class__ = IntIter;
Std = function() { }
Std.__name__ = ["Std"];
Std["is"] = function(v,t) {
	return js.Boot.__instanceof(v,t);
}
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
}
Std["int"] = function(x) {
	if(x < 0) return Math.ceil(x);
	return Math.floor(x);
}
Std.parseInt = function(x) {
	var v = parseInt(x,10);
	if(v == 0 && x.charCodeAt(1) == 120) v = parseInt(x);
	if(isNaN(v)) return null;
	return v;
}
Std.parseFloat = function(x) {
	return parseFloat(x);
}
Std.random = function(x) {
	return Math.floor(Math.random() * x);
}
Std.prototype.__class__ = Std;
UserAgent = function() { }
UserAgent.__name__ = ["UserAgent"];
UserAgent.getContext = function() {
	return window;
}
UserAgent.prototype.__class__ = UserAgent;
if(typeof js=='undefined') js = {}
js.Lib = function() { }
js.Lib.__name__ = ["js","Lib"];
js.Lib.isIE = null;
js.Lib.isOpera = null;
js.Lib.document = null;
js.Lib.window = null;
js.Lib.alert = function(v) {
	alert(js.Boot.__string_rec(v,""));
}
js.Lib.eval = function(code) {
	return eval(code);
}
js.Lib.setErrorHandler = function(f) {
	js.Lib.onerror = f;
}
js.Lib.prototype.__class__ = js.Lib;
js.Boot = function() { }
js.Boot.__name__ = ["js","Boot"];
js.Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
}
js.Boot.__trace = function(v,i) {
	var msg = i != null?i.fileName + ":" + i.lineNumber + ": ":"";
	msg += js.Boot.__unhtml(js.Boot.__string_rec(v,"")) + "<br/>";
	var d = document.getElementById("haxe:trace");
	if(d == null) alert("No haxe:trace element defined\n" + msg); else d.innerHTML += msg;
}
js.Boot.__clear_trace = function() {
	var d = document.getElementById("haxe:trace");
	if(d != null) d.innerHTML = "";
}
js.Boot.__closure = function(o,f) {
	var m = o[f];
	if(m == null) return null;
	var f1 = function() {
		return m.apply(o,arguments);
	};
	f1.scope = o;
	f1.method = m;
	return f1;
}
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ != null || o.__ename__ != null)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__ != null) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2, _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i;
			var str = "[";
			s += "\t";
			var _g = 0;
			while(_g < l) {
				var i1 = _g++;
				str += (i1 > 0?",":"") + js.Boot.__string_rec(o[i1],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) { ;
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
}
js.Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0, _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js.Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js.Boot.__interfLoop(cc.__super__,cl);
}
js.Boot.__instanceof = function(o,cl) {
	try {
		if(o instanceof cl) {
			if(cl == Array) return o.__enum__ == null;
			return true;
		}
		if(js.Boot.__interfLoop(o.__class__,cl)) return true;
	} catch( e ) {
		if(cl == null) return false;
	}
	switch(cl) {
	case Int:
		return Math.ceil(o%2147483648.0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return o === true || o === false;
	case String:
		return typeof(o) == "string";
	case Dynamic:
		return true;
	default:
		if(o == null) return false;
		return o.__enum__ == cl || cl == Class && o.__name__ != null || cl == Enum && o.__ename__ != null;
	}
}
js.Boot.__init = function() {
	js.Lib.isIE = typeof document!='undefined' && document.all != null && typeof window!='undefined' && window.opera == null;
	js.Lib.isOpera = typeof window!='undefined' && window.opera != null;
	Array.prototype.copy = Array.prototype.slice;
	Array.prototype.insert = function(i,x) {
		this.splice(i,0,x);
	};
	Array.prototype.remove = Array.prototype.indexOf?function(obj) {
		var idx = this.indexOf(obj);
		if(idx == -1) return false;
		this.splice(idx,1);
		return true;
	}:function(obj) {
		var i = 0;
		var l = this.length;
		while(i < l) {
			if(this[i] == obj) {
				this.splice(i,1);
				return true;
			}
			i++;
		}
		return false;
	};
	Array.prototype.iterator = function() {
		return { cur : 0, arr : this, hasNext : function() {
			return this.cur < this.arr.length;
		}, next : function() {
			return this.arr[this.cur++];
		}};
	};
	if(String.prototype.cca == null) String.prototype.cca = String.prototype.charCodeAt;
	String.prototype.charCodeAt = function(i) {
		var x = this.cca(i);
		if(x != x) return null;
		return x;
	};
	var oldsub = String.prototype.substr;
	String.prototype.substr = function(pos,len) {
		if(pos != null && pos != 0 && len != null && len < 0) return "";
		if(len == null) len = this.length;
		if(pos < 0) {
			pos = this.length + pos;
			if(pos < 0) pos = 0;
		} else if(len < 0) len = this.length + len - pos;
		return oldsub.apply(this,[pos,len]);
	};
	$closure = js.Boot.__closure;
}
js.Boot.prototype.__class__ = js.Boot;
Main = function() { }
Main.__name__ = ["Main"];
Main.main = function() {
	Main.webGLStart();
}
Main.gl = null;
Main.initGL = function(canvas) {
	try {
		Main.gl = WebGLDebugUtils.makeDebugContext(canvas.getContext("experimental-webgl"));
		Main.gl.viewport(0,0,canvas.width,canvas.height);
	} catch( e ) {
	}
	if(Main.gl == null) js.Lib.alert("Could not initialise WebGL, sorry :-(");
}
Main.getShader = function(id) {
	var shaderScript = UserAgent.document.getElementById(id);
	if(shaderScript == null) return null;
	var str = "";
	var k = shaderScript.firstChild;
	while(k) {
		if(k.nodeType == 3) str += k.textContent;
		k = k.nextSibling;
	}
	var shader;
	if(shaderScript.type == "x-shader/x-fragment") shader = Main.gl.createShader(Main.gl.FRAGMENT_SHADER); else if(shaderScript.type == "x-shader/x-vertex") shader = Main.gl.createShader(Main.gl.VERTEX_SHADER); else return null;
	Main.gl.shaderSource(shader,str);
	Main.gl.compileShader(shader);
	if(!Main.gl.getShaderParameter(shader,Main.gl.COMPILE_STATUS)) {
		js.Lib.alert(Main.gl.getShaderInfoLog(shader));
		return null;
	}
	return shader;
}
Main.shaderProgram = null;
Main.initShaders = function() {
	var fragmentShader = Main.getShader("shader-fs");
	var vertexShader = Main.getShader("shader-vs");
	Main.shaderProgram = Main.gl.createProgram();
	Main.gl.attachShader(Main.shaderProgram,vertexShader);
	Main.gl.attachShader(Main.shaderProgram,fragmentShader);
	Main.gl.linkProgram(Main.shaderProgram);
	if(!Main.gl.getProgramParameter(Main.shaderProgram,Main.gl.LINK_STATUS)) js.Lib.alert("Could not initialise shaders");
	Main.gl.useProgram(Main.shaderProgram);
	Main.shaderProgram.vertexPositionAttribute = Main.gl.getAttribLocation(Main.shaderProgram,"aVertexPosition");
	Main.gl.enableVertexAttribArray(Main.shaderProgram.vertexPositionAttribute);
	Main.shaderProgram.pMatrixUniform = Main.gl.getUniformLocation(Main.shaderProgram,"uPMatrix");
	Main.shaderProgram.mvMatrixUniform = Main.gl.getUniformLocation(Main.shaderProgram,"uMVMatrix");
}
Main.setMatrixUniforms = function() {
	Main.gl.uniformMatrix4fv(Main.shaderProgram.pMatrixUniform,false,Main.pMatrix);
	Main.gl.uniformMatrix4fv(Main.shaderProgram.mvMatrixUniform,false,Main.mvMatrix);
}
Main.triangleVertexPositionBuffer = null;
Main.squareVertexPositionBuffer = null;
Main.initBuffers = function() {
	Main.triangleVertexPositionBuffer = Main.gl.createBuffer();
	Main.gl.bindBuffer(Main.gl.ARRAY_BUFFER,Main.triangleVertexPositionBuffer);
	var vertices = [0.0,1.0,0.0,-1.0,-1.0,0.0,1.0,-1.0,0.0];
	Main.gl.bufferData(Main.gl.ARRAY_BUFFER,new Float32Array(vertices),Main.gl.STATIC_DRAW);
	Main.triangleVertexPositionBuffer.itemSize = 3;
	Main.triangleVertexPositionBuffer.numItems = 3;
	Main.squareVertexPositionBuffer = Main.gl.createBuffer();
	Main.gl.bindBuffer(Main.gl.ARRAY_BUFFER,Main.squareVertexPositionBuffer);
	vertices = [1.0,1.0,0.0,-1.0,-1.0,0.0,1.0,-1.0,0.0,-1.0,-1.0,0.0];
	Main.gl.bufferData(Main.gl.ARRAY_BUFFER,new Float32Array(vertices),Main.gl.STATIC_DRAW);
	Main.squareVertexPositionBuffer.itemSize = 3;
	Main.squareVertexPositionBuffer.numItems = 4;
}
Main.drawScene = function() {
	Main.gl.viewport(0,0,Main.gl.viewportWidth,Main.gl.viewportHeight);
	Main.gl.clear(Main.gl.COLOR_BUFFER_BIT | Main.gl.DEPTH_BUFFER_BIT);
	mat4.perspective(45,Main.gl.viewportWidth / Main.gl.viewportHeight,0.1,100.0,Main.pMatrix);
	mat4.identity(Main.mvMatrix);
	mat4.translate(Main.mvMatrix,[-1.5,0.0,-7.0]);
	Main.gl.bindBuffer(Main.gl.ARRAY_BUFFER,Main.triangleVertexPositionBuffer);
	Main.gl.vertexAttribPointer(Main.shaderProgram.vertexPositionAttribute,Main.triangleVertexPositionBuffer.itemSize,Main.gl.FLOAT,false,0,0);
	Main.setMatrixUniforms();
	Main.gl.drawArrays(Main.gl.TRIANGLES,0,Main.triangleVertexPositionBuffer.numItems);
	mat4.translate(Main.mvMatrix,[3.0,0.0,0.0]);
	Main.gl.bindBuffer(Main.gl.ARRAY_BUFFER,Main.squareVertexPositionBuffer);
	Main.gl.vertexAttribPointer(Main.shaderProgram.vertexPositionAttribute,Main.squareVertexPositionBuffer.itemSize,Main.gl.FLOAT,false,0,0);
	Main.setMatrixUniforms();
	Main.gl.drawArrays(Main.gl.TRIANGLE_STRIP,0,Main.squareVertexPositionBuffer.numItems);
}
Main.webGLStart = function() {
	Main.initGL(UserAgent.document.getElementById("hx_webgl_lesson_one"));
	Main.initShaders();
	Main.initBuffers();
	Main.gl.clearColor(0.0,0.0,0.0,1.0);
	Main.gl.enable(Main.gl.DEPTH_TEST);
	Main.drawScene();
}
Main.prototype.__class__ = Main;
$_ = {}
js.Boot.__res = {}
js.Boot.__init();
{
	Object.prototype.iterator = function() {
      var o = this.instanceKeys();
      var y = this;
      return {
        cur : 0,
        arr : o,
        hasNext: function() { return this.cur < this.arr.length; },
        next: function() { return y[this.arr[this.cur++]]; }
      };
    }
	Object.prototype.instanceKeys = function(proto) {
      var keys = [];
      proto = !proto;
      for(var i in this) {
        if(proto && Object.prototype[i]) continue;
        keys.push(i);
      }
      return keys;
    }
}
{
	var d = Date;
	d.now = function() {
		return new Date();
	};
	d.fromTime = function(t) {
		var d1 = new Date();
		d1["setTime"](t);
		return d1;
	};
	d.fromString = function(s) {
		switch(s.length) {
		case 8:
			var k = s.split(":");
			var d1 = new Date();
			d1["setTime"](0);
			d1["setUTCHours"](k[0]);
			d1["setUTCMinutes"](k[1]);
			d1["setUTCSeconds"](k[2]);
			return d1;
		case 10:
			var k = s.split("-");
			return new Date(k[0],k[1] - 1,k[2],0,0,0);
		case 19:
			var k = s.split(" ");
			var y = k[0].split("-");
			var t = k[1].split(":");
			return new Date(y[0],y[1] - 1,y[2],t[0],t[1],t[2]);
		default:
			throw "Invalid date format : " + s;
		}
	};
	d.prototype["toString"] = function() {
		var date = this;
		var m = date.getMonth() + 1;
		var d1 = date.getDate();
		var h = date.getHours();
		var mi = date.getMinutes();
		var s = date.getSeconds();
		return date.getFullYear() + "-" + (m < 10?"0" + m:"" + m) + "-" + (d1 < 10?"0" + d1:"" + d1) + " " + (h < 10?"0" + h:"" + h) + ":" + (mi < 10?"0" + mi:"" + mi) + ":" + (s < 10?"0" + s:"" + s);
	};
	d.prototype.__class__ = d;
	d.__name__ = ["Date"];
}
{
	String.prototype.__class__ = String;
	String.__name__ = ["String"];
	Array.prototype.__class__ = Array;
	Array.__name__ = ["Array"];
	Int = { __name__ : ["Int"]};
	Dynamic = { __name__ : ["Dynamic"]};
	Float = Number;
	Float.__name__ = ["Float"];
	Bool = { __ename__ : ["Bool"]};
	Class = { __name__ : ["Class"]};
	Enum = { };
	Void = { __ename__ : ["Void"]};
}
{
	Math.__name__ = ["Math"];
	Math.NaN = Number["NaN"];
	Math.NEGATIVE_INFINITY = Number["NEGATIVE_INFINITY"];
	Math.POSITIVE_INFINITY = Number["POSITIVE_INFINITY"];
	Math.isFinite = function(i) {
		return isFinite(i);
	};
	Math.isNaN = function(i) {
		return isNaN(i);
	};
}
{
	js.Lib.document = document;
	js.Lib.window = window;
	onerror = function(msg,url,line) {
		var f = js.Lib.onerror;
		if( f == null )
			return false;
		return f(msg,[url+":"+line]);
	}
}
UserAgent.getComputedStyle = window.getComputedStyle;
UserAgent.sessionStorage = window.sessionStorage;
UserAgent.localStorage = window.localStorage;
UserAgent.setTimeout = window.setTimeout;
UserAgent.clearTimeout = window.clearTimeout;
UserAgent.setInterval = window.setInterval;
UserAgent.clearInterval = window.clearInterval;
UserAgent.window = window.window;
UserAgent.self = window.self;
UserAgent.document = window.document;
UserAgent.location = window.location;
UserAgent.history = window.history;
UserAgent.undoManager = window.undoManager;
UserAgent.getSelection = window.getSelection;
UserAgent.locationbar = window.locationbar;
UserAgent.menubar = window.menubar;
UserAgent.personalbar = window.personalbar;
UserAgent.scrollbars = window.scrollbars;
UserAgent.statusbar = window.statusbar;
UserAgent.toolbar = window.toolbar;
UserAgent.close = window.close;
UserAgent.stop = window.stop;
UserAgent.focus = window.focus;
UserAgent.blur = window.blur;
UserAgent.frames = window.frames;
UserAgent.length = window.length;
UserAgent.top = window.top;
UserAgent.opener = window.opener;
UserAgent.parent = window.parent;
UserAgent.frameElement = window.frameElement;
UserAgent.open = window.open;
UserAgent.navigator = window.navigator;
UserAgent.applicationCache = window.applicationCache;
UserAgent.alert = window.alert;
UserAgent.confirm = window.confirm;
UserAgent.prompt = window.prompt;
UserAgent.print = window.print;
UserAgent.showModalDialog = window.showModalDialog;
UserAgent.onafterprint = null;
UserAgent.onbeforeprint = null;
UserAgent.onbeforeunload = null;
UserAgent.onblur = null;
UserAgent.onerror = null;
UserAgent.onfocus = null;
UserAgent.onhashchange = null;
UserAgent.onload = null;
UserAgent.onmessage = null;
UserAgent.onoffline = null;
UserAgent.ononline = null;
UserAgent.onpopstate = null;
UserAgent.onpagehide = null;
UserAgent.onpageshow = null;
UserAgent.onredo = null;
UserAgent.onresize = null;
UserAgent.onstorage = null;
UserAgent.onundo = null;
UserAgent.onunload = null;
UserAgent.onabort = null;
UserAgent.oncanplay = null;
UserAgent.oncanplaythrough = null;
UserAgent.onchange = null;
UserAgent.onclick = null;
UserAgent.oncontextmenu = null;
UserAgent.ondblclick = null;
UserAgent.ondrag = null;
UserAgent.ondragend = null;
UserAgent.ondragenter = null;
UserAgent.ondragleave = null;
UserAgent.ondragover = null;
UserAgent.ondragstart = null;
UserAgent.ondrop = null;
UserAgent.ondurationchange = null;
UserAgent.onemptied = null;
UserAgent.onended = null;
UserAgent.onformchange = null;
UserAgent.onforminput = null;
UserAgent.oninput = null;
UserAgent.oninvalid = null;
UserAgent.onkeydown = null;
UserAgent.onkeypress = null;
UserAgent.onkeyup = null;
UserAgent.onloadeddata = null;
UserAgent.onloadedmetadata = null;
UserAgent.onloadstart = null;
UserAgent.onmousedown = null;
UserAgent.onmousemove = null;
UserAgent.onmouseout = null;
UserAgent.onmouseover = null;
UserAgent.onmouseup = null;
UserAgent.onmousewheel = null;
UserAgent.onpause = null;
UserAgent.onplay = null;
UserAgent.onplaying = null;
UserAgent.onprogress = null;
UserAgent.onratechange = null;
UserAgent.onreadystatechange = null;
UserAgent.onscroll = null;
UserAgent.onseeked = null;
UserAgent.onseeking = null;
UserAgent.onselect = null;
UserAgent.onshow = null;
UserAgent.onstalled = null;
UserAgent.onsubmit = null;
UserAgent.onsuspend = null;
UserAgent.ontimeupdate = null;
UserAgent.onvolumechange = null;
UserAgent.onwaiting = null;
js.Lib.onerror = null;
Main.fragment = ["precision mediump float;\n","void main(void) {","\tgl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);","}"].join("\n");
Main.vertex = ["attribute vec3 aVertexPosition;\n","uniform mat4 uMVMatrix;","uniform mat4 uPMatrix;\n","void main(void) {","\tgl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);","}"].join("\n");
Main.mvMatrix = mat4.create();
Main.pMatrix = mat4.create();
Main.main()