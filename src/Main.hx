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
	private var _game : Game;
	private var _guiMan : GUIManager;
	
	public function new()
	{
		Lib.window.onload = onWindowLoad;
	}
	
	private function onWindowLoad(e) : Void
	{
		_game = new Game();
		_guiMan = new GUIManager(_game);		
	}
	
	static function main() 
	{
		//ConsoleTracing.setRedirection();
		Firebug.redirectTraces();
		new Main();
	}
	
}