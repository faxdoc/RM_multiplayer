

if ( jump_charge_buffer > 0 ) {
	var cl = choose_fixed(c_orange,c_yellow);
	var llh = jump_charge_buffer/10;
	draw_line_width_color( x-18*draw_xscale, y-llh-16, x-18*draw_xscale, y+llh-16, 3, cl, cl );
}

if ( player_local ) {
	var cursor_col = c_white;
	if (  ( can_hook_delay || hook_air_cancel ) ) {// && (odark_orb.state == e_orb.active || odark_orb.state == e_orb.returning) {
		cursor_col = merge_color( c_dkgray, c_orange, 0.5 );
	}
	if ( RELOAD[ current_weapon ] >  0 ) {
		var pw = RELOAD[ current_weapon ] * 0.15;
		var xoffset_ = -2;
		var yoffset_ = 2;
		var CAMX = 0;
		var CAMY = 0;
		if ( CLIP[ current_weapon ] != 99 ) {
			//DSA( choose_fixed( 0.8, 0.9 ) );
			//draw_text( MX-22-xoffset_, MY+7-yoffset_-6, CLIP[ current_weapon ] );
			DSA( choose_fixed( 0.7, 0.8, 0.9 ) );
			var col = c_dkgray;//current_time mod 50 > 25 ? c_white : c_ltgray;
			draw_line_width_color(MX-10-CAMX-xoffset_-1,MY+12-CAMY-yoffset_+1,MX-10+pw-CAMX-xoffset_-1,MY+12-CAMY-yoffset_+1,5, col, col );
			var col = c_white;
			draw_line_width_color(MX-10-CAMX-xoffset_,MY+12-CAMY-yoffset_,MX-10+pw-CAMX-xoffset_,MY+12-CAMY-yoffset_,5, col, col );
		} else {
			//DSA(choose_fixed(.8,.9,1)*clamp(pw/7,.7,1));
			var col = c_dkgray;//current_time mod 50 > 25 ? c_white : c_darkest;
			draw_line_width_color(MX-pw-CAMX-xoffset_-1,MY+12-CAMY-yoffset_+1,MX+pw-CAMX-xoffset_-1,MY+12-CAMY-yoffset_+1,4, col, col );
			var col = c_white;
			draw_line_width_color(MX-pw-CAMX-xoffset_,MY+12-CAMY-yoffset_,MX+pw-CAMX-xoffset_,MY+12-CAMY-yoffset_,4, col, col );
		}
		DSA( 1 );
	}


	
}



