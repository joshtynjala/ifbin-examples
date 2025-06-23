
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
	import syndication.rss2.Rss2Item;
	
	// Wrapper used to convert an Rss2Item to an IBasicFeedItem
	class syndication.rss2.Rss2BasicFeedItem
		implements IBasicFeedItem
	{
		private var _item:Rss2Item;
		
		function Rss2BasicFeedItem( item:Rss2Item )
		{
			this._item = item;
		}
		
		public function getTitle():String
		{
			return this._item.title;
		}
		
		public function getAuthor():String
		{
			return this._item.author;
		}
		
		public function getDescription():String
		{
			return this._item.description;
		}
		
		public function getUrl():String
		{
			return this._item.link;
		}
		
		public function getDate():String
		{
			return this._item.pubDate;
		}
	}