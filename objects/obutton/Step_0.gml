if ( !instance_exists(orandom) ) exit;
if ( instance_position(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),id) ) {
	//if ( !hovered ) {
	//	hovered = true;
	//	audio_play_sound_pitch(snd_menu_hover, random_fixed(0.9), RR(0.9,1.05),0);
	//}
	image_blend = c_white;
	image_xscale = lerp(image_xscale, 1, 0.2 );
	image_yscale = lerp(image_yscale, 1, 0.2 );
} else {
	hovered = false;
	image_xscale = lerp(image_xscale,0.8, 0.2 );
	image_yscale = lerp(image_yscale,0.8, 0.2 );
	image_blend = c_gray;
}	

if ( mouse_check_button_pressed(mb_left) ) {
	
	if ( instance_position(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),id) ) {
		//randomize();
		//var rl_ = [rtest,rtower,rflat,rplatform,rceiling,ropen];

		//var rm__ = rl_[ floor(mouse_x + omultiplayer_control_old.intimer ) mod ( array_length(rl_)-1 )];
		//if audio_is_playing(global.music) audio_stop_sound(global.music);
		
		audio_play_sound_pitch( choose( snd_menu_select_0, snd_menu_select_1), RR(0.95,1.05),  RR(0.95,1.05), 0 );
		IDD(orandom);
		omultiplayer_manager.game_has_started = true; 
		audio_stop_sound( snd_music_menu_loop );
		switch(image_index) {
			case 0: rollback_create_game( 2, true  ); break;
			case 1: rollback_create_game( 2, false ); break;
			case 2: rollback_create_game( 3, false ); break;
			case 3: rollback_create_game( 4, false ); break;
			//case 4: rollback_create_game( 4, false );  break;
		}
		with ( obutton ) IDD(); 
	}
}



//if ( !instance_exists( orandom ) )  {
	
//}
