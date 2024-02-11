var controller = undefined;
with ( oplayer ) {
	if ( first_looser == id ) {
		if ( priority_select_timer > 0 ) {
			priority_select_timer -= 1/9;
			controller = id;
		}
	}
}


if ( controller != undefined ) {
	var mx_ = controller.MX-controller.camera_x;
	var my_ = controller.MY-controller.camera_y;
	var k1p = controller.K1P;
	
	if ( instance_position(mx_,my_,id) ) {
		if ( !hovered ) {
			hovered = true;
			audio_play_sound_pitch(snd_menu_hover, random_fixed(0.9), RR(0.9,1.05),0);
		}
	
		image_blend = c_white;
		image_xscale = lerp(image_xscale, 1, 0.2 );
		image_yscale = lerp(image_yscale, 1, 0.2 );
		
		var st_ = "";
		switch(image_index) {
			case 0: st_ = "Arena";				break;
			case 1: st_ = "Twr";				break;
			case 2: st_ = "Ceiling";			break;
			case 3: st_ = "Inital Sendoff";		break;
			case 4: st_ = "Friendship Area";	break;
			case 5: st_ = "Floating Islands";	break;
			case 6: st_ = "Dilapidated Bridge"; break;
			case 7: st_ = "Vines";				break;
			case 8: st_ = "City Ruins";			break;
			case 9: st_ = "Cup";				break;
			case 10: st_ = "Hill";				break;
		}
		
		if ( st_ != "" ) {
			global.display_room_name = st_;
		}
	} else {
		hovered = false;
		image_xscale = lerp(image_xscale,0.7, 0.2 );
		image_yscale = lerp(image_yscale,0.7, 0.2 );
		image_blend  = c_gray;
	}

	if (k1p ) {
	
		if ( instance_position(mx_,my_,id) ) {
			//randomize();
			var rl_ = [rtest,rtower,rceiling,rflat,rplatform,ropen,rbridge,rempty,rcity,rcup,rhill];
			audio_play_sound_pitch( choose( snd_menu_select_0, snd_menu_select_1), RR(0.95,1.05),  RR(0.95,1.05), 0 );
			var rm__ = rl_[ image_index ];
			switch(image_index) {
				default: room_goto(rm__); break;
			}
		}
	}
} else {
	var do_hover_ = false;
	with ( oplayer ) {
		var mx_ = MX-camera_x;
		var my_ = MY-camera_y;
		var k1p = K1P;
		
		
		with ( other ) {
			if ( instance_position(mx_,my_,id) ) {
				do_hover_ = true;
			}

			if (k1p ) {
	
				if ( instance_position(mx_,my_,id) ) {
					//randomize();
					var rl_ = [rtest,rtower,rceiling,rflat,rplatform,ropen,rbridge,rempty,rcity,rcup,rhill];
					audio_play_sound_pitch( choose( snd_menu_select_0, snd_menu_select_1), RR(0.95,1.05),  RR(0.95,1.05), 0 );
					var rm__ = rl_[ image_index ];
					switch(image_index) {
						default: room_goto(rm__); global.inital_select = true; break;
					}
				}
			}
		}
		
			
	}
	
	if ( do_hover_ ) {
		if ( !hovered ) {
			hovered = true;
			audio_play_sound_pitch(snd_menu_hover, random_fixed(0.9), RR(0.9,1.05),0);
		}
		
		image_blend = c_white;
		image_xscale = lerp(image_xscale, 1, 0.2 );
		image_yscale = lerp(image_yscale, 1, 0.2 );
		var st_ = "";
		switch(image_index) {
			case 0: st_ = "Arena";				break;
			case 1: st_ = "Twr";				break;
			case 2: st_ = "Ceiling";			break;
			case 3: st_ = "Inital Sendoff";		break;
			case 4: st_ = "Friendship Area";	break;
			case 5: st_ = "Floating islands";	break;
			case 6: st_ = "Dilapidated Bridge"; break;
			case 7: st_ = "Vines";				break;
			case 8: st_ = "City ruins";			break;
		}
		
		if ( st_ != "" ) {
			global.display_room_name = st_;
		}
		
	} else {
		hovered = false;
		image_xscale = lerp(image_xscale,0.7, 0.2 );
		image_yscale = lerp(image_yscale,0.7, 0.2 );
		image_blend = c_gray;
	}
			
}


