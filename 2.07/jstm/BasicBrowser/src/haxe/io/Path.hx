/**
 * TODO: write File class for hxtc targets
 * @author Cref
 */

package haxe.io;
#if neko
typedef Path = neko.io.Path;
#elseif cpp
typedef Path = cpp.io.Path;
#elseif php
typedef Path = php.io.Path;
#elseif js
typedef Path = js.io.Path;
#end