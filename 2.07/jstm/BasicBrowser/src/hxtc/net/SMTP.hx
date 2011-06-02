/**
 * Connects to an SMTP server to send e-mails.
 * @author Cref
 */

package hxtc.net;

#if jscript
import activex.cdo.Configuration.SendUsing;
import hxtc.DynamicHash;
#end

class SMTP {
	
	public static function getInstanceByConfig(cfg:DynamicHash<String>) {
		return connect(cfg.smtpHost,Std.parseInt(cfg.smtpPort),cfg.smtpUser,cfg.smtpPass,cfg.smtpSecure!=null);
	}

	#if jscript
	private var cfg:activex.cdo.Configuration;
	//port 0 for using pickup folder
	private function new(hostOrPickupFolder,port,name,pass,secure) {
		cfg = new activex.cdo.Configuration();
		if (port == 0) {
			cfg.sendUsing = SendUsing.pickup;
			cfg.pickupFolder = hostOrPickupFolder;
		}
		else {
			cfg.smtpServer = hostOrPickupFolder;
			cfg.smtpServerPort = port;
			cfg.sendUsername = name;
			cfg.sendPassword = pass;
			cfg.smtpUseSSL = secure;
			cfg.sendUsing = SendUsing.port;//TODO: support pickup (port==0 ?)
		}
		//update?
	}
	
	public function send(email:Email):Void {
		var msg:activex.cdo.Message = untyped email.msg;
		msg.configuration = cfg;
		msg.send();
	}
	#else
	//use mtwin.mail classes
	private var host:String;
	private var port:Int;
	private var name:String;
	private var pass:String;
	private var secure:Bool;
	private function new(host, port, name, pass, secure) {
		if (port == 0) throw 'pickup folder not supported';
		this.host = host;
		this.port = port;
		this.name = name;
		this.pass = pass;
		this.secure = secure;
	}
	
	public function send(email:Email):Void {
		//TODO: implement cc,bcc, secure
		mtwin.mail.Smtp.send(host, email.from, email.to, untyped email.msg.get(), port, name, pass);
	}
	#end
	
	public static function connect(?host:String='localhost',?port:Int=25,?name:String,?pass:String,?secure:Bool=false):SMTP {
		return new SMTP(host,port,name,pass,secure);
	}
	
}