/**
 * @author Cref
 */
package haxe;

typedef Lib = 
#if neko
neko
#elseif cpp
cpp
#elseif php
php
#elseif js
js
#end
.Lib;