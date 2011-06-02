/**
 * @author Cref
 */
package haxe.zip;
typedef Writer = #if neko neko#elseif cpp ccp#elseif php php#end.zip.Writer;