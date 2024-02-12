with ( oplayer ) {
	hp = 999;
	hp_max = 999;
	if ( player_id == 1 ) {
		x = clamp( x, 1414, 1750 );
		draw_type = e_draw_type.animation;
		if state != e_player.hit state = 485;
		if meta_state == e_meta_state.round_start {
			x = lerp( 1414, 1750, 0.75);
		}
		sprite_index = ssandbag;
		draw_sandbag = true;
	}
	if ( keyboard_check_pressed(ord("U"))) {
		game_restart();
		rollback_leave_game();
	}
}	











