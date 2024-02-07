switch( state ) {
	case e_ameli_orb_state.idle:
		attack_timer = 0;
		idle_timer++;
		init_timer = 0;
		
		if ( init ) {
			init = false;
			if ( parent != undefined ) {
				main_blend		= merge_color( parent.player_colour, c_black, 0.3 );
				secondary_blend = merge_color( main_blend, c_black, 0.5 );
			}
		}
		
		if ( instance_exists( parent ) ) {
			target_x = parent.x+00+sin(idle_timer/44)*42;
			target_y = parent.y-24+cos(idle_timer/ 74)*27;
			//depth = parent.depth + sin(idle_timer/64)*12;
			x = lerp(x,target_x, 0.3 );
			y = lerp(y,target_y, 0.3 );
		}
		start_moving_x = x;
		start_moving_y = y;
		move_timer = 0;
		image_alpha = 1;
	break;
	case e_ameli_orb_state.init:
		attack_timer = 0;
		move_timer++;
		x = lerp( start_moving_x, target_x, move_timer/15 );
		y = lerp( start_moving_y, target_y, move_timer/15 );
		
		// if ( move_timer mod 2 == 0 ) {
		with ( create_fx( 
			x, 
			y,
			sprite_index, 0,
			0,
			depth+1 ) ) {
				image_index = 0;
				type = e_fx.fade;
				alpha_mult = 2;
				duration   = 4;
				image_blend = other.secondary_blend;
		}
		// }
			
		if ( move_timer > 10 ) {
			state = target_state;
		}
		
	break;
	case e_ameli_orb_state.time_bomb: 
		if ( attack_timer++ > timer_explotion_duration ) {
			var b_ = bullet_general( 20, 0, shitbox_circle, 0 );
			b_.image_xscale = timed_explotion_radius/64;
			b_.image_yscale = timed_explotion_radius/64;
			b_.parent = parent;
			b_.ghost = true;
			state = e_ameli_orb_state.idle;
			attack_timer = 0;
			with ( oplayer ) {
				SHAKE += 2;
			}
			repeat(12) {
        		var spd = 4+random_fixed(2);
        		var dir = random_fixed(360);
        		var sz_ = random_fixed(timed_explotion_radius/2);
        		var size_ = choose(1,2,3);
        		var fx = create_fx( x + LDX( sz_,dir) + hsp, y + LDY( sz_,dir) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
        		fx.image_blend = main_blend;
        		fx.image_xscale = size_;
				fx.image_yscale = size_;
				
        	}
        	repeat(4) MAKES(ospark_alt);
        	repeat(3) MAKES(osmoke);		
		}
		
	break;
	case e_ameli_orb_state.trap: 
		if ( init_timer <= 60 ) {
			init_timer++;
			if ( init_timer >= 60 ) {
				repeat(6) {
		        	var spd = 4+random_fixed(2);
		        	var dir = random_fixed(360);
		        	var sz_ = random_fixed(timed_explotion_radius/2);
		        	var size_ = choose(1,2,3);
		        	var fx = create_fx( x + LDX( sz_,dir) + hsp, y + LDY( sz_,dir) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
		        	fx.image_blend = main_blend;
		        	fx.image_xscale = size_;
					fx.image_yscale = size_;
		        }
	        	with ( parent ) SHAKE++;
			}
	        
		} else {
			var lt_ = instance_nearest( x, y, oplayer );
			if ( distance_to_object( lt_ ) <= spike_trap_size*0.95 ) {
				var b_ = bullet_general( 20, 0, shitbox_circle, 0 );
				b_.parent = parent;
				b_.ghost = true;
				b_.image_xscale = spike_trap_size/24;
				b_.image_yscale = spike_trap_size/24;
				
				state = e_ameli_orb_state.trap_triggered;
				attack_timer = 0;
				
			with ( oplayer ) {
				SHAKE += 2;
			}
			repeat(12) {
        		var spd = 4+random_fixed(2);
        		var dir = random_fixed(360);
        		var sz_ = random_fixed(timed_explotion_radius/2);
        		var size_ = choose(1,2,3);
        		var fx = create_fx( x + LDX( sz_,dir) + hsp, y + LDY( sz_,dir) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
        		fx.image_blend = main_blend;
        		fx.image_xscale = size_;
				fx.image_yscale = size_;
				
        	}
        	repeat(4) MAKES(ospark_alt);
        	repeat(3) MAKES(osmoke);
        	
			}
		}
	break;
	case e_ameli_orb_state.trap_triggered:
		if ( triggered_timer++ > 20 ) {
			state = e_ameli_orb_state.idle;
			triggered_timer = 0;
		}
	break;
	case e_ameli_orb_state.bomb: 
		if ( init_timer <= 10 ) {
			init_timer++;
			if ( init_timer == 10 ) {
				
			}
		} else {
			if ( attack_timer++ < 60 ) {
				var b_ = 	bullet_general( 20, 0, shitbox_circle, 0 );
				b_.parent = parent;
				b_.ghost = true;
			}
			scr_collision();
			vsp += grav;
		}
	break;
	case e_ameli_orb_state.anti_air: 
		if (init_timer == 0 ){
			var i = 0; repeat(8) {
				while ( gen_col(x,y) ) {
					y -= 16;
				}
				i++;
			}
		}
		
		image_xscale = 1.25;
		image_yscale = 1.5;
		if ( init_timer <= 60 ) {
			var i = 1; repeat(8) {
				if ( gen_col(x,y+i*12) ) {
					y--;
					break;
				}
				i++;
			}
			init_timer++;
			if ( init_timer >= 60 ) {
				sprite_index = sameli_orb_anti_air;
				repeat(6) {
		        	var spd = 4+random_fixed(2);
		        	var dir = random_fixed(360);
		        	var sz_ = random_fixed(timed_explotion_radius/2);
		        	var size_ = choose(1,2,3);
		        	var fx = create_fx( x + LDX( sz_,dir) + hsp, y + LDY( sz_,dir) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
		        	fx.image_blend = main_blend;
		        	fx.image_xscale = size_;
					fx.image_yscale = size_;
		        }
	        	with ( parent ) SHAKE++;
			}
	        
		} else {
			if ( place_meeting( x, y, oplayer ) ) {
				var b_ = bullet_general( 20, 0, sameli_trap_spear, 0 );
				b_.parent = parent;
				b_.ghost = true;
				b_.dir = 15;
				b_.image_xscale = 3;
				b_.image_yscale = 3;
				b_.image_angle = 15;
				
				var b_ =bullet_general( 20, 0, sameli_trap_spear, 0 );
				b_.parent = parent;
				b_.ghost = true;
				b_.dir  = -15;
				b_.image_xscale = 3;
				b_.image_yscale = 3;
				b_.image_angle = -15;
				
				var b_ =bullet_general( 20, 0, sameli_trap_spear, 0 );		
				b_.parent = parent;
				b_.ghost = true;
				b_.dir = 0;
				b_.image_xscale = 3;
				b_.image_yscale = 3;
				b_.image_angle = 0;
				
				attack_timer = 0;
				state = e_ameli_orb_state.anti_air_triggered;
				sprite_index = sameli_orb;
				
				with ( oplayer ) {
					SHAKE += 2;
				}
				
				repeat(12) {
		        	var spd = 4+random_fixed(2);
		        	var dir = random_fixed(360);
		        	var sz_ = random_fixed(timed_explotion_radius/2);
		        	var size_ = choose(1,2,3);
		        	var fx = create_fx( x + LDX( sz_,dir) + hsp, y + LDY( sz_,dir) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
		        	fx.image_blend = main_blend;
		        	fx.image_xscale = size_;
					fx.image_yscale = size_;
					
		        }
		        repeat(4) MAKES(ospark_alt);
		        repeat(3) MAKES(osmoke);
		        
			}
		}
		
        	
	break;
	
	case e_ameli_orb_state.anti_air_triggered:
		if ( triggered_timer++ > 20 ) {
			state = e_ameli_orb_state.idle;
			triggered_timer = 0;
		}
		sprite_index = sameli_orb;
		image_xscale = 1;
		image_yscale = 1;
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

