/**
 * @author Cref
 */
package haxe.zip;
typedef Flush = #if neko neko#elseif cpp ccp#elseif php php#end.zip.Flush;