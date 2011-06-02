/**
 * The RAW Twitter API
 * Needs a wrapper
 * 
 * http://apiwiki.twitter.com/w/page/22554756/Twitter-Search-API-Method:-search
 * 
 * Far from ready...
 * just an example for now.
 * 
 * @author Cref
 */

package hxtc.web.apis.twitter;

import hxtc.net.HTTP;

class Search {
	
	public static function query(options:SearchOptions, cb:SearchResult->Void) {
		HTTP.loadCallback('http://search.twitter.com/search.json?'+hxtc.web.Data.serialize(options), cb);
	}
	
}

typedef SearchOptions = {
	q:String,
	lang:String,
	rpp:Int,
	page:Int
}

typedef SearchResult = {
	results:Array<Tweet>,
	max_id:Int,
	since_id:Int,
	refresh_url:String,
	next_page:String,
	results_per_page:Int,
	page:Int,
	completed_in:Float,
	since_id_str:String,
	max_id_str:String,
	query:String
}

typedef Tweet = {
	from_user_id_str:String,
	profile_image_url:String,
	created_at:String,//translate to date?
	from_user:String,
	id_str:String,
	metadata: { result_type:String },//will there be more?
	place: {
		full_name:String,
		id:String,
		type:String
	},
	to_user_id:Int,
	text:String,
	id:Int,
	from_user_id:Int,
	to_user:String,
	geo:Dynamic,//TODO: I don't know the type yet
	iso_language_code:String,
	to_user_id_str:String,
	source:String
}