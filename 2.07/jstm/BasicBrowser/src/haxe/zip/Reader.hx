/**
 * @author Cref
 */
package haxe.zip;
typedef Reader = #if neko neko#elseif cpp ccp#elseif php php#end.zip.Reader;