/**
 * @author Cref
 */
package haxe.net;
typedef Host = #if neko neko#elseif cpp ccp#elseif php php#end.net.Host;