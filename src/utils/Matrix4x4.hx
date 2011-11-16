package utils;

/**
 * ...
 * @author MikeCann
 */

import Html5Dom;
 
class Matrix4x4 
{
	// Publics
	public var a : Float32Array;
	
	public function new(?inpA:Float32Array) 
	{
		a = inpA==null?new Float32Array(16):inpA;
	}
	
	public static function identity() : Matrix4x4
	{
		var a : Float32Array = new Float32Array(16);
		
		a[ 0] = 1;
		a[ 1] = 0;
		a[ 2] = 0;
		a[ 3] = 0;
		a[ 4] = 0;
		a[ 5] = 1;
		a[ 6] = 0;
		a[ 7] = 0;
		a[ 8] = 0;
		a[ 9] = 0;
		a[10] = 1;
		a[11] = 0;
		a[12] = 0;
		a[13] = 0;
		a[14] = 0;
		a[15] = 1;
		
		return new Matrix4x4(a);
	}
	
	public static function ortho(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float) : Matrix4x4
	{
		var a : Float32Array = new Float32Array(16);
		
		a[0]  = 2 / (right - left);
		a[1]  = 0;
		a[2]  = 0;
		a[3]  = 0;

		a[4]  = 0;
		a[5]  = 2 / (top - bottom);
		a[6]  = 0;
		a[7]  = 0;

		a[8]  = 0;
		a[9]  = 0;
		a[10] = -1 / (far - near);
		a[11] = 0;

		a[12] = (right + left) / (left - right);
		a[13] = (top + bottom) / (bottom - top);
		a[14] = -near / (near - far);
		a[15] = 1;

		return new Matrix4x4(a);
	}
}