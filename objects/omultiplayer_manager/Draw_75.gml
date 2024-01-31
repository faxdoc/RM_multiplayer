if ( intimer > 10 ) {
	if ( !game_has_started ) {
		if ( !instance_exists(obutton) ) {
		
			ICD(GW*0.25,GH*0.7,0,obutton).image_index = 1;
			ICD(GW*0.5, GH*0.7,0,obutton).image_index = 2;
			ICD(GW*0.75,GH*0.7,0,obutton).image_index = 3;
		
			ICD(GW/2,GH*0.9,0,obutton).image_index = 0;
		}
	
		shader_set(shd_max_a);
		draw_surface( application_surface, 0, 0 );
		shader_reset();
	
		draw_sprite_tiled_ext(spattern,0,intimer*0.2,intimer*0.2,2,2,c_darkest,0.9);
		with ( obutton ) {
			draw_self();
		}
		draw_sprite_ext(stitle,0,GW*0.5,GH*0.35+2, 1.5, 1.5, sin(intimer/60), c_black,  1 );
		draw_sprite_ext(stitle,0,GW*0.5,GH*0.35, 1.5, 1.5,   sin(intimer/60), c_ltgray, 1 );
	
		draw_sprite_ext( scursor, 1, device_mouse_x_to_gui(0),  device_mouse_y_to_gui(0), 2, 2, 0, c_white, 1 );
		draw_sprite_ext( scursor, 0, device_mouse_x_to_gui(0),  device_mouse_y_to_gui(0), 2, 2, 0, c_white, 1 );
	
	}
}


