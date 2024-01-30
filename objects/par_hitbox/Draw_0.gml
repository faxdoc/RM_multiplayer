//if ( draw_delay ) {
//	draw_delay = false;
//	exit;
//}

if ( do_hitfreeze ) {
	if ( hitfreeze > 0 ) { fog_white; }
	//var ang = image_angle;
	//image_angle = draw_angle;
	if ( sprite_index != shitbox ) {
		//x += draw_x_offset;
		//y += draw_y_offset;
		draw_self();
		//x -= draw_x_offset;
		//y -= draw_y_offset;
	} else if ( do_draw ) draw_self();
	
	if ( extra_sprite != undefined ) {
		draw_sprite_ext( 
			extra_sprite, 0, 
			x + draw_x_offset, 
			y + draw_y_offset,
			image_xscale*0.8,
			image_yscale*0.8,
			draw_angle,
			choose_fixed( c_orange, c_yellow, c_white ),
			RR( 0, 0.6)
		);
	}
	
	if ( hitfreeze > 0 ) { fog_off; }
} else {
	//var ang = image_angle;
	//image_angle = draw_angle;
	if ( sprite_index != shitbox ) {
		draw_self();
	} else if( do_draw) draw_self();
	//image_angle = ang;
	if ( extra_sprite != undefined ) {
		draw_sprite_ext( 
			extra_sprite, 0,
			x, y,
			image_xscale*0.8,
			image_yscale*0.8,
			draw_angle,
			choose_fixed( c_orange, c_yellow, c_white ),
			RR(  0, 0.6 ) );
	}
}
