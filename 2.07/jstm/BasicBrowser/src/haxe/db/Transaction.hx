/**
 * TODO: write Transaction class for js targets
 * @author Cref
 */
package haxe.db;

#if neko
typedef Transaction = neko.db.Transaction;
#elseif php
typedef Transaction = php.db.Transaction;
#elseif js
typedef Transaction = js.db.Transaction;
#end