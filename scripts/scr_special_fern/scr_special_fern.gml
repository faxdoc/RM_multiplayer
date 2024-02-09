// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_special_fern(alt_col) {

	can_dodge_cooldown = 10;
	if (parry_timer == 0 && dash_dir != -1 ) {
		hsp = LDX( 5, dash_dir );
		vsp = LDY( 5, dash_dir );
			
	}
	
	can_dash = false;
	sprite_index = splayer_dodge;
	draw_type = e_draw_type.animation;
		
	if ( dash_dir == -1 ) {
		vsp += grav;
		if ( parry_timer++ > 13 ) {
			state = e_player.normal;
			skip_draw = false;
			INVIS = 2;
			parry_timer = 0;
		}
		if ( gen_col(x,y+1)||alt_col) hsp *= frc;	
	} else {
		if ( parry_timer++ > 10 || gen_col(x,y+1) || alt_col ) {
			state = e_player.normal;
			skip_draw = false;
				
			if ( !gen_col(x,y+1) && !alt_col ) {
				INVIS = 4;
			} else {
				INVIS = 1;
			}
				
			parry_timer = 0;
			hsp *= 0.85;
			if  ( vsp < 0 ) {
				vsp *= 0.3;
			} else {
				vsp *= 0.8;
			}
		}
	}
}

