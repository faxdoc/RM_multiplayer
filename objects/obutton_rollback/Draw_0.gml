if ( amount_index == -1 ) {
	if ( get_value == amount_index ) {
		draw_sprite_ext( srollback_number_frame_wide,	0,					x, y, 1, 1, 0, merge_colour(c_orange,c_gray,0.2), 1 );
		draw_sprite_ext( srollback_adaptive,				amount_index,	x, y+1, 1, 1, 0, c_black,  0.3 );
		draw_sprite_ext( srollback_adaptive,				amount_index,	x, y, 1, 1, 0, c_yellow,  1 );
	} else {
		draw_sprite_ext( srollback_number_frame_wide,	0,					x, y, 1, 1, 0, c_dkgray, 1 );
		draw_sprite_ext( srollback_adaptive,				amount_index,	x, y+1, 1, 1, 0, c_black,  0.3 );
		draw_sprite_ext( srollback_adaptive,				amount_index,	x, y, 1, 1, 0, c_ltgray,	1 );
	}
} else {
	if ( get_value == amount_index ) {
		draw_sprite_ext( srollback_number_frame,	0,							x, y, 1, 1, 0, merge_colour(c_orange,c_gray,0.2), 1 );
	draw_sprite_ext( srollback_numbers,				amount_index,	x, y+1, 1, 1, 0, c_black,  0.3 );
	draw_sprite_ext( srollback_numbers,				amount_index,	x, y, 1, 1, 0, c_yellow,  1 );
	} else {
		draw_sprite_ext( srollback_number_frame,	0,							x, y, 1, 1, 0, c_dkgray, 1 );
		draw_sprite_ext( srollback_numbers,				amount_index,	x, y+1, 1, 1, 0, c_black,  0.3 );
		draw_sprite_ext( srollback_numbers,				amount_index,	x, y, 1, 1, 0, c_ltgray,		1 );
	}
}


