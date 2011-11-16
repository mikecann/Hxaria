package utils.js;
import haxe.Timer;
import js.Lib;

/**
 * ...
 * @author MikeCann
 */

class Framerate 
{
	private var timer : Timer;
	private var frames : Int;
	private var lastUpdateTime : Float;

	public function new() 
	{
		frames = 0;
		lastUpdateTime = Date.now().getTime();
		timer = new Timer(500);
		timer.run = onUpdateFramerate;
	}
	
	private function onUpdateFramerate():Void 
	{
		var ti = Date.now().getTime();
		var fps = Math.round(1000*frames/(ti - lastUpdateTime));
		Lib.document.getElementById("framerate").innerHTML = fps+"fps";
		frames = 0;  lastUpdateTime = ti;
	}
	
	public function inc() : Void
	{
		frames++;
	}
}