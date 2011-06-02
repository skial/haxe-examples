/**
 * @author Cref
 */
package haxe.zip;
typedef Uncompress = #if neko neko#elseif cpp ccp#elseif php php#end.zip.Uncompress;