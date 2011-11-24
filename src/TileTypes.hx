package ;
import utils.Rand;

/**
 * ...
 * @author 
 */

class TileTypes 
{
	inline public static var EMPTY : Int = 14;
	inline public static var GOLD = [29,30,31];
	inline public static var ROCK = [45,46,47];
	inline public static var DIAMONDS = [61,62,63];
	inline public static var DIRT = [77,78,79];
	
	inline public static function getRandomTile(from:Array<Int>) : Int
	{
		return from[Rand.integer(0, from.length)];
	}
	
}