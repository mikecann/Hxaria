package dat;

/**
 * ...
 * @author Mike Cann
 */

extern class GUI 
{

	public function new(options:Dynamic) : Void;
	public function add(options:Dynamic, name:String) : GUI;
	public function name(value:String) : GUI;
	public function min(value:Float) : GUI;
	public function max(value:Float) : GUI;
	public function step(value:Float) : GUI;
	public function onFinishChange(f:Void -> Void) : GUI;
	public function listen() : GUI;
}