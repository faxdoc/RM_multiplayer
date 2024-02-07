switch( state ) {
	case e_ameli_orb_state.idle:
		attack_timer = 0;
		
	break;
	case e_ameli_orb_state.init:
		attack_timer = 0;
		
	break;
	case e_ameli_orb_state.time_bomb: 
		if ( attack_timer++ > 120 ) {
			bullet_general( 20, 0, shitbox_circle, 0 );
			attack_timer = 0;
			state = e_ameli_orb_state.idle;
		}
		
	break;
	case e_ameli_orb_state.trap: 
		if ( init_timer <= 30 ) {
			init_timer++;
		} else {
			if ( point_distance( x, y, oplayer.x,oplayer.y) <= 32 ) {
				bullet_general( 20, 0, shitbox_circle, 0 );
				attack_timer = 0;
				state = e_ameli_orb_state.idle;
			}
		}
	break;
	case e_ameli_orb_state.bomb: 
	
	break;
	case e_ameli_orb_state.anti_air: 
	
	break;
	case e_ameli_orb_state.beam: 
	
	break;
	case e_ameli_orb_state.strike: 
	
	break;
}