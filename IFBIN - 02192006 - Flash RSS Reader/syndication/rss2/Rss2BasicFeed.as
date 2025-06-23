
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
	
	import syndication.rss2.Rss2Channel;
	import syndication.rss2.Rss2BasicFeedItem;
	import syndication.IBasicFeed;
	import syndication.IBasicFeedItem;
	
	// Wrapper used to convert an Rss2Channel to be compatible with IBasicFeed.
	class syndication.rss2.Rss2BasicFeed
		implements IBasicFeed
	{
		private var _channel:Rss2Channel;
		private var _items:Array;
		
		function Rss2BasicFeed(channel:Rss2Channel)
		{
			this._channel = channel;
		}
		
		public function getTitle():String
		{
			return this._channel.title;
		}
		
		public function getUrl():String
		{
			return this._channel.link;
		}
		
		public function getDescription():String
		{
			return this._channel.description;
		}
		
		public function getNumItems():Number
		{
			return this._channel.items.length;
		}
		
		public function getItemAt( index:Number ):IBasicFeedItem
		{
			return new Rss2BasicFeedItem( this._channel.items[index] );
		}
	}