
// #macro hitscan_check ( !do_hitscan_check || scr_check_hitscan_collision( oplayer.x, player_mid_y,  t ) )
if ( alt_init ) {
	spd *= 0.8;
	duration *= 1.2;
	alt_init = false;
	switch(sprite_index) {
		default:
		
		break;
		case splayer_maya_slash:
		case splayer_maya_slash_hard:
		case splayer_maya_slash_heavy:
		case splayer_maya_slash_long:
			do_hitscan_check = true;
			stun_mult *= 1.35;
			bonus_vsp = -1;
		break;
	}
}

#region hitfreeze
if ( do_hitfreeze ) {
	if ( hitfreeze > 0 ) {
		hitfreeze -= 1;
		var htfr_ = max( 0, hitfreeze * 0.5 );
		draw_x_offset = RR( -htfr_, htfr_ );
		draw_y_offset = RR( -htfr_, htfr_ );
		exit;
	}
}

#endregion

repeat(step_number) {
	//universal
	if ( !duration-- ) {
		destroy_function();
		IDD();
		step_number = 0;
	}
	
	if ( trail_fx != -1 ) {
		if ( trail_timer++ >= trail_interval ) {
			trail_timer = 0;
			//create_fx(x,y,trail_fx,1,dir,1);
		}
	}
	
	if ( custom_user != -1 ) event_perform( ev_other, ev_user0 );
	
	
	//movement
	if ( do_movement_general ) {
		
		switch( move_type ) {
			case e_movetype.hvsp:
				x += hsp;
				y += vsp;
				vsp += grav;
				draw_angle += angle_spin;
				event_perform( ev_other, ev_user1 );
			break;
			case e_movetype.vector:
				spd *= frc;
				x += LDX(spd,dir);
				y += LDY(spd,dir);
				angle_spin += dir_angle_spin;
				draw_angle = dir + angle_spin;
				event_perform( ev_other, ev_user1 );
			break;
			case e_movetype.melee:
				if ( invis_set ) {
					//hit_fx = -1;
					trail_fx = -1;
					self_push = true;
					piercing = true;
					destroy_index = -1;
				}
				if ( instance_exists( parent ) ) {
					x = parent.x+ xdis*parent.draw_xscale;
					y = parent.y+ ydis;
					knockback_dir = parent.draw_xscale == 1 ? 180 : 0;
				} else {
					destroy_function();
					IDD();
					step_number = 0;
					exit;
				}
			break;
		}
	}
	if ( multihit && multihit_cooldown ) multihit_cooldown--;
	
	var t = undefined;
	var t_ = id;
	with ( oplayer ) {
		if ( PLC(x,y,t_) && id != t_.parent && !INVIS ) {
			t = id;
		}
	}
	
	#region Hit enemy
	if ( t && parent != undefined && t != parent && !t.INVIS && ( !multihit || multihit_cooldown <= 0 ) && ( !do_hitscan_check || scr_check_hitscan_collision( oplayer.x, player_mid_y, t ) ) && !piercing_cancel ) {
		hit_freeze = 4;
		var pt_ = clamp( 1.1 - dmg / 90, 0.75, 1 )+0.1;
		var vol_= clamp( 0.3 + dmg / 80, 0.4, 0.9 );
		
		if ( do_stun ) {
			if ( parent.char_index == e_char_index.ameli && random_fixed(1) > 0.9 ) {
				with ( parent ) {
					if ( random_fixed(1) > 0.5 ) {
						audio_play_sound_pitch( snd_voice_ameli_laugh_0, RR(0.7,0.9), 1, 0 );
					} else {
						audio_play_sound_pitch( snd_voice_ameli_laugh_1, RR(0.7,0.9), 1, 0 );
					}
					
				}
			}
			
			if ( t.state != e_player.hit ) {
				effect_create_depth( -40, ef_ring, t.x, t.y-22, 0, merge_colour( c_red, c_ltgray, 0.6 ) );
				t.hit_freeze = floor( max( 8, dmg / 6 ) );
				
				t.screen_flash_col	= c_gray;
				t.flash_alpha		= 0.07;
				
				if ( instance_exists( parent ) ) {
					parent.screen_flash_col	= c_gray;
					parent.flash_alpha		= 0.07;
				}
				
				var snd_ = dmg >= 55 ? snd_hit_extra : choose( snd_hit_2, snd_hit_3 );
			
				//snd_ = choose(  );
				if ( dmg < 55 ) {
					audio_play_sound_pitch( snd_,		RR(0.75,0.8)*1.1*vol_, RR(0.95,1.05)*pt_, 0 );
				} else {
					audio_play_sound_pitch( snd_hit_extra, RR(0.9,0.96), RR(0.95,1.05), 0, 0.1 );
				}
				
				if ( !t.draw_sandbag ) {
					switch(t.char_index) {//
						case e_char_index.fern:
							snd_ = snd_take_damage;//choose( snd_take_damage, snd_take_damage_alt, snd_take_damage_3 );
						break;
						case e_char_index.maya:
							snd_ = snd_voice_maya_hit_0;
						break;
						case e_char_index.ameli:
							snd_ = snd_voice_ameli_hit_0;
						break;
					}
					audio_play_sound_pitch( snd_, RR(0.75,0.8)*vol_, RR(0.95,1.05), 0 );
				}
				
			} else {
				var snd_ = dmg >= 55 ? snd_hit_extra : choose( snd_hit_0, snd_hit_1, snd_hit_4 );
				t.hit_freeze = floor( max(4,dmg/6) );
				damage_mult *= 0.8;
				if ( dmg >= 55 ) {
					audio_play_sound_pitch( snd_, RR(0.75,0.8)*vol_, RR(0.95,1.05)*pt_, 0, 0.1 );
				} else {
					audio_play_sound_pitch( snd_, RR(0.75,0.8)*vol_, RR(0.95,1.05)*pt_, 0 );
				}
				if ( !t.draw_sandbag ) {
					switch(t.char_index) {//
						case e_char_index.fern:
							snd_ = snd_take_damage;//choose( snd_take_damage, snd_take_damage_alt, snd_take_damage_3 );
						break;
						case e_char_index.maya:
							snd_ = snd_voice_maya_hit_1;
						break;
						case e_char_index.ameli:
							snd_ = snd_voice_ameli_hit_1;
						break;
					}
				}
				
				audio_play_sound_pitch( snd_, RR(0.75,0.8)*vol_, RR(0.95,1.05), 0 );
			}
		}
		
		if ( do_stun ) {
			if ( t.hit_substate == 1 ) {
				if ( instance_exists( t.own_grapple ) ) {
					t.own_grapple.state = 2;
				}
				t.hit_substate = 2;
			}
			t.space_buffer = true;
			t.can_dash = true;
			
			t.state = e_player.hit;
			t.hit_timer = floor(dmg*7.5*stun_mult);
			t.hit_freeze = max(4,dmg/3);
			t.bounce_cooldown = 30;
			
			if ( t.hit_substate == 0 ) {
				t.can_hook_delay = false;
				t.hook_air_cancel = false;
			}
			
			if ( instance_exists(parent) ) {
				parent.can_hook_delay = false;
				parent.hook_air_cancel = false;
			}
			
			
			with ( ohook ) {
				if ( parent == t || hook_object == t ) {
					state = 2;
					if (instance_exists(wire) ) {
						IDD(wire);
					}
				}
			}
			knockback *= 1.1;
			t.hsp *= 0.05;
			t.vsp *= 0.05;
			
			if ( abs(LDX(1,dir) ) < 0.5 && alt_t_knockback ) {
				t.hsp += LDX( knockback*0.6, point_direction( 0, 0, -sign( parent.x - x )*10, 0 ) );
			} else {
				t.hsp += LDX( knockback*1.4, dir );
			}
			
			t.vsp += LDY( knockback*1.6, dir );
			
			t.vsp = lerp( t.vsp, min(-knockback*1.4,t.vsp), 0.5-LDY(0.5,dir) );
			t.vsp += bonus_vsp;
			
			with ( t ) {
				while gen_col(x,y+vsp+1) && !gen_col(x,y-1) {
					y--;
				}
			}
			t.SHAKE += shake_add * 0.5;
			parent.SHAKE += shake_add;
		}
		
		
		t.hp -= dmg*damage_mult;
		
		multihit_cooldown = multihit_cooldown_amount;
		if ( multihit &&  multihits_left > 0 ) {
			multihits_left--;
		} else if ( !piercing ) {
			destroy_function();
			IDD();
		}
		if ( piercing ) piercing_cancel = true;
		
	} else if ( multihit && multihits_left <= 0 ) {
		destroy_function();
		IDD();
	}
	
	#endregion
	
	if ( delete_other_bullets ) {
		var _t = instance_place( x, y, par_hitbox );
		if ( _t && _t.parent != parent ) {
			IDD(_t);
		}
	}
	if ( can_be_knocked ) {
		var _t = instance_place( x, y, par_hitbox );
		duration += 0.6;
		if ( _t && !_t.can_be_knocked ) {
			audio_play_sound_pitch_falloff( snd_maya_hit_ball, RR( 0.8, 0.9 ), RR( 0.95, 1.1 ), -10 );//RR(1.5,1.7)
			//show_message("a");
			can_be_knocked = false;
			hsp *= 0.4;
			vsp *= 0.4;
			hsp += LDX( 9+_t.dmg*0.5, _t.dir );
			vsp += LDY( 9+_t.dmg*0.5, _t.dir );
			dmg *= 1.2;
			dmg += _t.dmg*0.8;
			
			do_hitfreeze = true;
			hitfreeze = 6;
			if instance_exists(t_.parent) {
				parent = t_.parent;
				with ( t_.parent ) {
					SHAKE++;
				}
			}
				
			
			//scr_hitlag(30);
			if (!has_been_knocked) {
				image_yscale *= 0.8;
				image_xscale *= 1.6;
				grav *= 0.9;
			}
			repeat(3) MAKES(ospark_alt);
			dir = point_direction(0,0,hsp,vsp);
			draw_angle = dir;
			angle_spin = 0;
			duration  = 60;
			has_been_knocked = true;
			bounces_left = 1;
		}
	} else if ( !PLC(x,y,par_hitbox ) && !anti_knockable ) {
		can_be_knocked = true;
	}
	if ( has_been_knocked ) {
		dir = point_direction(0,0,hsp,vsp);
		draw_angle = dir;
	}
	
}

if ( local_sound != undefined ) {
	location_sound_step( local_sound,  local_sound_volume, x, y,  local_sound_start_falloff, local_sound_end_falloff, local_sound_falloff_rate  );
}
image_angle = draw_angle;

