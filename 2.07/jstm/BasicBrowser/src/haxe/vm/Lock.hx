/**
 * @author Cref
 */
package haxe.vm;
#if (neko || cpp)
typedef Lock = #if neko neko#else ccp#end.vm.Lock
#end