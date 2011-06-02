/**
 * @author Cref
 */
package haxe.net;
typedef Poll = #if neko neko#elseif cpp ccp#elseif php php#end.net.Poll;