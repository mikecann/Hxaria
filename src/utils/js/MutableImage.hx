package utils.js;

import Html5Dom;
import js.Lib;
import js.Dom;

/**
 * ...
 * @author 
 */

class MutableImage
{		
	private var image : Image;
	private var data : ImageData;

	public function new() 
	{
		image = cast js.Lib.document.createElement("img");	
		image.onload = onTextureImageLoaded;
	}
	
	public function load(url:String):Void 
	{		
		image.src = "assets/test03_destr.png";
	}
	
	private function onTextureImageLoaded(e):Void 
	{
		var cnvs : HTMLCanvasElement = cast Lib.document.createElement("canvas");
		cnvs.width = image.width;
		cnvs.height = image.height;
		
		var c : CanvasRenderingContext2D = cnvs.getContext("2d");
		c.drawImage(image, 0, 0);
		
		data = c.getImageData(0, 0, image.width, image.height);
	}
	
}