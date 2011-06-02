package haxe.io;
#if neko
typedef FileOutput = neko.io.FileOutput;
#elseif cpp
typedef FileOutput = cpp.io.FileOutput;
#elseif php
typedef FileOutput = php.io.FileOutput;
#elseif js
typedef FileOutput = js.io.FileOutput;
#end