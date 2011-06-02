package haxe;

#if neko
typedef Web = neko.Web;
#elseif cpp
typedef Web = cpp.Web;
#elseif php
typedef Web = php.Web;
#elseif js
typedef Web = js.Web;
#end