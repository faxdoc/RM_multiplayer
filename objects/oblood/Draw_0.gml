//draw_red();
//if state == 0 {
//	if !gen_col(x,y+1) {
//		vsp += grav;
//	}
//	var pre_vsp = vsp;
//	//collision
//	if collision {
//		collision_code();
//	} else {
//		x += hsp;
//		y += vsp;
//	}
	
//	//draw
//	angle += spin;

//	draw_red();
//	if gen_col( x, y+1 ) {
//		if ( pre_vsp < 1 ) {
			
//			angle = 0;
//			hsp   = 0;
//			state = 1;
//			x	  = round(x);
//			y	  = round(y);
			
//		} else {
//			vsp = -pre_vsp*(.4+random_fixed(.2));
//			hsp *=  (.4+random_fixed(.2));
//			spin *= (.6+random_fixed(.4));
//			switch(sprite_index) {
//				case sammo:
//				case sammo_red:
//					//if random_fixed(1) > .5 audio_play_sound_pitch_falloff(snd_shell_0, RR( .45, .7 )*.9,.7+random_fixed(.25),0);
//				break;
//				case sammo_alt:
//					//audio_play_sound_pitch_falloff(snd_shell_0, RR( .4, .7 )*1.25*.9,.8+random_fixed(.3),0);
//				break;
//			}
			
//		}
//	}
//} else {
//	draw_red();
//}
//if ( time_delete && !duration-- ) IDD();
