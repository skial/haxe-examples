/**
 * TODO: build for each target
 * @author Cref
 */

package haxe;
#if neko
typedef Random = neko.Random;
#elseif cpp
typedef Random = cpp.Random;
#end