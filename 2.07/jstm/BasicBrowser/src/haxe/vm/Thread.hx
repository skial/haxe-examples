/**
 * @author Cref
 */
package haxe.vm;
#if (neko || cpp)
typedef Thread = #if neko neko#else ccp#end.vm.Thread
#end