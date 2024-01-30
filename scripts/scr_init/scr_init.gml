function scr_init(){
	window_set_cursor( cr_none );

	window_set_size( GW * 2, GH * 2 );
	surface_resize( application_surface, GW, GH );
	application_surface_draw_enable( false );
	draw_set_font( fnt_default );
	room_goto( rmenu );
	
}

#macro GW 580
#macro GH 340

