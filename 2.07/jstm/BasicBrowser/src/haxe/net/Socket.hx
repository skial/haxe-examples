/**
 * @author Cref
 */
package haxe.net;
typedef Socket = #if neko neko#elseif cpp ccp#elseif php php#end.net.Socket;