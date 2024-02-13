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
		opreference_tracker.player_rollback_amount[d_] = amount_index;
		rollback_define_input_frame_delay(amount_index);
	}

	get_value = opreference_tracker.player_rollback_amount[d_];// = amount_index;
}
if ( amount_index == -1 ) {
	mask_index = srollback_adaptive;
}
