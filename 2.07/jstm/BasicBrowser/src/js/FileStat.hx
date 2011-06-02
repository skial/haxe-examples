package js;

typedef FileStat = {
	var gid : Int;
	var uid : Int;
	var atime : Date;
	var mtime : Date;
	var ctime : Date;
	var dev : Int;
	var ino : Int;
	var nlink : Int;
	var rdev : Int;
	var size : Int;
	var mode : Int;
}