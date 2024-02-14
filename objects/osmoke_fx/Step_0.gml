if!duration--IDD();
spd *= frc;
x += LDX( spd, dir );
y += LDY( spd, dir );
image_angle += spin;
spin *= spn_frc;
if ( do_size ) {
	var sz =  min(size,duration/30);
	image_xscale = sz;
	image_yscale = sz;
} else {
	var sz =  min( 1, duration / 5 );
	image_xscale = sz * size_mult;
	image_yscale = sz * size_mult;
	dir  = angle_approach( dir, 270 + wave( -20, 20, 3, offset ), 2 );
	//image_angle = clamp( dir, 260, 280 );
	spin = 0;
	spd = max( 0.2, spd );
}