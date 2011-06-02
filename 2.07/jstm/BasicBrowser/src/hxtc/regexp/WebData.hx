/**
 * TODO: fix postcompiler bug! (changes '}$' into '};$')
 * 
 * @author Cref
 */

package hxtc.regexp;

class WebData {

	//came from http://haxe.org/doc/snip/emailvalidation
	public static var email = ~/^[\w-\.]{2,}@[ÅÄÖåäö\w-\.]{2,}\.[a-z]{2,6}$/i;
	public static var markup = ~/<[^>]*>?/gi;
	
}