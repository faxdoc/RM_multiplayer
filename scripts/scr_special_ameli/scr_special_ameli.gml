function scr_special_ameli() {
    
    can_dodge_cooldown = 16;
    
    var hh = KRIGHT-KLEFT; 
    var vv = KDOWN-KUP;
    
    if ( hh != 0 && vv != 0 ) {
        dash_dir = point_direction(0,0,hh,vv);  
    }
    
	hsp += LDX( 3, dash_dir );
    vsp += LDY( 3, dash_dir );
    
    hsp *= 0.9;
    vsp *= 0.9;
    
	can_dash = false;
	sprite_index = sameli_flying;
	draw_type = e_draw_type.animation;
	
	if ( KDASHP ) {
	    state = e_player.normal;
        skip_draw = false;
        draw_type = e_draw_type.aiming;
	}
	if ( parry_timer++ > 3 ) {
	    var t_ = bullet_general( 2, 1, shitbox_circle, 0 );
	    t_.do_stun        = false;
	    t_.multihit       = true;
	    t_.multihits_left = 8;
	    t_.duration = 120;
	    parry_timer = 0;
	}
	
	
// 	if (parry_timer == 0 && dash_dir != -1 ) {
		
		
			
// 	}
    
	
// 	if ( dash_dir == -1 ) {
// 		vsp += grav;
// 		if ( parry_timer++ > 13 ) {
// 			state = e_player.normal;
// 			skip_draw = false;
// 			//INVIS = 1;
// 			parry_timer = 0;
// 		}
// 		if ( gen_col(x,y+1)||alt_col) hsp *= frc;	
// 	} else {
// 		if ( parry_timer++ > 10 || gen_col(x,y+1) || alt_col ) {
// 			state = e_player.normal;
// 			skip_draw = false;
				
// 			if ( !gen_col(x,y+1) && !alt_col ) {
// 				INVIS = 3;
// 			} else {
// 				INVIS = 1;
// 			}
				
// 			parry_timer = 0;
// 			hsp *= 0.85;
// 			if  ( vsp < 0 ) {
// 				vsp *= 0.3;
// 			} else {
// 				vsp *= 0.8;
// 			}
// 		}
// 	}
	
	
}