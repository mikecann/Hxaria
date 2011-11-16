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
	public static inline var TILE_SIZE : Int = 8;
	
	private var width : Int;
	private var height : Int;
	private var renderer : WebGLRenderer;
	private var container : Dynamic;
	private var camera:Camera;
	private var scene:Scene;
	private var geometry:Geometry;
	private var mouseX : Float;
	private var mouseY : Float;
	private var material : MeshShaderMaterial;
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
		camera.projectionMatrix = Matrix4.makeOrtho( Lib.window.innerWidth / - 2, Lib.window.innerWidth / 2, Lib.window.innerHeight / 2, Lib.window.innerHeight / - 2, -10, 10 );
		
		// Create scene
		scene = new Scene();		
		
		// Setup the initial geom
		geometry = new Geometry();
		for (yi in 0...200) 
		{
			for (xi in 0...200) 
			{				
				var vector = new Vector3( xi*(TILE_SIZE+1), yi*(TILE_SIZE+1), 0 );
				geometry.vertices.push( new Vertex( vector ) );
			}
		}

		// Create the material
		material = getMaterial();		
		
		// The tile particle system
		var particles = new ParticleSystem( geometry, cast [material] );
		particles.sortParticles = false;		
		scene.addChild(particles);
		
		// Init the custom tile properites
		var vertices = geometry.vertices;
		for (i in 0...vertices.length)
		{
			material.attributes.size.value[i] = TILE_SIZE;
			
			var c = new Color( );
			c.r = Math.random();
			c.g = Math.random();
			c.b = Math.random();
			material.attributes.customColor.value[i] = c;
		}
				
		// Create renderer
		renderer = new WebGLRenderer( { clearAlpha: 1 } );
		renderer.setSize( width, height );
		renderer.sortObjects = false;
		renderer.setClearColorHex(0xabcdef, 1);
		container.appendChild(renderer.domElement);	
		
		// Listen for resizing
		new JQuery(cast Lib.window).resize(onResize);		
		new JQuery(Lib.document).mousemove(onDocumentMouseMove);			
		new JQuery(Lib.document).mousedown(function(e) { isMouseDown = true; } );			
		new JQuery(Lib.document).mouseup(function(e) { isMouseDown = false; } );			
	}	
	
	private function getMaterial() : MeshShaderMaterial
	{
		// Some custom shader attribs
		var attributes = 
		{
			size: {	type: 'f', value: [] },
			customColor: { type: 'c', value: [] }
		};

		// And uniforms
		var uniforms = 
		{

			amplitude: { type: "f", value: 1.0 },
			color:     { type: "c", value: new Color( 0xffffff ) },
			texture:   { type: "t", value: 0, texture: ImageUtils.loadTexture( "assets/blank.png" ) },

		};

		// Our material
		return new MeshShaderMaterial( 
		{ 
			uniforms:uniforms, 
			attributes:attributes, 
			vertexShader:Shaders.getVS(), 
			fragmentShader: Shaders.getFS(), 
			depthTest:false, 
			transparent:true 
		} );
	}	
	
	private function onResize(e):Void 
	{
		width = Lib.window.innerWidth;
		height = Lib.window.innerHeight;
		camera.aspect = width / height;
		camera.updateProjectionMatrix();
		renderer.setSize( width, height );
		trace("canvas resize: "+width + ", " + height);
	}
	
	private function onDocumentMouseMove(e:JqEvent) 
	{
		// Pan around with the mouse
		if (isMouseDown)
		{
			camera.translateX(lastMouseX-e.pageX);
			camera.translateY(e.pageY-lastMouseY);			
		}
		lastMouseX = e.pageX; 
		lastMouseY = e.pageY;
	}
	
	private function render():Void 
	{		
		RequestAnimationFrame.request (render);
		
		// Shortcut
		var sizes : Array<Float> = material.attributes.size.value;
		var colors : Array<Color> = material.attributes.customColor.value;		
		
		// For each tile
		for (i in 0...sizes.length) 
		{
			sizes[i] = 6 + Math.random() * 2;
			colors[i].r = Math.random();
			colors[i].g = Math.random();
			colors[i].b = Math.random();
		}

		// Tell three to update them
		material.attributes.size.needsUpdate = true;
		material.attributes.customColor.needsUpdate = true;
		
		// Finally render
		renderer.render(scene, camera, null);
	}
	
}