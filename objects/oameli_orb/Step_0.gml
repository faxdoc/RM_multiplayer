switch( state ) {
	case e_ameli_orb_state.idle:
		attack_timer = 0;
		idle_timer++;
		
		if ( init ) {
			init = false;
			if ( parent != undefined ) {
				main_blend = parent.player_colour;
				secondary_blend = merge_color( main_blend, c_darkest, 0.5 );
			}
		}
		
		if ( instance_exists( parent ) ) {
			target_x = parent.x+00+sin(idle_timer/64)*12;
			target_y = parent.y-22+cos(idle_timer/174)*7;
			image_alpha = parent.depth + sin(idle_timer/64)*12;
		}
		start_moving_x = x;
		start_moving_y = y;
		move_timer = 0;
		
	break;
	case e_ameli_orb_state.init:
		attack_timer = 0;
		move_timer++;
		x = lerp( start_moving_x, target_x, move_timer/30 );
		y = lerp( start_moving_y, target_y, move_timer/30 );
		
		if ( move_timer > 30 ) {
			state = target_state;
		}
		
	break;
	case e_ameli_orb_state.time_bomb: 
		if ( attack_timer++ > 120 ) {
			bullet_general( 20, 0, shitbox_circle, 0 );
			state = e_ameli_orb_state.idle;
			attack_timer = 0;
			
		}
		
	break;
	case e_ameli_orb_state.trap: 
		if ( init_timer <= 30 ) {
			init_timer++;
		} else {
			if ( point_distance( x, y, oplayer.x,oplayer.y) <= 32 ) {
				bullet_general( 20, 0, shitbox_circle, 0 );
				state = e_ameli_orb_state.idle;
				attack_timer = 0;
				
			}
		}
	break;
	case e_ameli_orb_state.bomb: 
		if ( init_timer <= 10 ) {
			init_timer++;
		} else {
			if ( attack_timer++ < 60 ) {
				bullet_general( 20, 0, shitbox_circle, 0 );
			}
			scr_collision();
			vsp += grav;
		}
	break;
	case e_ameli_orb_state.anti_air: 
		if ( place_meeting( x, y, oplayer ) ) {
			bullet_general( 20, 0, sameli_trap_spear, 0 ).dir -= 15;
			bullet_general( 20, 0, sameli_trap_spear, 0 ).dir += 15;
			bullet_general( 20, 0, sameli_trap_spear, 0 );
			attack_timer = 0;
			state = e_ameli_orb_state.idle;
			
		}
		
	break;
	case e_ameli_orb_state.beam: 
		if ( attack_timer++ > 120 ) {
			
			var i = 0; 
			var dir = 0;
			var x_ = x;
			var y_ = y;
			repeat( 32 ) {
				bullet_general( 10, 0, ssameli_beam, 0 ).duration = 60;
				i++;
				x += LDX( 128, dir );
				y += LDY( 128, dir );
				
			}
			
			x = x_;
			y = y_;
			
			attack_timer = 0;
			state = e_ameli_orb_state.idle;
		}
		
	break;
	case e_ameli_orb_state.strike: 
		if ( attack_timer++ > 120 ) {
			
			var i = 0; 
			var dir = 0;
			var x_ = x;
			var y_ = y;
			repeat( 32 ) {
				bullet_general( 30, 0, sameli_fist, 0 ).duration = 60;
				i++;
				x += LDX( 16, dir );
				y += LDY( 16, dir );
				
			}
			x = x_;
			y = y_;
			attack_timer = 0;
			state = e_ameli_orb_state.idle;
			
		}
		
		
	break;
}

image_blend = main_blend;

