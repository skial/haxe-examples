package haxe.db;
#if neko
typedef Mysql = neko.db.Mysql;
#elseif cpp
typedef Mysql = ccp.db.Mysql;
#elseif php
typedef Mysql = php.db.Mysql;
#elseif js
typedef Mysql = js.db.Mysql;
#end