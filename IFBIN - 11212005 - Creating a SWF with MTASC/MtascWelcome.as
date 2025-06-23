	

	/*
	************************************************
	
		EXAMPLE: Creating a SWF with MTASC
		AUTHOR: Josh Tynjala
		CREATED: November 21, 2005
		MODIFIED: November 21, 2005
	
		Macromedia® Flash® by Example
		http://www.ifbin.com
	
	************************************************
	*/	
	
	// Tween is needed for animation
	import mx.effects.Tween;
	
	// MtascWelcome is a MovieClip containing a TextField with the word MTASC.
	// An instance of MtascWelcome will fly, one by one, to random locations on the Stage.
	class MtascWelcome
		extends MovieClip
	{
		// This is TextField containing the word MTASC
		private var _welcome:TextField;
		
		function MtascWelcome()
		{
			// First we create the TextField at depth 1
			this.createTextField("_welcome", 1, 0, 0, 0, 0);
			
			// I find it easiest to let the TextField size itself, but sometimes 
			// you might want a specific width and height.
			this._welcome.autoSize = true;
			
			// Set the text...
			this._welcome.text = "MTASC";
			
			// ...then start the movement!
			this.moveToNewLocation();
		}
		
		// Since we need to generate three random numbers every time a sprite moves,
		// it's much easier to have a function that does all the work.
		private function randomInteger( min:Number, max:Number ):Number
		{
			return Math.round( Math.random() * ( max - min ) ) + min;
		}
		
		private function moveToNewLocation():Void
		{
			// First we generate the x and y positions along with the time
			// in milliseconds that it will take to get there.
			var xPos:Number = this.randomInteger( 0, 640 - this._width );
			var yPos:Number = this.randomInteger( 0, 480 - this._height );
			var time:Number = this.randomInteger( 400, 1000 );
			
			// Then we set up a Tween that handles all the work of creating a smooth animation
			// The first argument is the target, followed by the start value (or multiple values in 
			// an Array), then the end value(s), and finally the duration in milliseconds.
			var glide:Tween = new Tween( this, [ this._x, this._y ], [ xPos, yPos ], time );
			
			// We've chosen to ease out, which means that we will visibly see our clip slow down
			glide.easingEquation = mx.transitions.easing.Regular.easeOut;
		}
		
		// onTweenUpdate is the standard event handler for mx.effects.Tween. It receives updated values
		// as we progress through the animation.
		private function onTweenUpdate( values:Array ):Void
		{
			this._x = values[ 0 ];
			this._y = values[ 1 ];
		}
		
		// onTweenEnd works like onTweenUpdate, but it is called on the final update to tell the listener
		// that the Tween has ended.
		private function onTweenEnd( values:Array ):Void
		{
			// Be sure to call onTweenUpdate one last time, or the value you are Tweening won't reach the 
			// end value(s) you set up earlier!
			this.onTweenUpdate( values );
			
			// Finally, we want to make the sprite move continuously, so we start over again.
			this.moveToNewLocation();
		}
		
		// The main function is the place where code execution begins
		public static function main():Void
		{
			// We want ten of our sprites flying around
			for(var i:Number = 0; i < 10; i++)
			{
				// Create the MovieClips as usual. Here we are incrementing the name and the depth
				// to create unique values.
				var dot:MovieClip = _root.createEmptyMovieClip( "dot" + i, i );
				
				// These two lines allow us to turn a MovieClip into our MovieClip subclass, MtascWelcome
				// This first line changes the type from MovieClip to MtascWelcome
				dot.__proto__ = MtascWelcome.prototype;
				
				// The second line runs the constructor for MtascWelcome
				_global.MtascWelcome.apply(dot);
				
				//In this case, we want to pass all code execution to the MtascWelcome sprites.
			}
		}
	}