
	/*
	************************************************
	
	    EXAMPLE: RSS 2.0 Feed Reader
	    AUTHOR: Josh Tynjala
	    CREATED: February 20, 2006
	    MODIFIED: February 20, 2006
	
	    Macromedia® Flash® by Example
	    http://www.ifbin.com
	
	************************************************
	*/
	
	import syndication.IBasicFeedItem;
	
	// Generally, a news feed contains a title, url, description, and a collection
	// of news items. The accompanying Aggregator can make use of any news feed
	// that implements this interface.
	interface syndication.IBasicFeed
	{
		function getTitle():String;
		function getUrl():String;
		function getDescription():String;
		function getNumItems():Number;
		function getItemAt(index:Number):IBasicFeedItem
	}