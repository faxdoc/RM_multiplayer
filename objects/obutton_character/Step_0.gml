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
				audio_play_menu_sound_hover_small();
			}
			hovered = true;
		}
		if ( k1p_ ) {
			audio_play_menu_press_big_sound();
		}
	} else {
		hovered = false;
	}
}

//if ( instance_position(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),id) ) {
//	image_blend = c_white;
//	image_xscale = lerp(image_xscale, 1.03, 0.2 );
//	image_yscale = lerp(image_yscale, 1.03, 0.2 );
//	image_alpha = lerp(image_alpha,1,0.3);
//	y = lerp( y, ystart-3, 0.2 );
	
//} else {
//	hovered = false;
//	image_xscale = lerp(image_xscale,0.99, 0.1 );
//	image_yscale = lerp(image_yscale,0.99, 0.1 );
//	image_blend = c_gray;
//	image_alpha = lerp( image_alpha, 0, 0.2 );
//	y = lerp( y, ystart, 0.1 );
//}	

//if ( mouse_check_button_pressed(mb_left) ) {
	
//if ( !hovered ) {
//	hovered = true;
//	if ( instance_exists(orandom) ) {
//		audio_play_menu_sound_hover();
//	}
//}

//}
