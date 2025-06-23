
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
	
	// A specific source for news items specified by an RSS 2.0 feed
	class syndication.rss2.Rss2Channel
	{
		// Note: title, link, and description are required!
		
		// The name of the RSS 2.0 service. Generally, same as the webpage title.
		public var title:String;
		
		// The URL to the HTML website where the channel originated.
		public var link:String;
		
		// A phrase or sentence describing the channel.
		public var description:String;
		
		// Note: The following elements are optional.
		
		// The code for the language in which the channel is written. (en-us, fr, jp)
		public var language:String;
		
		// Copyright notice for the channel's content (Copyright 2006, Josh Tynjala)
		public var copyright:String
		
		// Email addrss for the person responsible for editoral content
		public var managingEditor:String;
		
		// Email address for the person responsible for technical issues
		public var webMaster:String;
		
		// Publication date for the channel content. Should appear in the form "Sun, 19 May 2002 15:21:36 GMT"
		public var pubDate:String;
		
		// The last time the content was generated
		public var lastBuildDate:String;
		
		// A string that identifies a categorization taxonomy
		public var categoryName:String;
		
		// Links the channel to its identifier in a cataloging system
		public var categoryDomain:String;
		
		// Program or script used to generate the feed.
		public var generator:String;
		
		// URL that points to the RSS 2.0 specification. (http://blogs.law.harvard.edu/tech/rss)
		public var docs:String;
		
		// Time-to-live, in minutes. How long a channel can be cached.
		public var ttl:Number;
		
		// The PICS rating for the channel content (http://www.w3.org/PICS/)
		public var rating:String;
		
		// Processes may register with a "cloud" to be notified of updates to the channel.
		
		// Domain of the cloud.
		public var cloudDomain:String;
		
		//Port used to connect to the cloud 
		public var cloudPort:Number;
		
		// Path of the cloud on the domain
		public var cloudPath:String;
		
		// Procedure to call to register with the cloud (ex. myCloud.rssPleaseNotify)
		public var cloudRegisterProcedure:String;
		
		// Protocol used to connect to the cloud (HTTP-POST, XML-RPC or SOAP 1.1)
		public var cloudProtocol:String;
		
		// An image may be included with the channel 
		
		// Alternate text to show if the client can't show the image, like an HTML alt attribute
		public var imageTitle:String;
		
		// The URL of the image.
		public var imageURL:String;
		
		// An URL to associate with the image (hyperlink)
		public var imageLink:String;
		
		// Width in pixels to display the image.
		public var imageWidth:Number;
		
		// Height in pixels to display the image.
		public var imageHeight:Number;
		
		// Text to associate with the image, like an HTML title attribute
		public var imageDescription:String;
		
		// A text input box can be included that could be used to search the associated
		// website, or to leave a comment.
		
		// Label that should appear on the submit button
		public var textInputName:String;
		
		// The name of the text object
		public var textInputTitle:String;

		// Explains the text input area.
		public var textInputDescription:String;
		
		//URL of CGI script to handle the input
		public var textInputLink:String;
		
		// A hint to inform aggregators to skip certain hours. An array of numbers (0-23).
		public var skipHours:Array;
		
		// A hint to inform aggregators to skip certain days. An array of strings (Monday, Tuesday...)
		public var skipDays:Array;
		
		//the list of items in the channel (see Rss2Item)
		public var items:Array;
		
		// title, link, and description are required!
		function Rss2Channel( theTitle:String, theLink:String, theDescription:String )
		{
			this.title = theTitle;
			this.link = theLink;
			this.description = theDescription;
			this.items = new Array();
		}
	}