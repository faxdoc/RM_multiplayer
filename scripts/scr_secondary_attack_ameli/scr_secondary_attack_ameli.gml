function scr_secondary_attack_ameli() {
	
	switch( maya_grenade_state ) {
		case 0:
			if ( !K7 ) {
				maya_grenade_state = 1;
				knife_timer = min(floor(maya_grenade_charge),5);
			} else {
				shoot_delay = 5;
				var pre_charge = maya_grenade_charge;
				maya_grenade_charge = min( maya_grenade_charge + 1, max_charge );
				if ( maya_grenade_charge != max_charge ) {
					if ( maya_grenade_charge > 3/charge_levels[current_weapon] ) {
						var dr = random(360);
						if ( random( 1 ) > 0.6 ) {
							with (ICD(x+LDX(68,dr),y+LDY(68,dr),-1,ocharge_fx)) {
								target = other;
							}
						}
					}
				}
				switch(current_weapon) {
					case e_gun.rail:
						hsp *= 0.7;
						if ( vsp < 0 ) {
							vsp *= 0.95;
						}
					break;
					case e_gun.sniper:
						if ( vsp > 0 ) {
							vsp = lerp(vsp,-1,0.2 - (( charge_swing_deterioation/100 ) * 0.2) );
							hsp  = clamp(hsp*0.7,-0.5,0.5);
							if ( charge_swing_deterioation < 100 ) {
								charge_swing_deterioation += 1.4;
							}
						}
						
					break;
					case e_gun.grenade:
						var drr = point_direction(x,y-gun_height,MX,MY);
						if ( effect_timer++ > 1 ) {
							scr_set_size( create_fx( x + LDX( rocket_distance+8, drr ), y-gun_height + LDY( rocket_distance+8, drr ), sbullet_hit_wall, 0.7, 0, -999 ), 1 );
							effect_timer = 0;
						}
						maya_grenade_state = 1;
						if ( CLIP[current_weapon] == 3 ) {
							RELOAD[current_weapon] = 420;
						}
						CLIP[ current_weapon ]--;
					
					break;
				}
				if ( pre_charge != max_charge && maya_grenade_charge == max_charge ) {
					audio_play_sound_pitch( snd_splatter_1, RR( 0.6, 0.7 ) * 0.4, RR( 0.6, 0.7 ) * 1.3, 0 );
					SHAKE++;
					var size = 6;
					var spd;
					repeat(7) {
						spd = 3+random(1);
						var dir = random(360);
						fx = create_fx( x + LDX(size*1.5,dir) + hsp, y + LDY(size*1.5,dir) + vsp -12, sdot_wave, .3+random(.4), 0, -110 );
						fx.image_blend = merge_color(c_gray,c_aqua,.3+random(.5));
						fx.hsp = LDX(spd,dir);
						fx.vsp = LDY(spd,dir);
						fx.frc = .9;
					}
				}
			}
		break;
		case 1:
		
		break;
	}
			
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
		t.hsp = LDX( 6, dr ) * 0.25;
		t.vsp = LDY( 8, dr ) * 0.25;
		t.custom_user = 0;
		t.grav = 0.1;
		t.sprite_index = sameli_page;
		t.duration = 42;
		t.angle_spin = ( 12 + random_fixed( 4 ) ) * choose_fixed( -1, 1 );
		t.draw_angle = random_fixed( 360 );
		t.dmg = 15;
		t.size_mult = 1;
		t.knockback *= 2.5;
		t.lag_add 	*= 4;
		t.shake_add	*= 3;
		t.mp_mult = 0;
		t.is_bullet = false;
		t.parent = id;
		t.stun_mult = 0.45;
		t.dir = point_direction(x,y,MX,MY);//-90;
		t.multihit = true;
		t.multihits_left = 6;
		t.image_xscale = 1.5;
		t.image_yscale = 1.5;
		t.image_index = irandom_fixed( 6 );
		
		
		
// 		switch(player_id) {
// 			case 0: t.sprite_index = splayer_grenade_blue;  break;
// 			case 1: t.sprite_index = splayer_grenade_red;   break;
// 			case 2: t.sprite_index = splayer_grenade_green; break;
// 			case 3: t.sprite_index = splayer_grenade_white; break;
// 		}
		//t.sprite_index = player_id == 0 ? splayer_grenade_blue : splayer_grenade_red;
		
		
		
		
		with( t ) {
			var i = 32;
			var fc = 1;
			if ( instance_exists( oplayer ) ) fc = sign( oplayer.x - x );
			while( i > 0 && oplayer.gen_col( x, y ) ) {
				i--;
				x += fc;
			}
		}
		if ( tplace_meeting_walls( x, y + 1, layer_col ) ) hsp += 1.2 * draw_xscale;
	}
	if ( knife_timer > 20 ) {
		knife_state = 0;
		knife_timer = 0;
		grenade_cooldown = 40;
	}
	#endregion
	
}

