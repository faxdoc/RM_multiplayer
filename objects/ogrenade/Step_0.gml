if( explode_on_ground ) {
	if( gen_col(x+hsp,y+vsp) ) {
		var i = 48;
		while( i-- && !gen_col(x,y) ){
			x += hsp*.1;
			y += vsp*.1;
		}
		var i = 64;
		while( i-- && gen_col(x,y) ){
			x -= hsp*.1;
			y -= vsp*.1;
		}
		destroy_function();
		IDD();
	}
	x += hsp;
	y += vsp;
} else {
	if ( gen_col( x, y+vsp*1.2 ) ){
		var i = 48;
		while( i-- && !gen_col( x, y+sign(vsp) ) ){
			y+=sign(vsp);
		}
		vsp = -vsp * bounce;
		hsp = hsp * bounce;
	}
	if( gen_col( x+hsp*1.2, y ) ){
		var i = 48;
		while( i-- && !gen_col( x+sign(hsp), y ) ){
			x+=sign(hsp);
		}
		hsp = -hsp * bounce;
		vsp = vsp * bounce;
	}
	event_inherited();
}
draw_angle += spin;
if ( do_smoke && random_fixed(1) < .8 ) ICD(x,y,0,osmoke);

//if ( explode_on_contact ) {
//	//if ( enemy_bullet ) {
//		//if( place_meeting(x,y,oplayer) ) IDD();
//	//} else {
//		//if ( place_meeting(x,y,par_enemy) ) {
//		//	var t = instance_place(x,y,par_enemy);
//		//	if ( t && !t.invis ) IDD();
//		//}
//	//}
//}

if ( place_meeting(x,y,par_hitbox) && deleted_by_bullets ) {
	var t_ = instance_place(x,y,par_hitbox);
	
	if ( t_.object_index != ohitbox_saw ) { 
		switch( t_.sprite_index ) {
			default:
				if ( t_.parent != parent ) {
					audio_play_sound_pitch(snd_grenade_parry, RR(0.7,0.8), RR(0.75, 0.8), 2 );
					ICD(x,bbox_top-8,-10,otext_up).type = 11;
					//destroy_function();
					IDD();
				}
			break;
			case splayer_grenade_red:
			case splayer_grenade_blue:
			case splayer_grenade_green: 
			case splayer_grenade_white:
		
			break;
		}
	}
	
} else if ( place_meeting(x,y,oplayer) ) {
	var t = instance_place(x,y,oplayer);
	if ( t && parent != undefined && t != parent && !t.INVIS ) {
		destroy_function();
		IDD();
	}
}


draw_angle = point_direction(0,0,hsp,vsp);
if (!duration--) {
	destroy_function();
	IDD();
}
#macro player_mid_y oplayer.y-22

