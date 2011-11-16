package utils;

/**
 * ...
 * @author mikecann.co.uk
 */

class StopWatch 
{

	public var startTime : Float;
	public var stopTime : Float;
	
	public function new() 
	{
		startTime = Date.now().getTime();
	}
	
	public function stop(?traceString:String)
	{
		stopTime = Date.now().getTime();
		var diff : Float = stopTime-startTime;
		if (traceString!=null)
		{
			trace(traceString+". Time Taken: "+diff+"ms");
		}
	}
	
}