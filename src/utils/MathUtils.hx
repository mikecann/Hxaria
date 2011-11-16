package utils;

/**
 * ...
 * @author MikeCann
 */

class MathUtils 
{

	inline public static var DEG_RAD_RATIO : Float = (Math.PI/180);
	
	inline public static function degToRad(deg:Float) : Float
	{
		return DEG_RAD_RATIO * deg;
	}
	
}