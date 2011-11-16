package ;

import haxe.Firebug;
import js.Lib;
import utils.ConsoleTracing;

/**
 * ...
 * @author 
 */

class Main 
{
	
	public function new()
	{
		Lib.window.onload = onWindowLoad;
	}
	
	private function onWindowLoad(e) : Void
	{
		new Game();
	}
	
	static function main() 
	{
		//ConsoleTracing.setRedirection();
		Firebug.redirectTraces();
		new Main();
	}
	
}