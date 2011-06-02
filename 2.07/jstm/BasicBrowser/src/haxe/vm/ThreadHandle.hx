/**
 * @author Cref
 */
package haxe.vm;
#if (neko || cpp)
typedef ThreadHandle = #if neko neko#else ccp#end.vm.ThreadHandle
#end