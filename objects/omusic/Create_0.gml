state = e_music.no_music_playing;
enum e_music {
	no_music_playing,
	start_music,
	music_looping,
	playing_music,
	stop_music,
	music_stopped,
}

function start_playing_music( id_ = 0 ) {
	if ( state == e_music.no_music_playing ) {
		state = e_music.playing_music;
		if ( room == rtutorial ) {
			state = 300;
			audio_play_sound( snd_music_menu_loop, 999, false );
		} else {
			if ( opreference_tracker.music_on[ id_ ] ) {
				audio_play_sound( snd_music_gameplay_intro, 999, true );
			} else {
				state = 999;
			}
			
		}
	}
	
}


function stop_playing_music() {
	if ( state != e_music.music_stopped ) {
		state = e_music.music_stopped;
		audio_stop_sound( snd_music_gameplay_intro	);
		audio_stop_sound( snd_music_gameplay		);
	}
	//audio_play_sound( snd_music_gameplay, 999, true );
}


