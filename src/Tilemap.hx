package ;
import js.Lib;
import utils.Rand;

/**
 * ...
 * @author 
 */

class Tilemap 
{
	public static inline var TILE_SIZE : Int = 16;
		
	public var tiles : Array<Array<Tile>>;
	public var game : Game;
	public var scrollX(default,set_scrollX) : Float;
	public var scrollY(default,set_scrollY) : Float;
	public var tilesWide : Int;
	public var tilesHigh : Int;	
	public var mapResized : Int -> Int -> Void;
	public var goldSpawnChance : Float;
	public var rockSpawnChance : Float;
	public var diamondsSpawnChance : Float;
	
	private var scrollTileOffsetX : Int;
	private var scrollTileOffsetY : Int;
	
	public function new(game:Game) 
	{
		this.game = game;
		goldSpawnChance = 0.05;
		rockSpawnChance = 0.1;
		diamondsSpawnChance = 0.01;
		init();
	}
	
	private function init():Void 
	{
		tilesWide = Std.int(Lib.window.innerWidth / Tilemap.TILE_SIZE) + 1;
		tilesHigh = Std.int(Lib.window.innerHeight / Tilemap.TILE_SIZE) + 1;
		tiles = new Array<Array<Tile>>();
		
		// Create the geometry
		for (yi in 0...tilesHigh) 
		{
			tiles.push(new Array<Tile>());
			for (xi in 0...tilesWide) 
			{			
				var type = 15;
				if (yi == 0) type = 1;
				else if (xi == 0) type = 0;
				else if (yi == tilesHigh - 1) type = 33;
				else if (xi == tilesWide-1) type = 4;
				tiles[yi].push(new Tile(xi, yi, type));
			}
		}
		
		scrollX = scrollY = 0;
	}
	
	inline private function getNewRandomTileType() : Int
	{
		var r : Int = Rand.integer(0, 3);
		var r2 = Math.random();
		var a = TileTypes.DIRT;
		if (r==0 && r2<diamondsSpawnChance) a = TileTypes.DIAMONDS;
		if (r==1 && r2<goldSpawnChance) a = TileTypes.GOLD;
		if (r==2 && r2<rockSpawnChance) a = TileTypes.ROCK;		
		return TileTypes.getRandomTile(a);
	}
	
	public function getScreenSpaceTile(x:Int, y:Int) : Tile
	{	
		x -= scrollTileOffsetX;
		y -= scrollTileOffsetY;
		
		if (x < 0) return null;
		if (y < 0) return null;
		
		if (x >= tilesWide) 
		{
			for (yi in 0...tilesHigh) 
			{				
				for (xi in tilesWide-1...x + 1) 
				{
					tiles[yi].push(new Tile(xi, yi, getNewRandomTileType()));			
				}
			}
			tilesWide = x + 1;
			if (mapResized!=null) mapResized(tilesWide,tilesHigh);
		}
			
		if (y >= tilesHigh) 
		{
			for (yi in tilesHigh-1...y+1)
			{
				tiles.push(new Array<Tile>());
				for (xi in 0...tilesWide)			
				{
					tiles[yi].push(new Tile(xi, yi, getNewRandomTileType()));
				}
			}
			tilesHigh = y + 1;
			if (mapResized!=null) mapResized(tilesWide,tilesHigh);
		}
		
		return tiles[y][x];
	}	
	
	private function set_scrollX(value:Float):Float 
	{
		scrollTileOffsetX = Std.int( -value / TILE_SIZE);
		return scrollX = value;
	}
	
	private function set_scrollY(value:Float):Float 
	{
		scrollTileOffsetY = Std.int(-value / TILE_SIZE);
		return scrollY = value;
	}	
}