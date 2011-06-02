/**
 * TODO: write FileSystem class for hxtc targets
 * JScript version is almost complete.
 * @author Cref
 */
package haxe;
#if neko
typedef FileSystem = neko.FileSystem;
#elseif cpp
typedef FileSystem = cpp.FileSystem;
#elseif php
typedef FileSystem = php.FileSystem;
#elseif js
typedef FileSystem = js.FileSystem;
#end