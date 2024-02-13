function audio_play_menu_press_small_sound() {
	audio_play_sound( snd_menu_select_small, 0, false, RR( 0.95, 1.10 ), 0, RR( 0.95, 1.10 ) );
	
}

function audio_play_menu_press_big_sound() {
	audio_play_sound( snd_menu_select_main, 0, false, RR( 0.95, 1.10 )*0.8, 0, RR( 0.95, 1.10 ) );
}

function audio_play_menu_sound_hover() {
	audio_play_sound( snd_menu_hover, 0, false, RR( 0.95, 1.10 ) * 0.8, 0, RR( 0.95, 1.10 ) *0.75 );
	
}


