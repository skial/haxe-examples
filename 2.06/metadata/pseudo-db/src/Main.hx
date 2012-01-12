package ;

import flash.Lib;
import com.skialbainn.pseudo.db.Model;

@table('Client Contact')
class Contact extends Model {
	
	public function new() { }
	
	@key
	public var id:Int;
	
	@required
	public var firstName:String;
	
	@required
	public var lastName:String;
	
	@required
	public var email:String;
	
	public var address:String;
	public var phone:String;
}

class Main {
	
	static function main() {
		var contact:Contact = new Contact();
		contact.firstName = 'Skial';
		contact.lastName = 'Bainn';
		//contact.email = 'dummy@skialbainn.com';
		contact.put();
	}
	
}