	

	/*
	************************************************
	
		EXAMPLE: Using Swfmill to create a library for MTASC
		AUTHOR: Josh Tynjala
		CREATED: December 8, 2005
		MODIFIED: December 8, 2005
	
		Macromedia® Flash® by Example
		http://www.ifbin.com
	
	************************************************
	*/	
	
	// Tween is needed for animation
	import mx.effects.Tween;
	
	// IntroToSwfmill is based on my Intro to MTASC Example. Instead of a randomly moving
	// TextField with the word MTASC, this time we're attaching the IFBIN logo from a library
	// created with the program Swfmill.
	// An instance of IfbinLogo will fly around to random locations on the Stage and rotate.
	class IfbinLogo
		extends MovieClip
	{	
		function IfbinLogo()
		{
			// Start the movement!
			this.moveToNewLocation();
		}
		
		// Since we need to generate four random numbers every time a sprite moves,
		// it's much easier to have a function we can call to do all the work.
		private function randomInteger( min:Number, max:Number ):Number
		{
			return Math.round( Math.random() * ( max - min ) ) + min;
		}
		
		private function moveToNewLocation():Void
		{
			// First we generate the x and y positions, the duration of the animation, and the rotation value.
			var xPos:Number = this.randomInteger( 0, 640 - this._width );
			var yPos:Number = this.randomInteger( 0, 480 - this._height );
			var time:Number = this.randomInteger( 400, 1000 );
			var rotation:Number = this.randomInteger( 0, 359 );
			
			// A Tween handles all the work of creating a smooth animation
			// The first argument is the target, followed by the start value (or multiple values in 
			// an Array), then the end value(s), and finally the duration in milliseconds.
			var glide:Tween = new Tween( this, [ this._x, this._y, this._rotation ], [ xPos, yPos, rotation ], time );
			
			// We've chosen to ease out, which means that we will visibly see our clip slow down
			// as it reaches the end of the animation
			glide.easingEquation = mx.transitions.easing.Regular.easeOut;
		}
		
		// onTweenUpdate is the standard event handler for mx.effects.Tween. It receives updated values
		// as we progress through the animation.
		private function onTweenUpdate( values:Array ):Void
		{
			this._x = values[ 0 ];
			this._y = values[ 1 ];
			this._rotation = values[ 2 ];
		}
		
		// onTweenEnd works like onTweenUpdate, but it is called on the final update to tell the listener
		// that the Tween has ended.
		private function onTweenEnd( values:Array ):Void
		{
			// Be sure to call onTweenUpdate one last time, or the value you are Tweening won't reach the 
			// end value(s) you set up earlier!
			this.onTweenUpdate( values );
			
			// Finally, we want to make the sprite move continuously, so we start all over again.
			this.moveToNewLocation();
		}
		
		// The main function is the place where code execution begins
		public static function main():Void
		{
			// We want ten of our logos to fly around
			for(var i:Number = 0; i < 10; i++)
			{
				// Just like in regular Flash movies, to get a clip from the library, we use attachMovie
				var currentLogo:MovieClip = _root.attachMovie("imageInLibrary", "_logo" + i, i);
				
				// These two lines allow us to turn a MovieClip into our MovieClip subclass, IfbinLogo
				// This first line changes the type from MovieClip to IfbinLogo
				currentLogo.__proto__ = IfbinLogo.prototype;
				
				// The second line runs the constructor
				_global.IfbinLogo.apply(currentLogo);
				
				//In this case, we want to pass all code execution to the IfbinLogo sprites.
			}
		}
	}