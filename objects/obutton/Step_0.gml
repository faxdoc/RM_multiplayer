if ( !instance_exists(orandom) ) exit;
if ( instance_position(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),id) ) {
	image_blend = c_white;
	image_xscale = lerp(image_xscale, 1, 0.2 );
	image_yscale = lerp(image_yscale, 1, 0.2 );
	image_alpha = lerp(image_alpha,1,0.3);
} else {
	hovered = false;
	image_xscale = lerp(image_xscale,0.8, 0.2 );
	image_yscale = lerp(image_yscale,0.8, 0.2 );
	image_blend = c_gray;
	image_alpha = lerp(image_alpha,0,0.3);
}	

if ( mouse_check_button_pressed(mb_left) ) {
	
	if ( instance_position(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),id) ) {
		
		audio_play_sound_pitch( choose( snd_menu_select_0, snd_menu_select_1), RR(0.95,1.05),  RR(0.95,1.05), 0 );
		IDD(orandom);
		omultiplayer_manager.game_has_started = true; 
		audio_stop_sound( snd_music_menu_loop );
		switch(sprite_index) {
			case s_2playermainmenuactive: rollback_create_game( 2, true  ); break;
			case s_3playermainmenuactive: rollback_create_game( 2, false ); break;
			case s_4playermainmenuactive: rollback_create_game( 3, false ); break;
			case straining:				  rollback_create_game( 4, false ); break;
			//case 4: rollback_create_game( 4, false );  break;
		}
		with ( obutton ) IDD(); 
	}
}



//if ( !instance_exists( orandom ) )  {
	
//}
