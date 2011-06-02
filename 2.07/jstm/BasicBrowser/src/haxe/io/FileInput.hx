/**
 * TODO: write FileInput class for js targets
 * @author Cref
 */

package haxe.io;
typedef FileInput = #if neko neko#elseif cpp ccp #elseif php php #end.io.FileInput;