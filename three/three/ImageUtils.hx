package three;

/**
 * ...
 * @author 
 */

extern class ImageUtils 
{
	public static function getNormalMap(image:Dynamic, depth:Float) : Dynamic;
	public static function loadTextureCube(array:Array<String>, ?mapping:Dynamic, ?cb:Dynamic->Void) : Texture;
	public static function loadTexture(path:String, ?mapping:Dynamic, ?cb:Dynamic->Void) : Texture;
}