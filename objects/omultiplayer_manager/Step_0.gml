if ( !game_has_started ) {
	intimer++;
	
	if ( intimer == 60 ) {
		var snd_ = audio_play_sound( snd_music_menu_loop ,0, true, 0 );
		audio_sound_gain( snd_, 0.7, 1600 );
	}
}
