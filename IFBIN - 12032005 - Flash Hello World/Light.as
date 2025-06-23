
	/*
	************************************************
	
	    EXAMPLE: Hello World
	    AUTHOR: Josh Tynjala
	    CREATED: November 10, 2005
	    MODIFIED: November 10, 2005
	
	    Macromedia® Flash® by Example
	    http://www.ifbin.com
	
	************************************************
	*/
	
	// import the external classes that we reference below
	import flash.geom.Transform;
	import flash.geom.ColorTransform;
	import mx.effects.Tween;
	import mx.transitions.easing.Strong;
	
	// each Light is a MovieClip with added functionality
	class Light extends MovieClip
	{
		// This allows us to modify the appearance of a MovieClip.
		private var lightTransformer:Transform;
		
		// The letter than appears when the light brightens
		private var letter:String;
		
		// The actual TextField the letter appears in.
		private var letterField:TextField;
		
		// Here we have the constructor, the first function called in a class
		public function Light()
		{
			// hide the letter TextField until we need it
			letterField._visible = false;
			
			// lightTransformer will allow us to modify the color for brightening the Light
			lightTransformer = new Transform( this );
		}
		
		// This is the function that gets called on the interval on the main timeline
		public function activate():Void
		{
			// a Tween is like an interval since it calls a function several times
			// over a period of time, but it also requires that you give it start and
			// stop values that it changes each time the function is called. These
			// values may even be in an Array so that you can change multiple values
			// at once. Unlike an interval, Tweens work on a specific duration, which 
			// you must specify. You can see that this Tween finishes in 300 milliseconds.
			var brighten:Tween = new Tween( this, [ 0, 0, 0 ], [ 255, 255, 150 ], 400 );
			
			// An easing equation allows you to change the value of a Tween in different ways.
			// A strong Tween changes quickly from start to finish. You can find other
			// easing equations in the mx.transitions.easing namespace
			brighten.easingEquation = Strong.easeOut;
			
			// We set the specific functions to call when the Tween wants to update the values
			// and when we reach the end of the duration.
			brighten.setTweenHandlers( "onColorUpdate", "onColorBrightenEnd" );
		}
		
		// The update function
		private function onColorUpdate(values):Void
		{
			// A ColorTransform works with our main Tranform object to change the color of
			// the Light. The values we sent through this Tween are RGB color values.
			var color:ColorTransform = new ColorTransform( 1, 1, 1, 1, values[0], values[1], values[2], 0 );
			lightTransformer.colorTransform = color;
		}
		
		// The function that is called when we finish brightening
		private function onColorBrightenEnd(values):Void
		{
			// You should call the update function one last time!
			this.onColorUpdate(values);
			
			//show or hide the letter by setting the _visible property to its opposite
			letterField._visible = !letterField._visible;
			
			// Finally, we want to darken the light again. Like above, we have an Array of values.
			var darken:Tween = new Tween( this, [ 255, 255, 150 ], [ 0, 0, 0 ], 1000 );
			darken.easingEquation = Strong.easeOut;
			// We're going to reuse "onColorUpdate", but we need a new ending function
			darken.setTweenHandlers( "onColorUpdate", "onColorDarkenEnd" );
		}
		
		// The function that is called when we finish darkening
		private function onColorDarkenEnd( values:Array ):Void
		{
			// Call update function one last time.
			this.onColorUpdate( values );
		}
	}