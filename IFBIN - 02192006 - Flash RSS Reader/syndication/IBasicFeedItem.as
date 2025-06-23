
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
	
	// In general, an item in a feed contains a title, author, description, link to the
	// document on the web, and the date it was published. The accompanying Aggregator
	// handles any news item that comes from an IBasicFeed and implements IBasicFeedItem.
	interface syndication.IBasicFeedItem
	{
		function getTitle():String;
		function getAuthor():String;
		function getDescription():String;
		function getUrl():String;
		function getDate():String;
	}