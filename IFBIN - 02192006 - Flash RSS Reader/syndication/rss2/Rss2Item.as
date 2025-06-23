
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
	

	// Contains information about a specific news item in an RSS 2.0 feed
	class syndication.rss2.Rss2Item
	{
		// The name of the item
		public var title:String;
		
		// The URL where the item resides
		public var link:String;
		
		// A short description of the item
		public var description:String;
		
		// The email address of the person who created the item
		public var author:String;
		
		// A string that identifies a categorization taxonomy
		public var categoryName:String;
		
		// Links the channel to its identifier in a cataloging system
		public var categoryDomain:String;
		
		// The URL where users can comment on the item
		public var comments:String;
		
		// Note: Enclosure is an optional media element, such as an mp3
		// The URL where the user can access the enclosure
		public var enclosureURL:String;
		
		// The length (in bytes) of the enclosure
		public var enclosureLength:String;
		
		// The MIME type of the enclosure (audio/mpeg, text/html)
		public var enclosureType:String;
		
		// A string that uniquely identifies this item
		public var guid:String;
		
		// Set true if the guid is a URL to the item
		public var guidIsPermaLink:Boolean;
		
		// The publish date with the format "Sun, 19 May 2002 15:21:36 GMT"
		public var pubDate:String;
		
		// The name of the RSS channel that the item came from
		public var sourceName:String;
		
		// The XMLization of the source
		public var sourceURL:String;
		
		// A title and description must be defined for each item
		function Rss2Item( itemTitle:String, itemDescription:String )
		{
			this.title = itemTitle;
			this.description = itemDescription;
		}
	}