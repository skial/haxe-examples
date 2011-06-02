/**
 * @author Cref
 */
package haxe.net;
typedef SocketInput = #if neko neko#elseif cpp ccp#elseif php php#end.net.SocketInput;