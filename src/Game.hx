package ;
import js.JQuery;
import js.Lib;
import three.Camera;
import three.Color;
import three.Color;
import three.Color;
import three.FogExp2;
import three.Geometry;
import three.ImageUtils;
import three.Line;
import three.LineBasicMaterial;
import three.Material;
import three.Matrix4;
import three.Matrix4;
import three.Mesh;
import three.MeshShaderMaterial;
import three.ParticleBasicMaterial;
import three.ParticleSystem;
import three.ParticleSystem;
import three.PerspectiveCamera;
import three.Scene;
import three.Scene;
import three.Texture;
import three.Vector2;
import three.Vector3;
import three.Vertex;
import three.WebGLRenderer;
import utils.RequestAnimationFrame;

/**
 * ...
 * @author 
 */

class Game 
{	
	private var width : Int;
	private var height : Int;
	private var renderer : WebGLRenderer;
	private var container : Dynamic;
	private var camera:Camera;
	
	public var scene:Scene;	
	public var tilemap : Tilemap;
	public var tilemapRenderer : TilemapRenderer;
	
	private var mouseX : Float;
	private var mouseY : Float;	
	private var isMouseDown : Bool;
	private var lastMouseX : Int;
	private var lastMouseY : Int;
	
	public function new() 
	{
		width = Lib.window.innerWidth;
		height = Lib.window.innerHeight;	
		isMouseDown = false;
		
		init();

		render();
	}
	
	private function init() : Void
	{				
		// Create the container and listen for resizes
		container = cast Lib.document.createElement('div');
		Lib.document.body.appendChild( container );		
		
		// Camera
		camera = new Camera();
		camera.projectionMatrix = Matrix4.makeOrtho(width / - 2, width / 2, height / 2, height / - 2, -10, 10 );
		camera.translateX(width>>1);
		camera.translateY(-height>>1);
		
		// Create scene
		scene = new Scene();		
		
		// Create renderer
		renderer = new WebGLRenderer( { clearAlpha: 1 } );
		renderer.setSize( width, height );
		renderer.sortObjects = false;
		renderer.setClearColorHex(0xabcdef, 1);
		container.appendChild(renderer.domElement);
		
		// Create the tilemap and its renderer
		tilemap = new Tilemap(this);
		tilemapRenderer = new TilemapRenderer(this);
		
		// Listen for resizing
		new JQuery(cast Lib.window).resize(onResize);		
		new JQuery(Lib.document).mousemove(onDocumentMouseMove);			
		new JQuery(Lib.document).mousedown(function(e) { isMouseDown = true; } );			
		new JQuery(Lib.document).mouseup(function(e) { isMouseDown = false; } );			
	}		
	
	private function onResize(e):Void 
	{
		if (!container) return;
		
		width = Lib.window.innerWidth;
		height = Lib.window.innerHeight;		
		
		renderer.setSize( width, height );
		tilemapRenderer.resize(width, height);
		
		camera = new Camera();
		camera.projectionMatrix = Matrix4.makeOrtho(width / - 2, width / 2, height / 2, height / - 2, -10, 10 );
		camera.translateX(width>>1);
		camera.translateY(-height>>1);
	}
	
	private function onDocumentMouseMove(e:JqEvent) 
	{
		// Pan around with the mouse
		if (isMouseDown)
		{
			//camera.translateX(lastMouseX-e.pageX);
			//camera.translateY(e.pageY-lastMouseY);		
			tilemap.scrollX += lastMouseX - e.pageX;
			tilemap.scrollY += lastMouseY - e.pageY;
		}
		lastMouseX = e.pageX; 
		lastMouseY = e.pageY;
	}
	
	private function render():Void 
	{		
		// Get next frame
		RequestAnimationFrame.request (render);
		
		// Update the bits and bobs
		tilemapRenderer.update();
		
		// Finally render
		renderer.render(scene, camera, null);
	}
	
}