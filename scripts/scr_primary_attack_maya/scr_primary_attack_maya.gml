function scr_primary_attack_maya(){

var i = 0; repeat(weapon_number) {
	if ( RELOAD[i] > 0 ) RELOAD[i] = max( 0, RELOAD[i] - 1 );
	i++;
}
	
if ( input_skip > 0 ) {
	k1_ = false; k1p_ = false;
}
	
#region grenade handle
var i = 1; repeat( 5 ) {
	if ( CLIP[i] != 3 ) {
		if ( !RELOAD[i]-- ) {
			CLIP[i] = 3;
		}
	}
	i++;
}
var on_ground_ = gen_col( x, y+1 );
	
#endregion
	
if ( input_skip <= 0 ) {
	if ( K1P ) {
		shoot_press_buffer = 8;
	} else if ( shoot_press_buffer > 0 ) {
		shoot_press_buffer--;
	}
	if ( K1 ) {
		shoot_hold_buffer = 8;
	} else if ( shoot_hold_buffer > 0 ) {
		shoot_hold_buffer--;
	}	
}
	
var k1_ = shoot_hold_buffer > 0;
var k1p_ = shoot_press_buffer > 0;
	
var pre_reload = RELOAD[0];
//if (RELOAD[0] > 0 )  RELOAD[0] = max(0,RELOAD[0]-1);
gun_charge = 0;
	
	
var dmg_mult = 1.2;
switch( maya_sword_swing_state ) {
	#region first swing
	case 0:
			
		if ( ( k1p_ || k1_ ) && RELOAD[0] == 0 ) {
			maya_show_outside_swing = false;
			if ( k1p_ || k1_ ) {
					
				maya_sword_blink_alpha  = max( 50, maya_sword_blink_alpha + 10 );
				maya_sword_blink_colour = c_red;
				maya_animation_swing_timer = 25;
				gun_len		= 36;
				gun_height  = 20;
				// gun_general( 10, 60, 9 );
					
				// audio_play_sound_pitch(snd_maya_normal_cut, 0.8,  0.96 + random( 0.1 ), 1 );
				// audio_play_sound_pitch(snd_maya_swing_0,	0.35, 0.96 + random( 0.1 ), 1 );
					
				var can_wallbounce = true;
				RELOAD[ 0 ] = 30;
				
				if ( maya_has_parry ) {
					SHAKE += 2;
					repeat( 2 ) {
						var b = bullet_general( 16*dmg_mult, 0.1, splayer_maya_slash, 0, , 0.5 );
						// b.y;
						b.knockback *=  2.95;
						b.duration  = 16;
						b.piercing  = true;
						b.image_xscale *= 1.6*1.4;
						b.image_yscale *= 1.4*2;
						b.image_speed = 1;
						b.depth = depth-1;
						b.ghost = true;
						b.lag_add   *= 1.2;
						b.shake_add *= 1.2;
						b.image_blend = c_aqua;
						b.alt_knockback = true;
							
					}
					// audio_play_sound_pitch( snd_maya_blue_overlay, 0.7, RR( 0.97, 1.1 ), 0 );
					maya_has_parry = false;
				} else if (maya_has_parry_red ) {
					SHAKE += 2;
					repeat( 2 ) {
						var b = bullet_general( 10*dmg_mult, 0.1, splayer_maya_slash, 0, , 0.5 );
						// b.y;
						b.knockback *=  2.45;
						b.duration  = 13;
						b.piercing  = true;
						b.image_xscale *= 1.64;
						b.image_yscale *= 1.3;
						b.image_speed = 1;
						b.depth = depth-1;
						b.ghost = true;
						b.lag_add   *= 1;
						b.shake_add *= 1;
						b.image_blend = c_red;
						b.alt_knockback = true;
							
					}
					// audio_play_sound_pitch( snd_maya_red_overlay, 0.7, RR( 0.97, 1.1 ), 0 );
					maya_has_parry_red = false;
				} else {
					repeat( 2 ) {
						var b = bullet_general(  8*dmg_mult, 0.1, splayer_maya_slash, 0, , 0.5 );
						// b.y;
						b.knockback *=  2.25;
						b.duration  = 10;
						b.piercing  = true;
						b.image_xscale *= 1.55;
						b.image_yscale *= 1.2;
						b.image_speed = 3.4;
						b.depth = depth-1;
						b.ghost = true;
						b.lag_add   *= 0.9;
						b.shake_add *= 0.9;
						b.alt_knockback = true;
					}
						
				}
				if ( can_wallbounce ) {
					with ( b ) {
						image_xscale *= 0.8;
						image_yscale *= 0.5;
						if( gen_col(x,y) ) {
							other.hsp -= LDX( 1.5, dir ) * 0.9;
							if ( LDY( 1, dir ) > 0.1 ) {//Delay downwards momentum if swinging downawrds
								other.vsp = min( other.vsp - LDY( 2.8, dir ), -LDY( 3.2, dir ) )*0.9;
							}

							audio_play_sound_pitch( snd_throw_grenade, 1.2, RR(1.3,1.4),0);
						} else {
							if( on_ground_ )other.hsp += LDX( 1.2, dir )*0.9;
						}
						image_yscale *= 2.00;
						image_xscale *= 1.25;
						repeat ( 3 ) MAKES( ospark_alt );
						space_buffer = true;
					}
				}
					
				effect_general(0,3,0);
				gun_len =  6;
				gun_height = 22;
				bullet_effects_general(sammo_red);
			}
			gun_charge				= 0;
			shoot_delay 			= 30;
			gun_fully_charged		= false;
			maya_sword_swing_state = 1;
				
		}
	break;
	#endregion
		
	#region swing 2
	case 1:
		if ( k1_ && !K1P ) { 
				
			var max_charge = 60;
			var pre_charge = maya_sword_swing_charge;
			maya_sword_swing_charge = min( max_charge, maya_sword_swing_charge + 1.5 );
			maya_animation_swing_timer = max( 3, maya_animation_swing_timer );
			if ( maya_sword_swing_charge == 22.5 ) {
				// swing_charge_sound = audio_play_sound_pitch( snd_maya_heart_alt, 0.4, 0.35, false );
			}
			RELOAD[0] = max( 5, RELOAD[0] );
			if ( pre_charge != max_charge && maya_sword_swing_charge == max_charge ) {
				SHAKE++;
				var size = 6;
				var spd;
				// flash  = 3;
				// flash_col = c_aqua;
					
				// if ( audio_is_plakying( swing_charge_sound ) ) {
					// audio_stop_sound( swing_charge_sound );
					// audio_play_sound_pitch(snd_maya_swing_wall,0.6,0.8,0);
				// }
					
				repeat(7) {
					spd = 3+random(1);
					var _dir = random(360);
					fx = create_fx( x + LDX(size*1.5,_dir) + hsp, y + LDY(size*1.5,_dir) + vsp -22, sdot_wave, .3+random(.4), 0, -110 );
					fx.image_blend = merge_color(c_gray,c_aqua,.3+random(.5));
					fx.hsp = LDX(spd,_dir);
					fx.vsp = LDY(spd,_dir);
					fx.frc = .9;
				}
			}
					
		} else if ( maya_sword_swing_charge != 60 ) {
			maya_sword_swing_charge = 0;
			// if ( audio_is_playing( swing_charge_sound ) ) {
			// 	audio_stop_sound(swing_charge_sound);
			// }
				
		}
			
		if ( !k1_ || K1P ) {
			if ( maya_sword_swing_charge >= 60 ) {
				maya_sword_blink_alpha = max(80,maya_sword_blink_alpha+20);
				maya_sword_blink_colour = c_orange;
				maya_sword_swing_charge = 0;
				shoot_press_buffer = 0;
					
				// audio_play_sound_pitch( snd_maya_charged_cut, 0.8,  (0.96 + random( 0.1 ))*0.9, 1 );
				// audio_play_sound_pitch( snd_maya_swing_2,	 0.20, 1.05 + random( 0.1 ), 1 );
					
				gun_len		= 26;
				gun_height  = 20;
				// gun_general( 10, 60, 9 );
				var do_ver_spd = true;
				var can_wallbounce = true;
				RELOAD[ 0 ] = 35;
				var nmult_ = 1.4;
				var second_swing_size_mult = 0.9;
					
					
				if ( maya_has_parry ) {
					SHAKE += 2;
					repeat( 2 ) {

						var b = bullet_general( 16*dmg_mult*nmult_, 0.1, splayer_maya_slash_heavy, 0, , 0.5 );
						b.knockback *=  2.95;
						b.duration  = 16;
						b.piercing  = true;
						b.image_xscale *=  3.1*1.4*second_swing_size_mult*0.82;
						b.image_yscale *=  1.3*2  *second_swing_size_mult*0.9;
						b.image_speed = 1;
						b.depth = depth-1;
						b.ghost = true;
						b.lag_add   *= 1.5;
						b.shake_add *= 1.5;
						b.image_blend = c_aqua;
						b.alt_knockback = true;
					}
					var ng_ = gen_col(x,y+1);
					// with ( b ) {
					// 	if ( PLC( x, y, par_enemy ) ) {
					// 		can_wallbounce = false;
					// 		space_buffer = true;
								
					// 		if ( !ng_ ) {
					// 			other.hsp -= LDX(.6,dir)*2.0*0.85;
					// 			other.vsp = min( -6, other.vsp-3 );
					// 		} else {
					// 			other.hsp -= LDX(.6,dir)*2.0*0.65;
					// 			other.vsp -= LDY(.6,dir)*2.0*0.65;
					// 		}
					// 		other.can_hook_delay = 0;
					// 		other.hook_air_cancel = 0;
					// 		do_ver_spd = false;
					// 	}
					// }
					// audio_play_sound_pitch( snd_maya_blue_overlay, 0.7, RR( 0.97, 1.1 )*0.95, 0 );
					maya_has_parry = false;
				} else {
						
					repeat( 2 ) {
						var b = bullet_general(  8*dmg_mult*nmult_, 0.1, splayer_maya_slash_heavy, 0, , 0.5 );
						b.knockback *=  2.25;
						b.duration  = 10;
						b.piercing  = true;
						b.image_xscale *= 2.95*second_swing_size_mult*0.82;
						b.image_yscale *= 1.3 *second_swing_size_mult*0.9;
						b.image_speed = 3.4;
						b.depth = depth-1;
						b.ghost = true;
						b.lag_add   *= 1.2;
						b.shake_add *= 1.2;
						b.alt_knockback = true;
					}
					var ng_ = gen_col( x, y + 1 );
					// with ( b ) {
					// 	if ( PLC( x, y, par_enemy ) ) {
					// 		can_wallbounce = false;
					// 		space_buffer = true;
								
					// 		if (!ng_ ) {
					// 			other.hsp -= LDX(.6,dir)*2.0*0.85;
					// 			other.vsp = min( -6, other.vsp-3 );
					// 		} else {
					// 			other.hsp -= LDX(.6,dir)*2.0*0.65;
					// 			other.vsp -= LDY(.6,dir)*2.0*0.65;
					// 		}
					// 		other.can_hook_delay = 0;
					// 		other.hook_air_cancel = 0;
					// 		do_ver_spd = false;
					// 	}
					// }
				}
					
				shoot_delay = 30;
				maya_show_outside_swing = true;
				var _dr =  point_direction(x,y-gun_height, MX, MY );
				var hspd_ = LDX( 6, _dr )*0.8* 0.9;
				var vspd_ = LDY( 7, _dr )*1.0* 0.9;
					
				if ( do_ver_spd ) {
					if ( sign( hsp ) == sign( hspd_ ) ) {
						hsp  = max(abs(hsp)+abs(hspd_*0.25),abs(hspd_))*sign(hspd_);
					} else {
						hsp  = hspd_*0.6;
					}
					if (sign(vsp) == sign(vspd_) ) {
						vsp = min(vsp+(vspd_*0.3),vspd_);
					} else {
						vsp = vspd_;
					}
				}
				var hspd_ = LDX( 4, _dr );
				var vspd_ = LDY( 4, _dr );
					
				repeat( 9 ) {
					if ( !gen_col(x+sign(hspd_)*2,y+sign(vspd_)*2) ) {
						x += hspd_*0.5;
						y += vspd_*0.5;
					} else {
						break;
					}
				}
				space_buffer = true;
					
				effect_general(0,4,0);
				gun_len =  6;
				gun_height = 22;
					
				gun_charge				= 0;
				shoot_delay 			= 30;
				gun_fully_charged		= false;
				maya_sword_swing_state = 2;
			} else {
				maya_sword_swing_state = 0;
				maya_sword_swing_charge = 0;
					
			}
		}
	break;
	#endregion
	#region swing 3
	case 2:
			maya_sword_swing_state = 0;
	break;
	#endregion
		
}
if ( maya_has_parry ) {
	maya_sword_blink_colour = c_aqua;
	maya_sword_blink_alpha = 60;
} else if ( maya_has_parry_red ) {
	maya_sword_blink_colour = c_red;
	maya_sword_blink_alpha = 40;
}
	


}

