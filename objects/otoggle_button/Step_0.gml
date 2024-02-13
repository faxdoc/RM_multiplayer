var mx_ = 0;
var my_ = 0;
var k1p_ = false;
var d_ = undefined;
with ( oplayer ) {
	if ( player_local ) {
		d_ = player_id;
		mx_ = MX-camera_x;
		my_ = MY-camera_y;
		k1p_ = K1P;
	}
}

if ( d_ != undefined ) {
	if  ( instance_position( mx_, my_, id ) ) {
		
		if (!hovered ) {
			if instance_exists(orandom) {
				audio_play_menu_sound_hover();
			}
			hovered = true;
		}
		if ( k1p_ ) {
			audio_play_menu_press_small_sound();
		}
	} else {
		hovered = false;
	}
	
}
