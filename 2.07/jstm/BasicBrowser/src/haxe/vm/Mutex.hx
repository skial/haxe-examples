/**
 * @author Cref
 */
package haxe.vm;
#if (neko || cpp)
typedef Mutex = #if neko neko#else ccp#end.vm.Mutex
#end