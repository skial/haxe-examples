/**
 * @author Cref
 */
package haxe.net;
typedef ThreadServer = #if neko neko#elseif cpp ccp#elseif php php#end.net.ThreadServer;