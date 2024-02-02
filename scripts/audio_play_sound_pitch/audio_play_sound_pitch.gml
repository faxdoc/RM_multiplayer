function audio_play_sound_pitch( sound, volume, pitch, priority, falloff_mult = 1 ) {
	var x_ = x, y_ = y+22;
	with ( oplayer ) {
		if ( player_local ) {
			var vol = audio_sound_get_gain(sound) * volume;
			var snd = audio_play_sound(sound,priority,false);
			var ds_ = lerp(1,clamp(1.2-point_distance(x_,y_,x,y)/310,0.1,1),falloff_mult);
			audio_sound_gain(snd,vol*ds_,0);
			audio_sound_pitch(snd,pitch);
		}
	}
	
	//if ( object_index == oplayer ) {
	//	var x_ = x, y_ = y+22;
	//	//if ( player_local ) {
	//	with ( oplayer ) {
	//		if ( player_local ) {
	//			var vol = audio_sound_get_gain(sound) * volume;
	//			var snd = audio_play_sound(sound,priority,false);
	//			var ds_ = clamp(1.2-point_distance(x_,y_,x,y)/310,0.1,1);
	//			audio_sound_gain(snd,vol*ds_,0);
	//			audio_sound_pitch(snd,pitch);
	//		}
	//	}
	//	//}
			
			
	//	//	var ld_ = id;
	//	//	var x_ = x, y_ = y;
	//	//	with ( oplayer ) {
	//	//		if ( player_local && id != ld_ ) {
	//	//			var snd_2 = audio_play_sound(sound,priority,false);
	//	//			var ds_ = clamp(1.3-point_distance(x_,y_,x,y)/300,0.1,1);
	//	//			audio_sound_gain(snd_2,vol*ds_,0);
	//	//			audio_sound_pitch(snd_2,pitch);
	//	//		}
	//	//	 }
			
	//	//	return snd;
	//	//} else {
	//	//	return noone;
	//	//}
		
		
	//} else {
	//	var vol = audio_sound_get_gain(sound) * volume;
	//	var snd = audio_play_sound(sound,priority,false);
	//	audio_sound_gain(snd,vol,0);
	//	audio_sound_pitch(snd,pitch);
	//	return snd;
	//}
}