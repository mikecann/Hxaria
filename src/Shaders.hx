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
			attribute float size;
			attribute vec3 customColor;

			varying vec3 vColor;

			void main() {

				vColor = customColor;

				vec4 mvPosition = modelViewMatrix * vec4( position, 1.0 );

				gl_PointSize = size;
				//gl_PointSize = size * ( 300.0 / length( mvPosition.xyz ) );

				gl_Position = projectionMatrix * mvPosition;

			}
		
		";
	}
	
	public static function getFS() : String
	{
		return "
		
			uniform vec3 color;
			uniform sampler2D texture;

			varying vec3 vColor;

			void main() {

				gl_FragColor = vec4( color * vColor, 1.0 );
				//gl_FragColor = gl_FragColor * texture2D( texture, gl_PointCoord );

			}
		
		";
	}	
	
}