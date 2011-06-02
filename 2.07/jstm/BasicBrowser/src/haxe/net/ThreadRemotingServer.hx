/**
 * @author Cref
 */
package haxe.net;
typedef ThreadRemotingServer = #if neko neko#elseif cpp ccp#elseif php php#end.net.ThreadRemotingServer;