if (  can_push_cooldown > 0 ) { fog_white; }
//var ang = image_angle;

if ( sprite_index != shitbox ) {
	//draw_self();
	draw_sprite_ext(
		sprite_index,
		0,
		x,
		y,
		image_xscale,
		image_yscale,
		draw_angle,
		image_blend,
		image_alpha
	);
} else if ( do_draw ) draw_self();

//if ( sprite_index != shitbox ) {
//	draw_sprite_ext( 
//		sprite_index, 0, 
//		x + draw_x_offset, 
//		y + draw_y_offset,
//		image_xscale*0.8,
//		image_yscale*0.8,
//		draw_angle,
//		c_white,//choose_fixed( c_orange, c_yellow, c_white ),
//		RR( 0, 0.6)
//	);
//}

if ( can_push_cooldown > 0 ) { fog_off; }
