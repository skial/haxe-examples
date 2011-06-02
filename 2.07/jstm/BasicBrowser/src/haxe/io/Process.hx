/**
 * TODO: write Process class for js targets
 * @author Cref
 */

package haxe.io;
#if neko
typedef Process = neko.io.Process;
#elseif cpp
typedef Process = cpp.io.Process;
#elseif php
typedef Process = php.io.Process;
#end