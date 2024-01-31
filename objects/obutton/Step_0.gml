if ( instance_position(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),id) ) {
	image_blend = c_white;
	image_xscale = lerp(image_xscale, 1, 0.2 );
	image_yscale = lerp(image_yscale, 1, 0.2 );
} else {
	image_xscale = lerp(image_xscale,0.8, 0.2 );
	image_yscale = lerp(image_yscale,0.8, 0.2 );
	image_blend = c_gray;
}	

if ( mouse_check_button_pressed(mb_left) ) {
	
	if ( instance_position(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),id) ) {
		//randomize();
		//var rl_ = [rtest,rtower,rflat,rplatform,rceiling,ropen];

		//var rm__ = rl_[ floor(mouse_x + omultiplayer_control_old.intimer ) mod ( array_length(rl_)-1 )];
		switch(image_index) {
			case 0: rollback_create_game( 2, true  ); omultiplayer_manager.game_has_started = true; with ( obutton ) IDD(); rollback_use_random_input(false); break;
			case 1: rollback_create_game( 2, false ); omultiplayer_manager.game_has_started = true; with ( obutton ) IDD(); break;
			case 2: rollback_create_game( 3, false ); omultiplayer_manager.game_has_started = true; with ( obutton ) IDD(); break;
			case 3: rollback_create_game( 4, false ); omultiplayer_manager.game_has_started = true; with ( obutton ) IDD(); break;
			//case 4: rollback_create_game( 4, false );  break;
		}
	}
}



//if ( !instance_exists( orandom ) )  {
	
//}
