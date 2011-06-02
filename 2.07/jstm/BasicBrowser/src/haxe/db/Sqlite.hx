package haxe.db;
#if neko
typedef Sqlite = neko.db.Sqlite;
#elseif cpp
typedef Sqlite = ccp.db.Sqlite;
#elseif php
typedef Sqlite = php.db.Sqlite;
#elseif js
typedef Sqlite = js.db.Sqlite;
#end