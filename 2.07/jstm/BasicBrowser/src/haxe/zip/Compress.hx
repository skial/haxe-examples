/**
 * @author Cref
 */
package haxe.zip;
typedef Compress = #if neko neko#elseif cpp ccp#elseif php php#end.zip.Compress;