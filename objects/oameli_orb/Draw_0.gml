

switch( state ) {
	case e_ameli_orb_state.init: break;
	case e_ameli_orb_state.time_bomb: 
	
		
		DSC(c_red);
		draw_circle( x, y, (attack_timer/120)*32-1, true );
		draw_circle( x, y, (attack_timer/120)*32,   true );
		
		draw_circle( x, y, 32-1, true );
		draw_circle( x, y, 32, true );
		DSC(c_white);
	break;
	case e_ameli_orb_state.trap: 
		if ( init_timer <= 30 ) {
			
		} else {
			DSC( c_olive );
			draw_circle( x, y, 32, true );
			DSC( c_white );
		}
	break;
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
	case e_ameli_orb_state.anti_air: 
		// if ( place_meeting( x, y, oplayer ) ) {
		// 	bullet_general( 20, 0, sameli_trap_spear, 0 ).dir -= 15;
		// 	bullet_general( 20, 0, sameli_trap_spear, 0 ).dir += 15;
		// 	bullet_general( 20, 0, sameli_trap_spear, 0 );
		// 	attack_timer = 0;
		// 	state = e_ameli_orb_state.idle;
			
		// }
		draw_sprite_ext( sameli_trap_spear, 0, x, y, 1, 1,  0, c_orange, 0.76 );
		draw_sprite_ext( sameli_trap_spear, 0, x, y, 1, 1,-15, c_orange, 0.76 );
		draw_sprite_ext( sameli_trap_spear, 0, x, y, 1, 1, 15, c_orange, 0.76 );
		
	break;
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

draw_self();
var dr_ = point_direction(x,y,xprevious,yprevious);
draw_sprite_ext( sprite_index, 1, x+LDX( 3, dr_ ), y+LDY( 3, dr_ ), 1, 1, 0, secondary_blend, 1 );

