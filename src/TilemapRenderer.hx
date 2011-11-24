package ;
import js.Lib;
import three.Color;
import three.Color;
import three.Geometry;
import three.ImageUtils;
import three.MeshShaderMaterial;
import three.MeshShaderMaterial;
import three.ParticleSystem;
import three.Vector3;
import three.Vertex;
import three.WebGLRenderer;

/**
 * ...
 * @author 
 */

class TilemapRenderer 
{
	public static inline var NUM_TILES_WIDE_IN_TEXTURE : Int = 16;
	public static inline var NUM_TILES_HIGH_IN_TEXTURE : Int = 22;
	
	public var game : Game;
	
	private var geometry:Geometry;
	private var material : MeshShaderMaterial;
	private var particlesWide : Int;
	private var particlesHigh : Int;
	private var particles : ParticleSystem;
	
	public function new(game:Game) 
	{
		this.game = game;
		init();
	}
	
	public function init() : Void
	{
		// Create the material
		material = getMaterial();			
		resize(Lib.window.innerWidth, Lib.window.innerHeight);
	}
	
	public function resize(width:Int, height:Int) : Void
	{
		if (particles!=null) game.scene.removeChild(particles);
		
		// Setup the initial geom
		geometry = new Geometry();
		particlesHigh = Std.int(height / Tilemap.TILE_SIZE)+2;
		particlesWide = Std.int(width / Tilemap.TILE_SIZE)+2;
		
		// Create the geometry
		for (yi in 0...particlesHigh) 
		{
			for (xi in 0...particlesWide) 
			{				
				var vector = new Vector3( xi*(Tilemap.TILE_SIZE), -yi*(Tilemap.TILE_SIZE), 0 );
				geometry.vertices.push( new Vertex( vector ) );
			}
		}
		
		// The tile particle system
		particles = new ParticleSystem( geometry, cast [material] );
		particles.sortParticles = false;		
		game.scene.addChild(particles);
		
		// Init the custom tile properites
		var vertices = geometry.vertices;
		for (i in 0...vertices.length)
		{
			material.attributes.size.value[i] = Tilemap.TILE_SIZE;
			material.attributes.customColor.value[i] = new Color( );
			material.attributes.tileType.value[i] = TileTypes.EMPTY;
		}	
	}
	
	private function getMaterial() : MeshShaderMaterial
	{
		// Some custom shader attribs
		var attributes = 
		{
			size: {	type: 'f', value: [] },
			customColor: { type: 'c', value: [] },
			tileType: { type: "f", value: [] },		
		};

		// And uniforms
		var uniforms = 
		{
			amplitude: { type: "f", value: 1.0 },			
			color:     { type: "c", value: new Color( 0xffffff ) },
			texture:   { type: "t", value: 0, texture: ImageUtils.loadTexture( "assets/tilescompressed.png" ) },
			texTilesWide: { type: "f", value: NUM_TILES_WIDE_IN_TEXTURE },	
			texTilesHigh: { type: "f", value: NUM_TILES_HIGH_IN_TEXTURE },	
			invTexTilesWide: { type: "f", value: 1./NUM_TILES_WIDE_IN_TEXTURE },	
			invTexTilesHigh: { type: "f", value: 1./NUM_TILES_HIGH_IN_TEXTURE },
			tileSize: { type: "f", value: Tilemap.TILE_SIZE },
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
	
	public function update() : Void
	{
		// Shortcut
		var sizes : Array<Float> = material.attributes.size.value;
		var colors : Array<Color> = material.attributes.customColor.value;		
		var tileTypes : Array<Float> = material.attributes.tileType.value;		

		
		var tilemap = game.tilemap;
		
		// For each tile
		var i : Int = 0, t:Tile;
		for (yi in 0...particlesHigh) 
		{
			for (xi in 0...particlesWide) 
			{		
				i = (yi * particlesWide) + xi;
					
				t = tilemap.getScreenSpaceTile(xi, yi);
				if (t==null) 
				{
					tileTypes[i] = TileTypes.EMPTY;
				}
				else
				{
					//sizes[i] = 16;
					//colors[i].r = Math.random();
					//colors[i].g = Math.random();
					//colors[i].b = Math.random();
					//tileXs[i] = Math.floor(TILES_W*Math.random());
					//tileYs[i] = Math.floor(TILES_H*Math.random());			
					tileTypes[i] = t.type;
				}
			}
		}

		// Tell three to update them
		//material.attributes.size.needsUpdate = true;
		//material.attributes.customColor.needsUpdate = true;
		material.attributes.tileType.needsUpdate = true;			
	}
	
}