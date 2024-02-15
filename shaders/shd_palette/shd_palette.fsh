varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//uniform float col_num;
//uniform float pal_num;
uniform float pal_index;

uniform sampler2D palette;

uniform vec4 palette_uvs;

#define palette_left palette_uvs[0]
#define palette_top palette_uvs[1]
#define palette_width palette_uvs[2]
#define palette_vlen palette_uvs[3]

//#define col_num 30.0 
#define pal_num 5.0 

void main() {
	vec4 basecol = texture2D( gm_BaseTexture, v_vTexcoord );
	
	float newpos;
	for( float i = 0.; i < 31.; i += 1. ) {
		newpos =  palette_top+(i/31.0)*palette_vlen;
		vec4 test_col = texture2D( palette, vec2( palette_left, newpos ) );
		if ( basecol == test_col ) {
			basecol.rgb = texture2D(  palette, vec2( palette_left+((pal_index+1.)/pal_num)*palette_width, newpos ) ).rgb;
		}
	}
	
    gl_FragColor = v_vColour * basecol;
}