package ;
import dat.GUI;

/**
 * ...
 * @author 
 */

class GUIManager 
{	
	public var goldChance : Float;
	public var rockChance : Float;
	public var diamondsChance : Float;
	public var mapWidth : Int;
	public var mapHeight : Int;
		
	private var gui : GUI;
	private var game : Game;
	
	public function new(game:Game) 
	{
		this.game = game;
		
		gui = new GUI( { height : 5 * 32 - 1 } );
		
		goldChance = game.tilemap.goldSpawnChance;
		rockChance = game.tilemap.rockSpawnChance;
		diamondsChance = game.tilemap.diamondsSpawnChance;
		game.tilemap.mapResized = onTilemapResized;
		mapWidth = 0;
		mapHeight = 0;
		
		gui.add(this, 'goldChance').name("Gold").min(0).max(1).step(0.001).onFinishChange(function() { game.tilemap.goldSpawnChance = goldChance; } );
		gui.add(this, 'rockChance').name("Rock").min(0).max(1).step(0.001).onFinishChange(function() { game.tilemap.rockSpawnChance = rockChance; } );
		gui.add(this, 'diamondsChance').name("Diamond").min(0).max(1).step(0.001).onFinishChange(function() { game.tilemap.diamondsSpawnChance = diamondsChance; } );	
		gui.add(this, 'mapWidth').listen();
		gui.add(this, 'mapHeight').listen();
	}
	
	private function onTilemapResized(mapW:Int, mapH:Int):Void 
	{
		mapWidth = mapW;
		mapHeight = mapH;
	}
}