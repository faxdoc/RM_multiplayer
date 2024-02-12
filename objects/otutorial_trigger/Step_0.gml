if ( instance_exists(oplayer) && place_meeting(x,y,oplayer) ) {
	var t_ = instance_place(x,y,oplayer);
	do_draw = ( t_.state != e_player.hit && t_.state != 485 && t_.meta_state != e_meta_state.round_start );
		
	
}

//





