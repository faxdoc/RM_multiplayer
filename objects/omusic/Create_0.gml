state = e_music.no_music_playing;
enum e_music {
	no_music_playing,
	start_music,
	playing_music,
	stop_music,
	music_stopped,
}

function start_playing_music() {
	if ( state == e_music.no_music_playing ) {
		state = e_music.playing_music;
		audio_play_sound( snd_music_gameplay, 999, true );
	}
}


function stop_playing_music() {
	if ( state == e_music.playing_music ) {
		state = e_music.music_stopped;
		audio_stop_sound(snd_music_gameplay);//audio_play_sound( snd_music_gameplay, 999, true );
	}
}


