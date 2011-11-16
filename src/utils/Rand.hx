package utils;

/**
 * ...
 * @author MikeCann
 */

class Rand 
{
	// public methods:
	// random(); // returns a number between 0-1 exclusive.
	inline public static function random():Float 
	{
		return Math.random();
	}
	

	// float(50); // returns a number between 0-50 exclusive
	// float(20,50); // returns a number between 20-50 exclusive
	inline public static function float(min:Float, max:Float):Float 
	{
		return random()*(max-min)+min;
	}
	
	// boolean(); // returns true or false (50% chance of true)
	// boolean(0.8); // returns true or false (80% chance of true)
	inline public static function boolean(chance:Float = 0.5):Bool
	{
		return (random() < chance);
	}
	
	// sign(); // returns 1 or -1 (50% chance of 1)
	// sign(0.8); // returns 1 or -1 (80% chance of 1)
	inline public static function sign(chance:Float = 0.5):Int 
	{
		return (random() < chance) ? 1 : -1;
	}
	
	// bit(); // returns 1 or 0 (50% chance of 1)
	// bit(0.8); // returns 1 or 0 (80% chance of 1)
	inline public static function bit(chance:Float = 0.5):Int 
	{
		return (random() < chance) ? 1 : 0;
	}
	
	// integer(50); // returns an integer between 0-49 inclusive
	// integer(20,50); // returns an integer between 20-49 inclusive
	inline public static function integer(min:Float, max:Float):Int
	{
		// Need to use floor instead of bit shift to work properly with negative values:
		return Math.floor(float(min,max));
	}
	
}