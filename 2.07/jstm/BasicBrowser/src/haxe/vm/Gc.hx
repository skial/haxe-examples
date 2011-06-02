/**
 * @author Cref
 */
package haxe.vm;
#if (neko || cpp)
typedef Gc = #if neko neko#else ccp#end.vm.Gc;
#end