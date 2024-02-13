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
	if  ( instance_position( mx_, my_, id ) && k1p_ ) {
		opreference_tracker.player_anti_flicker[d_] = amount_index;
	}
	get_value = opreference_tracker.player_anti_flicker[d_];// = amount_index;
}


if ( get_value ) {
	image_index = 0;
	//draw_self();
} else {
	image_index = 1;
	//draw_self();
}

