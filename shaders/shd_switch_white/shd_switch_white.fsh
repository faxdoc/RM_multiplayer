//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec4 new_col;

void main() {
	vec4 col = texture2D( gm_BaseTexture, v_vTexcoord );
	if ( col.gb == vec2(1.) ) {
		col.rgb = new_col.rgb*col.r;
	}
    gl_FragColor = v_vColour * col;
}
