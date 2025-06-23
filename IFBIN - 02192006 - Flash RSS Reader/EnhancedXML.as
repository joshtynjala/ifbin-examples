
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
	
	import mx.events.EventDispatcher;

	// EnhancedXML wraps the built-in XML class and uses EventDispatcher
	class EnhancedXML
		extends XML
	{
		// Define the functions that EventDispatcher.initialize creates
		public var addEventListener:Function;
		public var removeEventListener:Function;
		private var dispatchEvent:Function;
		
		//*** CONSTRUCTOR ***//
		function EnhancedXML( source:String )
		{
			// Pass on the source so the regular XML class can handle it
			super(source);
			
			// Start up the EventDispatcher
			EventDispatcher.initialize( this );
		}
		
		//*** PUBLIC FUNCTIONS ***//
		public function onData( data:String ):Void
		{
			// Here you can see the default behavior normally defined in onData
			if(data == undefined) this.onLoad( false );
			else
			{
				this.parseXML( data );
				this.loaded = true;
				this.onLoad( true );
				
				// This line changes the default behavior by dispatching the event
				this.dispatchEvent( { type: "onData", data: data } );
			}
		}
		
		public function onLoad( success:Boolean ):Void
		{
			// Pass on the event to this listeners
			this.dispatchEvent( { type: "onLoad", success: success } );
		}
	}