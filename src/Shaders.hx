package ;

/**
 * ...
 * @author 
 */

class Shaders 
{

	public static function getVS() : String
	{
		return "
		
			uniform float amplitude;
			uniform float tileSize;
			uniform float texTilesWide;
			uniform float texTilesHigh;
			uniform float invTexTilesWide;
			uniform float invTexTilesHigh;
			
			attribute float size;
			attribute vec3 customColor;
			attribute float tileType;

			varying vec3 vColor;
			varying vec2 vTilePos;

			void main() 
			{
				vColor = customColor;
				
				float t = floor(tileType/texTilesWide);
				vTilePos = vec2(tileType-(t*texTilesWide), t); // +(.5/tileSize)
					
				gl_PointSize = size;
				gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
			}
		
		";
	}
	
	public static function getFS() : String
	{
		return "
		
			uniform vec3 color;
			uniform sampler2D texture;
			uniform float invTexTilesWide;
			uniform float invTexTilesHigh;
	
			varying vec3 vColor;
			varying vec2 vTilePos;

			void main()
			{
				vec2 uv = vec2( gl_PointCoord.x*invTexTilesWide + invTexTilesWide*vTilePos.x, gl_PointCoord.y*invTexTilesHigh + invTexTilesHigh*vTilePos.y);	
				
				//vec2 uv = vec2(gl_PointCoord.x,gl_PointCoord.y);	
				
				//gl_FragColor = vec4( color * vColor, 1.0 );
				//gl_FragColor = gl_FragColor * texture2D( texture, uv ); // gl_PointCoord
				
				gl_FragColor = texture2D( texture, uv );
			}
		
		";
	}	
	
}