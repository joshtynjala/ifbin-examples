	

	/*
	************************************************
	
		EXAMPLE: Embedding Fonts With Swfmill
		AUTHOR: Josh Tynjala
		CREATED: December 26, 2005
		MODIFIED: December 26, 2005
	
		Macromedia® Flash® by Example
		http://www.ifbin.com
	
	************************************************
	*/	

	// Our animated special effects are controlled by a Tween.
	import mx.effects.Tween;
	
	class SingleCharacter
		extends MovieClip
	{
		// The TextField that holds the character
		private var _letterField:TextField;
		
		function SingleCharacter( character:String )
		{
			// Hide the MovieClip so it can appear with the animation later.
			this._alpha = 0;
			
			// This is the font style we will be using. Font, point size, color, bold, italic, underline.
			var letterFormat:TextFormat = new TextFormat( "Arial Black", 30, 0x4184c5, false, false, false );
			
			// Create the current letter's TextField
			this.createTextField("_letterField", 1, 0, 0, 0, 0);
			
			// Autosizing allows the TextField to determine the required size on its own.
			this._letterField.autoSize = "left";
			
			// Be sure tell the TextField to use embedded fonts.
			this._letterField.embedFonts = true;
			
			// Set our TextFormat created above...
			this._letterField.setNewTextFormat(letterFormat);
			
			// ...Then set the text
			this._letterField.text = character;
		}
		
		public function displayCharacter():Void
		{
			// A tween allows animation by taking start and end values and changing them
			// over a duration. In this case, we're taking an Array as the arguments.
			// This Tween changes the x and y scaling and the alpha value of the clip for 500ms.
			var animation:Tween = new Tween( this, [ 100, 0 ], [ 200, 100 ], 800 );
			
			// These functions are called as the numbers update, and when the tween ends
			animation.setTweenHandlers( "onFadeInUpdate", "onFadeInEnd" );
		}
		
		public function hideCharacter():Void
		{
			// This time we're only using Number arguments.
			var animation2:Tween = new Tween( this, 100, 0, 500 );
			
			// A quick tip: If you aren't doing anything special when the Tween is finished,
			// it's best to just call the update function instead of a special end function.
			animation2.setTweenHandlers( "onFadeOutUpdate", "onFadeOutUpdate" );
		}
		
		private function onFadeInUpdate( values:Array ):Void
		{
			// Get the old dimensions so that we can center the letter
			var oldWidth:Number = this._width;
			var oldHeight:Number = this._height;
			
			// Change the values so that they animate
			this._xscale = this._yscale = values[ 0 ];
			this._alpha = values[ 1 ];
			
			// Re-center the location
			this._x -= ( this._width - oldWidth ) / 2;
			this._y -= ( this._height - oldHeight ) / 2;
		}
		
		private function onFadeInEnd(values:Array):Void
		{
			// Remember to call onFadeInUpdate one last time!
			this.onFadeInUpdate( values );
		}
		
		private function onFadeOutUpdate( value:Number ):Void
		{
			// Change the alpha to animate
			this._alpha = value;
		}
		
		// Note: there is no onFadeOutEnd because we chose to call onFadeOutUpdate instead.
		
		// The current letter we are animating.
		private static var currentLetter:Number = 0;
		
		// The saved ID for the current interval. We reuse this for many intervals.
		private static var intervalID:Number;
		
		// We call this function when we want to animate the next letter.
		private static function showNextLetter( letters:Array ):Void
		{
			// Check if we've made it to the end of the message.
			if( currentLetter >= letters.length )
			{
				// Reset to the first letter.
				currentLetter = 0;
				
				// Stop the current interval
				clearInterval( intervalID );
				
				// Wait a second, using an interval, then hide the letters.
				intervalID = setInterval(hideLetters, 1000, letters);
			}
			else
			{
				// Display the current letter by calling the function we defined above.
				letters[currentLetter].displayCharacter();
				
				// Go to the next letter
				currentLetter++;
			}
		}
		
		private static function hideLetters( letters:Array ):Void
		{
			// Clear the interval we created because we only want to use it once.
			clearInterval( intervalID );
			
			// Hide each character at the same time
			for( var i:Number = 0; i < letters.length; i++ )
			{
				letters[ i ].hideCharacter();
			}
			
			// Wait a bit, with an interval, then restart the animation.
			intervalID = setInterval( startAnimation, 500, letters );
		}
		
		private static function startAnimation( letters:Array ):Void
		{
			// Just like above, the interval should only be called once.
			// If the interval doesn't exist, we don't need to clear it.
			if(intervalID != undefined) clearInterval( intervalID );
			
			// Every 200 milliseconds, we call the showNextLetter function, and pass it our letters Array.
			// Save the numeric ID of the interval in the intervalID variable.
			intervalID = setInterval( showNextLetter, 400, letters );
		}
		
		// main is the entry point of the SWF.
		public static function main()
		{
			// The message we want our "font machine" to display.
			var message:String = "IFBIN";
			
			// The Array holding all of our characters.
			var letters = new Array();
			
			// We're going to use xLocation to set the location of each letter
			var xLocation = 50;
			
			// Iterate through each character of the message to intantiate a SingleCharacter clip
			for( var i:Number = 0; i < message.length; i++ )
			{
				// Create a single letter
				var currentLetter:MovieClip = _root.createEmptyMovieClip( "letter"+i, i );
				
				// These two lines allow us to turn our MovieClip into our MovieClip subclass, SingleCharacter
				// This first line changes the type from MovieClip to SingleCharacter
				currentLetter.__proto__ = SingleCharacter.prototype;
				
				// The second line runs the constructor, the second argument is an Array that contains
				// all the arguments to the constructor. We want to pass the current character of the message.
				_global.SingleCharacter.apply( currentLetter, [ message.charAt( i ) ] );
				
				// Set the location of the current letter and increment the x location for the next one
				currentLetter._x = xLocation;
				currentLetter._y = 20;
				xLocation += 50;
				
				// Save the letter in our letters Array.
				letters.push( currentLetter );
			}
			
			// Get things started!
			startAnimation(letters);
		}
	}
