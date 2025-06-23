
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
	
	import mx.utils.Delegate;
	import mx.events.EventDispatcher;
	import syndication.rss2.Rss2Channel;
	import syndication.rss2.Rss2Item;
	
	// Loads an RSS 2.0 feed and populates an Rss2Channel object
	class syndication.rss2.Rss2Parser
		extends EventDispatcher
	{
		// Required functions for the EventDispatcher
		public var addEventListener:Function;
		public var removeEventListener:Function;
		private var dispatchEvent:Function;
		
		// Modified version of the built in XML class. Uses EventDispatcher
		private var _feedLoader:EnhancedXML;
		
		// The channel data, which contains every news item
		private var _channel:Rss2Channel;
		
		function Rss2Parser( url:String )
		{
			// Activate the event dispatcher
			EventDispatcher.initialize(this);
			if( url != null ) this.loadFeed( url );
		}
		
		public function loadFeed( url:String ):Void
		{
			this._feedLoader = new EnhancedXML();
			
			// Normally, XML counts whitespace as nodes. We don't want that.
			this._feedLoader.ignoreWhite = true;
			this._feedLoader.addEventListener( "onLoad", Delegate.create( this, onFeedLoad ) );
			this._feedLoader.load( url );
		}
		
		//*** PROPERTIES ***//
		public function get channel():Rss2Channel
		{
			return this._channel;
		}
		
		//*** EVENT HANDLERS ***//
		private function onFeedLoad( event:Object ):Void
		{
			// If the file doesn't exist, or something bad happened, let the listeners know
			if( !event.success ) this.dispatchEvent( { type: "error" } );
			
			// Check for RSS version 2.0
			if( this._feedLoader.childNodes[ 0 ].nodeName == "rss" && this._feedLoader.childNodes[ 0 ].attributes[ "version" ] == "2.0" )
			{
				this._channel = new Rss2Channel();
				var channelNode:XMLNode = this._feedLoader.childNodes[ 0 ].childNodes[ 0 ];
				for( var i:Number = 0; i < channelNode.childNodes.length; i++ )
				{
					// See Rss2Channel for descriptions of the nodes
					switch( channelNode.childNodes[ i ].nodeName )
					{
						case "title" :
							this._channel.title = channelNode.childNodes[ i ].firstChild.nodeValue;
							break;
							
						case "link" :
							this._channel.link = channelNode.childNodes[ i ].firstChild.nodeValue;
							break;
							
						case "description" :
							this._channel.description = channelNode.childNodes[ i ].firstChild.nodeValue;
							break;
							
						case "language" :
							this._channel.language = channelNode.childNodes[ i ].firstChild.nodeValue;
							break;
							
						case "copyright" :
							this._channel.copyright = channelNode.childNodes[ i ].firstChild.nodeValue;
							break;
							
						case "managingEditor" :
							this._channel.managingEditor = channelNode.childNodes[ i ].firstChild.nodeValue;
							break;
							
						case "webMaster" :
							this._channel.webMaster = channelNode.childNodes[ i ].firstChild.nodeValue;
							break;
							
						case "pubDate" :
							this._channel.pubDate = channelNode.childNodes[ i ].firstChild.nodeValue;
							break;
							
						case "lastBuildDate" :
							this._channel.lastBuildDate = channelNode.childNodes[ i ].firstChild.nodeValue;
							break;
							
						case "category" :
							this._channel.categoryName = channelNode.childNodes[ i ].firstChild.nodeValue;
							this._channel.categoryDomain = channelNode.childNodes[ i ].attributes[ "domain" ];
							break;
							
						case "generator" :
							this._channel.generator = channelNode.childNodes[i  ].firstChild.nodeValue;
							break;
							
						case "docs" :
							this._channel.docs = channelNode.childNodes[ i ].firstChild.nodeValue;
							break;
							
						case "ttl" :
							this._channel.ttl = parseInt( channelNode.childNodes[ i ].firstChild.nodeValue );
							break;
							
						case "rating" :
							this._channel.rating = channelNode.childNodes[ i ].firstChild.nodeValue;
							break;
							
						case "cloud" :
							this._channel.cloudDomain = channelNode.childNodes[ i ].attributes[ "domain" ];
							this._channel.cloudPort = parseInt( channelNode.childNodes[ i ].attributes[ "port" ] );
							this._channel.cloudPath = channelNode.childNodes[ i ].attributes[ "path" ];
							this._channel.cloudRegisterProcedure = channelNode.childNodes[ i ].attributes[ "registerProcedure" ];
							this._channel.cloudProtocol = channelNode.childNodes[ i ].attributes[ "protocol" ];
							break;
							
						case "image" :
							this._channel.imageTitle = channelNode.childNodes[ i ].attributes[ "title" ];
							this._channel.imageURL = channelNode.childNodes[ i ].attributes[ "url" ];
							this._channel.imageLink = channelNode.childNodes[ i ].attributes[ "link" ];
							this._channel.imageWidth = parseInt( channelNode.childNodes[ i ].attributes[ "width" ] );
							this._channel.imageHeight = parseInt( channelNode.childNodes[ i ].attributes[ "height"]  );
							this._channel.imageDescription = channelNode.childNodes[ i ].attributes[ "description" ];
							break;
							
						case "textInput" :
							var textInputNode:XMLNode = channelNode.childNodes[ i ];
							for( var j:Number = 0; j < textInputNode.childNodes.length; j++ )
							{
								if( textInputNode.childNodes[j].nodeName == "title" )
									this._channel.textInputTitle = textInputNode.childNodes[ j ].firstChild.nodeValue;
								if( textInputNode.childNodes[j].nodeName == "description" )
									this._channel.textInputDescription = textInputNode.childNodes[ j ].firstChild.nodeValue;
								if( textInputNode.childNodes[ j ].nodeName == "name" )
									this._channel.textInputName = textInputNode.childNodes[ j ].firstChild.nodeValue;
								if( textInputNode.childNodes[  j].nodeName == "link" )
									this._channel.textInputLink = textInputNode.childNodes[ j ].firstChild.nodeValue;
							}
							break;
							
						case "item" :
							var itemNode:XMLNode = channelNode.childNodes[ i ];
							var currentItem:Rss2Item = this.parseNewItem( itemNode );
							this._channel.items.push( currentItem );
							
						default :
							break;
					}
				}
			}
			else this.dispatchEvent( {type: "error" } );
			this.dispatchEvent( { type: "complete" } );
		}
		
		private function parseNewItem( itemNode:XMLNode ):Rss2Item
		{
			var currentItem:Rss2Item = new Rss2Item();
			for(var i:Number = 0; i < itemNode.childNodes.length; i++)
			{
				// See Rss2Item for descriptions of the nodes
				switch( itemNode.childNodes[ i ].nodeName )
				{
					case "title" :
						currentItem.title = itemNode.childNodes[ i ].firstChild.nodeValue;
						break;
						
					case "link" :
						currentItem.link = itemNode.childNodes[ i ].firstChild.nodeValue;
						break;
						
					case "description" :
						currentItem.description = itemNode.childNodes[ i ].firstChild.nodeValue;
						break;
						
					case "author" :
						currentItem.author = itemNode.childNodes[ i ].firstChild.nodeValue;
						break;
						
					case "pubDate" :
						currentItem.pubDate = itemNode.childNodes[ i ].firstChild.nodeValue;
						break;
						
					case "guid" :
						currentItem.guid = itemNode.childNodes[ i ].firstChild.nodeValue;
						
						if( itemNode.childNodes[ i ].attributes[ "isPermaLink" ] == "true" )
							currentItem.guidIsPermaLink = true;
						else currentItem.guidIsPermaLink = false;
						
						break;
						
					case "source" :
						currentItem.sourceName = itemNode.childNodes[ i ].firstChild.nodeValue;
						currentItem.sourceURL = itemNode.childNodes[ i ].attributes[ "url" ];
						break;
						
					case "enclosure" :
						currentItem.enclosureURL = itemNode.childNodes[ i ].attributes["url"];
						currentItem.enclosureLength = itemNode.childNodes[ i ].attributes["length"];
						currentItem.enclosureType = itemNode.childNodes[ i ].attributes["type"];
						break;
						
					case "category" :
						currentItem.categoryName = itemNode.childNodes[ i ].firstChild.nodeValue;
						currentItem.categoryDomain = itemNode.childNodes[ i ].attributes[ "domain" ];
						break;
						
					case "comments" :
						currentItem.comments = itemNode.childNodes[ i ].firstChild.nodeValue;
						break;
						
					default :
						break;
				}
			}
			return currentItem;
		}
	}