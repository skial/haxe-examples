/**
 * @author Cref
 */
package haxe.zip;
typedef CRC32 = #if neko neko#elseif cpp ccp#elseif php php#end.zip.CRC32;