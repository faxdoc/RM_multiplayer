
var dr_ = point_direction( x, y, xprevious, yprevious );
switch( state ) {
	
	#region init/idle
	case e_ameli_orb_state.init: 
		//draw_sprite_ext( sprite_index, 5, target_x, target_y+1, 1, 1, 0, secondary_blend, 1 );
		//draw_sprite_ext( sprite_index, 5, target_x, target_y, 1, 1, 0,   secondary_blend, 1 );
		
	case e_ameli_orb_state.idle:
		
		if ( hitfreeze ) {
			fog_ltgray
			draw_self();
			fog_off
		} else {
			draw_self();
			draw_sprite_ext( sprite_index, 1, x-LDX( 3, dr_ ), y-LDY( 3, dr_ ), 1, 1, 0, secondary_blend, 1 );
		}
		
	
	break;
	#endregion
	
	#region time bomb
	case e_ameli_orb_state.time_bomb: 
		
		var cx_ = x-1;
		var cy_ = y-1;
		DSA(0.7);
		var sz__	= timed_explotion_radius/2;
		var sz_div_ = timer_explotion_duration;
		DSC( merge_colour( main_blend, c_darkest, 0.8 ) );
		draw_circle( cx_, cy_+1, ( attack_timer / sz_div_ )*sz__-1, true );
		draw_circle( cx_, cy_+1, ( attack_timer / sz_div_ )*sz__,   true );
		
		// draw_circle( x, y+1, 32-1, true );
		draw_circle( cx_, cy_+1, sz__, true );
		
		DSC( merge_colour( main_blend, c_darkest, 0.4 ) );
		draw_circle( cx_, cy_, ( attack_timer / sz_div_ )*sz__-1, true );
		draw_circle( cx_, cy_, ( attack_timer / sz_div_ )*sz__,   true );
		
		// draw_circle( x, y, 32-1, true );
		draw_circle( cx_, cy_, sz__, true );
		DSC(c_white);
		DSA(1);
		
		draw_self();
		var dr_ = point_direction(x,y,xprevious,yprevious);
		
		draw_sprite_ext( sprite_index, 2, x, y, 1, 1, attack_timer, secondary_blend, 1 );
		
	break;
	#endregion
	
	#region trap
	case e_ameli_orb_state.trap: 
		if ( init_timer <= 60 ) {
			DSA(0.3);
			DSC( c_orange );
			draw_circle( x, y, spike_trap_size-(init_timer/60)*spike_trap_size-1, true );	
			draw_circle( x, y, spike_trap_size-(init_timer/60)*spike_trap_size, true );
			
			draw_circle( x, y, spike_trap_size-1, true );
			draw_circle( x, y, spike_trap_size, true );
			DSC( c_white );
			DSA(1);
			draw_self();
		} else {
			
			draw_sprite_ext( sameli_trap_spike, 0, x, y, 1, 0.2,   0, secondary_blend, 1 );
			draw_sprite_ext( sameli_trap_spike, 0, x, y, 1, 0.2,  90, secondary_blend, 1 );
			draw_sprite_ext( sameli_trap_spike, 0, x, y, 1, 0.2, 180, secondary_blend, 1 );
			draw_sprite_ext( sameli_trap_spike, 0, x, y, 1, 0.2, 270, secondary_blend, 1 );
			draw_self();
			
			DSA(0.9);
			DSC( c_darkest );
			DSA(0.7);
			draw_circle( x, y+2, spike_trap_size, true );
			
			DSC( c_orange );
			// draw_circle( x, y, 32-1, true );
			draw_circle( x, y+1, spike_trap_size, true );
			draw_circle( x, y, spike_trap_size, true );
			DSC( c_white );
			DSA(1);
		}
	break;
	#endregion
	
	#region trap triggered
	case e_ameli_orb_state.trap_triggered: 
		draw_sprite_ext( sameli_trap_spike, 0, x, y, 1, 1.0,   0, secondary_blend, 1 );
		draw_sprite_ext( sameli_trap_spike, 0, x, y, 1, 1.0,  90, secondary_blend, 1 );
		draw_sprite_ext( sameli_trap_spike, 0, x, y, 1, 1.0, 180, secondary_blend, 1 );
		draw_sprite_ext( sameli_trap_spike, 0, x, y, 1, 1.0, 270, secondary_blend, 1 );
		
		draw_sprite_ext( sameli_trap_spike, 0, x, y, 1, 1.0,   0+45, secondary_blend, 1 );
		draw_sprite_ext( sameli_trap_spike, 0, x, y, 1, 1.0,  90+45, secondary_blend, 1 );
		draw_sprite_ext( sameli_trap_spike, 0, x, y, 1, 1.0, 180+45, secondary_blend, 1 );
		draw_sprite_ext( sameli_trap_spike, 0, x, y, 1, 1.0, 270+45, secondary_blend, 1 );
		draw_self();
		draw_sprite_ext( sprite_index, 4, x, y, 1, 1, attack_timer, secondary_blend, 1 );
	break;
	#endregion
	
	#region bomb
	case e_ameli_orb_state.bomb: 
		// if ( init_timer <= 10 ) {
		// 	init_timer++;
		// } else {
		// 	if ( attack_timer++ < 60 ) {
		// 		bullet_general( 20, 0, shitbox_circle, 0 );
		// 	}
		// 	scr_collision();
		// 	vsp += grav;
		// }
	break;
	#endregion
	
	#region anti_air
	case e_ameli_orb_state.anti_air: 
		// if ( place_meeting( x, y, oplayer ) ) {
		// 	bullet_general( 20, 0, sameli_trap_spear, 0 ).dir -= 15;
		// 	bullet_general( 20, 0, sameli_trap_spear, 0 ).dir += 15;
		// 	bullet_general( 20, 0, sameli_trap_spear, 0 );
		// 	attack_timer = 0;
		// 	state = e_ameli_orb_state.idle;
			
		// }
		
		// draw_sprite_ext( sameli_trap_spear, 0, x, y, 1, 0.8,180, c_gray,  0.76 );
		
		if ( init_timer <= 60 ) {
			draw_sprite_ext( sameli_orb_anti_air, 4, x, y, 1, 1, attack_timer, secondary_blend, 0.8 );
		} else {
			draw_sprite_ext( sameli_trap_spear, 0, x, y, 1, 0.3,  0, main_blend, 0.76 );
			draw_sprite_ext( sameli_trap_spear, 0, x, y, 1, 0.3,-15, main_blend, 0.76 );
			draw_sprite_ext( sameli_trap_spear, 0, x, y, 1, 0.3, 15, main_blend, 0.76 );
			draw_sprite_ext( sprite_index, 4, x, y, 1.6, 1.7, attack_timer, main_blend, 1 );	
		}
		
		
	break;
	#endregion
	#region ani_air trigger
	case e_ameli_orb_state.anti_air_triggered:
	
	break;
	#endregion
	
	#region beam
	case e_ameli_orb_state.beam: 
		// if ( attack_timer++ > 120 ) {
			
		// 	var i   = 0; 
		// 	var dir = 0;
		// 	var x_  = x;
		// 	var y_  = y;
		// 	repeat( 32 ) {
		// 		bullet_general( 10, 0, ssameli_beam, 0 ).duration = 60;
		// 		i++;
		// 		x += LDX( 128, dir );
		// 		y += LDY( 128, dir );
				
		// 	}
			
		// 	x = x_;
		// 	y = y_;
			
		// 	attack_timer = 0;
		// 	state = e_ameli_orb_state.idle;
		// }
		
	
		var drr = dir;//point_direction(x,y,MX,MY);
		var sx_ = x+LDX( 64, drr );
		var sy_ = y+LDY( 64, drr );
		var gun_charge = 3;
		var xx_ = sx_;
		var yy_ = sy_;
		var blend_ = c_aqua;
		var i = 112; while(i-- && !gen_col(x,y)) {
			if( blend_ ){
				DSA( 0.3 );
			} else {
				DSA( 0.2 );
			}
			
			var draw_len_ = 7 + ( gun_charge mod 9 );
			draw_line_width_color(xx_,yy_,xx_+LDX(draw_len_,drr),yy_+LDY(draw_len_,drr),16.1, blend_ ? merge_color(c_white,c_aqua,.9) : c_red, blend_ ? c_aqua : c_orange );
			xx_ += LDX( 7, drr );
			yy_ += LDY( 7, drr );
		}
		DSA(1);
		
		
	break;
	#endregion
	
	
	#region strike
	case e_ameli_orb_state.strike: 
		if ( attack_timer++ > 120 ) {
			
			var i = 0; 
			var dir_ = 0;
			var x_ = x;
			var y_ = y;
			repeat( 32 ) {
				bullet_general( 30, 0, sameli_fist, 0 ).duration = 60;
				i++;
				x += LDX( 16, dir_ );
				y += LDY( 16, dir_ );
				
			}
			x = x_;
			y = y_;
			attack_timer = 0;
			state = e_ameli_orb_state.idle;
			
		}
	break;
	
	#endregion
}


