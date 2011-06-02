package haxe;
#if neko
typedef Utf8 = neko.Utf8;
#elseif cpp
typedef Utf8 = ccp.Utf8;
#elseif php
typedef Utf8 = php.Utf8;
#elseif js
typedef Utf8 = js.Utf8;
#elseif flash
//not ready yet
//typedef Utf8 = js.Utf8;
#end