
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
	
	import syndication.IBasicFeed;
	import syndication.IBasicFeedItem;
	import mx.controls.DataGrid;
	import mx.controls.gridclasses.DataGridColumn;
	import mx.controls.TextArea;
	import mx.controls.List;
	import mx.utils.Delegate;
	
	class Aggregator extends MovieClip
	{
		private var _savedFeeds:Array;
		
		// We use Arrays as dataProviders for our components
		private var feeds:List;
		private var itemGrid:DataGrid;
		private var itemViewer:TextArea;
		private var _items:Array;
		
		// Flag that is set once the listeners are created for the List and DataGrid
		private var _listListenerCreated:Boolean;
		private var _gridListenerCreated:Boolean;
		
		function Aggregator()
		{
			this._listListenerCreated = false;
			this._gridListenerCreated = false;
			
			// Add the columns for the DataGrid
			var titles:DataGridColumn = new DataGridColumn( "title" );
			titles.width = this.itemGrid.width / 2;
			titles.headerText = "Title";
			this.itemGrid.addColumn( titles );
			
			var dates:DataGridColumn = new DataGridColumn( "date" );
			dates.width = this.itemGrid.width / 2;
			dates.headerText = "Date";
			this.itemGrid.addColumn( dates );
		}
	
		// Accepts an IBasicFeed, described in IBasicFeed.as
		public function addFeed( data:IBasicFeed ):Void
		{
			// The listeners won't properly register in the constructor.
			// I've added flags so that the delegate is only created once.
			if( !this._listListenerCreated )
			{
				this.feeds.addEventListener( "change", Delegate.create( this, updateItemGrid ) );
				this._listListenerCreated = true;
			}
			if( !this._gridListenerCreated )
			{
				this.itemGrid.addEventListener( "change", Delegate.create( this, updateItemViewer ) );
				this._gridListenerCreated = true;
			}
			
			// Create the feeds array if this is our first feed
			if( this._savedFeeds == null ) this._savedFeeds = new Array();
			this._savedFeeds.push(data);
	
			var title:String = data.getTitle();
			
			// If there is no title specified, use the URL
			if(title == undefined) title = data.getUrl();
	
			this.feeds.addItem( title );
		}
		
		// Called when a user clicks on a feed title
		private function updateItemGrid():Void
		{
			this.itemGrid.removeAll();
			// If there is no feed selected, don't do anything
			if( this.feeds.selectedIndex < 0 ) return;
			
			// Get the feed that matches the selected title
			var selectedFeed:IBasicFeed = this._savedFeeds[ this.feeds.selectedIndex ];
			
			// Loop through each item and add it to the item grid
			for( var i:Number = 0; i < selectedFeed.getNumItems(); i++ )
			{
				var currentItem:IBasicFeedItem = selectedFeed.getItemAt( i );
				
				// The item grid's columns are set up to automatically handle an IBasicFeedItem
				this.itemGrid.addItem( {title: currentItem.getTitle(), date: currentItem.getDate() } );
			}
		}
		
		// Called when an item is selected in the item grid
		private function updateItemViewer():Void
		{
			// Get the feed that is selected in the title list
			var selectedFeed:IBasicFeed = this._savedFeeds[ this.feeds.selectedIndex ];
			
			// Get the item that is selected in the item grid
			var selectedItem:IBasicFeedItem = selectedFeed.getItemAt( this.itemGrid.selectedIndex );
			
			// Format and display information about the item in the item viewer
			var itemText:String = "";
			
			// Some information might not exist, so skip it
			if(selectedItem.getTitle() != undefined)
				itemText += "<p><font size=\"16\"><b>" + selectedItem.getTitle() + "</b></font></p>";
			if(selectedItem.getDate() != undefined)
				itemText += "<p><font size=\"10\"><b>" + selectedItem.getDate() + "</b></font></p>";
			if(selectedItem.getDescription() != undefined)
				itemText += "<p><br/><font size=\"12\">" + selectedItem.getDescription() + "</font></p>";
			if(selectedItem.getUrl() != undefined)
				itemText += "<p><br/><font size=\"12\" color=\"#0000ff\"><u><a href=\"" + selectedItem.getUrl() + "\">View Item</a></u></font></p>"; 
				
			// We're getting fancy, and making it HTML
			this.itemViewer.html = true;
			this.itemViewer.text = itemText;
		}
	}
