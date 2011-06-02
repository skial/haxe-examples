/**
 * TODO: write File class for hxtc targets
 * @author Cref
 */

package haxe.io;
#if neko
typedef File = neko.io.File;
#elseif cpp
typedef File = cpp.io.File;
#elseif php
typedef File = php.io.File;
#elseif js
typedef File = js.io.File;
#end