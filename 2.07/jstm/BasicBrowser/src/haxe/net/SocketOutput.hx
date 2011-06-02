/**
 * @author Cref
 */
package haxe.net;
typedef SocketOutput = #if neko neko#elseif cpp ccp#elseif php php#end.net.SocketOutput;