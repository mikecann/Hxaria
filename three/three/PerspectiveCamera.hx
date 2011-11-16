package three;

/**
 * ...
 * @author 
 */

extern class PerspectiveCamera extends Camera
{
	public function new(fov:Float, aspect:Float, near:Float, far:Float) : Void;
	override public function updateProjectionMatrix() : Void;
}