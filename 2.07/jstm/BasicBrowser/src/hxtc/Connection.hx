/**
 * Generic typedef for a connection.
 * Can be used for making database connections but also others, for example:
 * SMTP, FTP, HTTP(S) etc.
 * @author Cref
 */

package hxtc;

typedef Connection = {
	host:String,
	port:Int,
	user:String,
	pass:String
}