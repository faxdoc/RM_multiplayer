function audio_play_sound_pitch( sound, volume, pitch, priority ) {
	var vol = audio_sound_get_gain(sound) * volume;
	var snd = audio_play_sound(sound,priority,false);
	audio_sound_gain(snd,vol,0);
	audio_sound_pitch(snd,pitch);
	return snd;
}