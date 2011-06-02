/**
 * @author Cref
 */
package haxe.net;
typedef ProxyDetect = #if neko neko#elseif cpp ccp#elseif php php#end.net.ProxyDetect;