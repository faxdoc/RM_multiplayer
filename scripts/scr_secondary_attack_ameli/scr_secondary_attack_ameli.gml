function scr_secondary_attack_ameli() {
    knife_timer++;
	if ( knife_timer == 6 ) {

		#region do attack
		audio_play_sound_pitch( snd_throw_grenade, RR( 0.9, 1 ) * 0.8, RR( 0.95, 1.1 ), 0 );
		var dmg_mult = 1;
		
		blink_state = 2;
		timer		= 20;
		var dr	= point_direction( x, y, MX, MY );
		var t	= ICD( x + draw_xscale * 16, y - 17, 0, par_hitbox );
		t.move_type = e_movetype.hvsp;
		t.hsp = LDX( 6, dr ) * 0.9;
		t.vsp = LDY( 8, dr ) * 0.9;
		t.custom_user = 0;
// 		t.destroy_index = 1;
		
		t.bounces = true;
		t.grav = 0.31;
		
// 		switch(player_id) {
// 			case 0: t.sprite_index = splayer_grenade_blue;  break;
// 			case 1: t.sprite_index = splayer_grenade_red;   break;
// 			case 2: t.sprite_index = splayer_grenade_green; break;
// 			case 3: t.sprite_index = splayer_grenade_white; break;
// 		}
		//t.sprite_index = player_id == 0 ? splayer_grenade_blue : splayer_grenade_red;
		
		t.sprite_index = sameli_book;
		t.duration = 17;
		t.angle_spin = ( 2 + random_fixed( 4 ) ) * choose_fixed( -1, 1 );
		t.draw_angle = random_fixed( 360 );
		t.dmg = 15;
		t.size_mult = 1;
		t.knockback *= 2.5;
		t.lag_add 	*= 4;
		t.shake_add	*= 3;
		t.mp_mult = 0;
		t.is_bullet = false;
		t.parent = id;
		t.stun_mult = 0.25;
		t.dir = point_direction(x,y,MX,MY);//-90;
		t.multihit = true;
		t.multihits_left = 6;
		t.image_xscale = 1.5;
		t.image_yscale = 1.5;
		
		
		with(t) {
			var i = 32;
			var fc = 1;
			if ( instance_exists( oplayer ) ) fc = sign( oplayer.x - x );
			while( i > 0 && oplayer.gen_col( x, y ) ) {
				i--;
				x += fc;
			}
		}
		if (tplace_meeting_walls( x, y + 1, layer_col ) ) hsp += 1.2 * draw_xscale;
	}
	if ( knife_timer > 20 ) {
		knife_state = 0;
		knife_timer = 0;
		grenade_cooldown = 40;
	}
	#endregion
	
}

