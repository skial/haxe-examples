/**
 * @author Cref
 */
package haxe.net;
typedef ServerLoop = #if neko neko#elseif cpp ccp#elseif php php#end.net.ServerLoop;