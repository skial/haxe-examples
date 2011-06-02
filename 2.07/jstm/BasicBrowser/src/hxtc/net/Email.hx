/**
 * This is a class and not just a typedef because this makes it
 * possible on every target to efficiently attach files to an e-mail
 * and then send the same attachments more than once.
 * For instance, to multiple recipients.
 * 
 * Requires CDO.Message for ActiveX targets.
 * Uses mtwin.mail classes for other targets.
 * 
 * @author Cref
 */

package hxtc.net;

class Email {

#if jscript

	public function new(?from:String,?to:String,?cc:String,?bcc:String,?subject:String,?body:String,?attach:Array<String>) {
		msg = new activex.cdo.Message();
		this.from = from;
		this.to = to;
		this.cc = cc;
		this.bcc = bcc;
		this.subject = subject;
		this.body = body;
		if (attach != null) for (a in attach) this.attach(a);
	}
	private var msg:activex.cdo.Message;
	public var from(getFrom, setFrom):String;
	private function getFrom():String return msg.from
	private function setFrom(v:String='') return msg.from=v
	public var to(getTo, setTo):String;
	private function getTo():String return msg.to
	private function setTo(v:String='') return msg.to=v
	public var cc(getCC, setCC):String;
	private function getCC():String return msg.cc
	private function setCC(v:String='') return msg.cc=v
	public var bcc(getBCC, setBCC):String;
	private function getBCC():String return msg.bcc
	private function setBCC(v:String='') return msg.bcc=v
	public var subject(getSubject, setSubject):String;
	private function getSubject():String return msg.subject
	private function setSubject(v:String) return msg.subject=v
	public var body(getBody, setBody):String;
	private function getBody():String return msg.textBody
	private function setBody(v:String) return msg.textBody=v
	public function attach(filePath:String):Void msg.addAttachment(filePath)

#else

	//TODO: use mtwin.mail classes http://haxe.org/com/libs/mtwin/mail/smtp
	private var msg:mtwin.mail.Part;
	public function new() {
		msg = new mtwin.mail.Part("multipart/mixed");
	}

#end

}