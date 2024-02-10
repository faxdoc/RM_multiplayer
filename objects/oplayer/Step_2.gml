#region general

switch( meta_state ) {
	#region char select
	case e_meta_state.char_select:
		
		
		var lmx_ = MX-camera_x;
		var lmy_ = MY-camera_y;
		//if (!instance_exists(opreference_tracker) ) {
		//	exit;
		//}
		if ( !instance_exists( obutton_character ) ) {
			var xx = GW*0.5;
			var yy = GH*0.4;
			ICD( xx-82-32, yy, 0, oplayer_select_maya   );
			ICD( xx+00-32, yy, 0, oplayer_select_fern   );
			ICD( xx+82-32, yy, 0, oplayer_select_ameli  );
			
			ICD( xx-96, yy + 128, 0, obutton_ready		);
			
			ICD( xx+128-112, yy + 128-12-12, 0, obutton_grapplemode );
			ICD( xx+128-112, yy + 128+12-12, 0, obutton_grapplemode_off );
			
			ICD( xx+128-112, yy + 128+32,   0, obutton_tapjump	   );
			ICD( xx+128-112, yy + 128+32+24,0, obutton_tapjump_off );
		}
		
		level_select_timer++;
		
		
		with ( obutton_character ) {
			if ( instance_position( lmx_, lmy_, id ) && other.K1P ) {
				opreference_tracker.char_index[ other.player_id ] = index;
			}
			
		}
		
		with ( otoggle_button ) {
			if ( instance_position( lmx_, lmy_, id ) && other.K1P ) {
				execute_function( other.player_id );
					  
			}
			
			
			//show_debug_message( global.grapple_mode[  other.player_id ] );
				//show_debug_message( global.tap_jump[	  other.player_id ] );
			image_index = return_function( other.player_id );
			
		}
		
		with (obutton_ready) {
			if ( instance_position( lmx_, lmy_, id ) && other.K1P  ) {
				if ( !opreference_tracker.ready_state[ other.player_id ] ) {
					opreference_tracker.ready_state[ other.player_id ] = true;
					//
				}
			}
			//image_index = global.ready_state[ other.player_id ] ? 0 : 1;
			
		}
		
		if ( global.training_mode ) {
			if opreference_tracker.ready_state[ player_id ] {
				with oplayer meta_state = e_meta_state.level_select;
			}
		} else {
			var switch_state = true;
			with ( oplayer ) {
				if ( !opreference_tracker.ready_state[ player_id ] ) switch_state = false;
			}
			if ( switch_state ) {
				with ( oplayer ) {
					meta_state = e_meta_state.level_select;
				}
			}
		}
		
		
	break;
	#endregion
	default:
		if ( first_looser == undefined && lives_left <= 0 ) {
			var ld_ = id;
			with ( oplayer ) { first_looser = ld_; }
		}
		var st_ = 0;
		with ( oplayer ) {
			if ( lives_left > 0 ) {
				st_++;
			}
		}
		
		if ( st_ <= 1 ) {
			var wid_ = id;
			with ( oplayer ) {
				if ( lives_left > 0 ) winner = wid_;
			}
			var fwin = winner;
			with ( oplayer ) {
				winner = fwin;
			}
			
			meta_state = e_meta_state.round_end;
			audio_play_sound_pitch( snd_round_over, 1, 1, 0 );
			
			if ( player_local ) {
				with ( music_player ) {
					stop_playing_music();
				}
			}
		}
		
	break;
	case e_meta_state.level_select:
	case e_meta_state.round_end:
	
	break;
}

#endregion

#region meta states
switch(meta_state) {
	#region level select
	case e_meta_state.level_select:
		if ( !instance_exists( obutton_levels ) ) {
			var d_ = 1/10, i = 0; repeat(9) {
				ICD( GW*(d_+(d_*i)),GH*0.55,0,obutton_levels).image_index = i;
				i++;
			}
		}
		level_select_timer++;
		if (level_select_timer > 2 ) {
			 global.training_mode_change_stage = false;
		}
		
		
	break;
	
	#endregion
	
	#region round end
	case e_meta_state.round_end:
		final_effect_speed *= 0.96;
		final_effect_speed = max(0.03,final_effect_speed);
		final_timer += 0.95;
		if ( final_timer > 340 ) {
			meta_state = e_meta_state.char_select;
			final_timer = 0;
			global.display_room_name = "";
		}
		if( instance_exists( overlet_object ) ) { IDD( overlet_object	); }
		if( instance_exists( par_hitbox	    ) ) { IDD( par_hitbox		); }
		if( instance_exists( ohook		    ) ) { IDD( ohook			); }
	break;
	
	#endregion
	
	#region round start
	case e_meta_state.round_start:
		opreference_tracker.ready_state[ player_id ] = false;
		global.training_mode_change_stage = false;
		
	
		
		#region char apply
		if ( !char_init ) {
			char_index = opreference_tracker.char_index[ player_id ];
				if ( global.test_enabled && TEST_FORCE_CHAR != -1 ) {
					char_index = TEST_FORCE_CHAR;
				}
			char_init = true;
			switch(char_index) {
				default:
				case e_char_index.fern:
					//portrait_expression_base = sface_fern_normal;
					//portrait_expression_hurt = sface_fern_hit;
				break;
				case e_char_index.maya:
					base_walk_spd += 0.04;//base_walk_spd	= 0.385;
					hp_max = 125;
					hp = 125;
					grav *= 1.11;//0.17*1.2;
					base_jump_pwr += 1.2;// 4.68;
					//portrait_expression_base = sface_maya_normal;
					//portrait_expression_hurt = sface_maya_hit;
				break;
				case e_char_index.ameli:
					base_walk_spd *= 0.92;
					hp_max	= 100;
					hp		= 100;
					orbs = [ MAKES( oameli_orb ), MAKES( oameli_orb ), MAKES( oameli_orb ) ];
					orbs[0].parent = id;
					orbs[1].parent = id;
					orbs[2].parent = id;
					grav *= 0.96;
					base_jump_pwr += 0.5;
					orbs[1].idle_timer = 120;
					orbs[2].idle_timer = 240;
					
				break;
			}
			#endregion
		}
		
		#endregion
		//if ( intro_timer < 10 ) {
			
		//} else {
		
			
		// if ( char_index != e_char_index.ameli && KLEFT && KRIGHT && KDOWN && K7 ) {
		// 		//show_debug_message("a")
		// 		char_index = e_char_index.ameli;
		// 		//base_walk_spd += 0.08;//base_walk_spd	= 0.385;
		// 		hp_max = 100;
		// 		hp = 100;
		// 		base_walk_spd *= 0.9;
				
		// 		orbs = [ MAKES( oameli_orb ), MAKES( oameli_orb ), MAKES( oameli_orb ) ];
		// 			orbs[0].parent = id;
		// 			orbs[1].parent = id;
		// 			orbs[2].parent = id;
					
		// 			orbs[1].idle_timer = 120;
		// 			orbs[2].idle_timer = 240;
					
		// 		//grav *= 1.1;//0.17*1.2;
		// 		//base_jump_pwr += 1.25;
		// }
		
		
		
		if ( global.training_mode ) {
			intro_timer = 130;
		}
		hp = hp_max;
		INVIS = 30; 
		intro_timer += 0.75;
		if ( intro_timer == 0.75 ) {
			audio_play_sound_pitch( snd_ready, 1, 1, 0 );
		}
		if ( intro_timer > 105 ) {
			if ( player_local ) {
				with ( music_player ) {
					start_playing_music();
				}
			}
			audio_play_sound_pitch( snd_round_start, 1, 1, 0 );
			intro_timer = 20;
			spawn_timer = 0;
			meta_state  = e_meta_state.main;
			state		= e_player.normal;
			INVIS		= 60;
		}
		if ( intro_timer == 75 ) {
			audio_play_sound_pitch(snd_respawn, RR(0.9,1),  RR(0.9,1), 0 );
		}
		//char_index = e_char_index.maya;
	break;
	case e_meta_state.respawn:
		hp = hp_max;
		INVIS = 30; 
		if ( spawn_timer == 5 ) {
			audio_play_sound_pitch(snd_respawn, RR(0.9,1), RR(0.9,1), 0 );
		}
		if ( spawn_timer++ > 30 ) {
			spawn_timer = 0;
			meta_state	= e_meta_state.main;
			state		= e_player.normal;
			INVIS		= 60;
		}
		damage_taken = 0;
		pre_hp = hp;
		draw_alpha = 1;
		hit_substate = 0;
		
	break;
	#region main
	case e_meta_state.main:
		grapple_mode = opreference_tracker.grapple_mode[player_id];
		player_main_behaviour();
		if ( can_dodge_cooldown ) can_dodge_cooldown--;
		
	break;
	#endregion
	
	#region respawn
	case e_meta_state.dying:
		if ( spawn_timer == 0 ) {
			hit_freeze = 0;
			hit_timer = 0;
			//audio_play_sound_pitch(snd_explotion_0, 0.7, RR( 0.8, 0.9 ), 0 );
			audio_play_sound_pitch(snd_explotion_1, 0.4, RR( 0.5, 0.6 ), 0 );
			//audio_play_sound_pitch(snd_explotion_1, 0.7, RR( 0.7, 0.8 ), 0 );
			
			audio_play_sound_pitch( choose(snd_fallout_0,snd_fallout_1), 0.9, RR( 0.95, 1.05 ), 0 );
			
			if ( instance_exists(orespawn_box) ) {
				x = orespawn_box.x;
				y = orespawn_box.y;
			} else {
				x = room_width  / 2;
				y = room_height / 2;
			}
			var i = 0; repeat( weapon_number ) {
				if (RELOAD[i] > 0 ) RELOAD[i] = 0;
				i++;
			}
			gun_charge = 0;
			gun_charging = false;
			grenade_cooldown = 0;
			aim_dir = 0;
			draw_xscale =1;
			var_dir = 0;
			shoot_delay = 0;
			
		}
		INVIS = 60;
		
		if ( spawn_timer++ > 90 ) {
			hsp = 0;
			vsp = 0;
			spawn_timer = 0;
			meta_state = e_meta_state.respawn;
			
			INVIS = 60; 
			self_draw = true;
		}
		
	break;
	#endregion
	
}

#endregion

if ( meta_state != e_meta_state.main ) {
	var lddd_ = id;
	if ( !is_undefined( own_grapple ) && instance_exists( own_grapple ) ) {
		with ( own_grapple ) {
			if ( parent == lddd_ ) {
				state = 2;
			}	
		}
	}
}

if ( SHAKE > 0.05 ) {
	SHAKE *= 0.85;
	screen_shake_x = random_range_fixed(-SHAKE,SHAKE)*2.0;
	screen_shake_y = random_range_fixed(-SHAKE,SHAKE)*2.0;
} else {
	screen_shake_x = 0;
	screen_shake_y = 0;
	SHAKE = 0;
}
if ( show_hp_timer > 0 ) {
	show_hp_timer += 1.2;
	if ( show_hp_timer >= 100 ) {
		show_hp_timer = 0;
	}
}

var wep_list  = [ 0, 5, 1, 4, 3, 2 ];
var i = 0; repeat(6) {
	
	if RELOAD[wep_list[i]] > 5 {
		gun_flash_data[i] = 8.5;
	} else if ( RELOAD[wep_list[i]] <= 0 && gun_flash_data[i] > 0 ) {
		gun_flash_data[i] -= 0.33;
	}
	i++;
}

if ( maya_animation_swing_timer > 0 ) {
	maya_animation_swing_timer--;
}
if ( maya_sword_blink_alpha > 0 ) {
	maya_sword_blink_alpha -= 1;
}

var hh = KRIGHT-KLEFT;	
if ( hh == 0 ) {
	maya_body_tilt = lerp(maya_body_tilt,hh, 0.15 );
} else {
	maya_body_tilt = lerp(maya_body_tilt,hh, 0.15 );
}

if ( global.training_mode ) {
	if ( global.training_nocooldown ) {
		with (oplayer) {
			var i = 0; repeat(6) {
				RELOAD[i] = 0;
				i++;
			}
			grenade_cooldown = 0;
		}
	}
	if ( global.training_infinite_hp ) {
		with (oplayer) {
			if ( state == e_player.hit ) {
				hp = max(hp,1);
			} else {
				hp = hp_max;	
			}
		}
	}
	if (  global.training_mode_change_stage ) {
		with (oplayer) {
			if player_local {
				with omusic {
					stop_playing_music();
				}
			}
			meta_state	= e_meta_state.level_select;
		}
		
	}

	
}



#region char specfic 
switch(char_index) {
	case e_char_index.ameli:
		if ( meta_state == e_meta_state.dead || meta_state == e_meta_state.dying ) {
			orbs[0].state = e_ameli_orb_state.idle;
			orbs[1].state = e_ameli_orb_state.idle;
			orbs[2].state = e_ameli_orb_state.idle;
			orbs[0].attack_state = e_ameli_orb_attack_state.idle;
			orbs[1].attack_state = e_ameli_orb_attack_state.idle;
			orbs[2].attack_state = e_ameli_orb_attack_state.idle;
		}
		flying_charge = min( flying_charge+0.1, 60 );
		ameli_book_x	= lerp(	ameli_book_x, x+( draw_xscale*23 )+hsp*3, 0.2 );
		ameli_book_y	= lerp(	ameli_book_y, y-27+vsp*3+sin(ameli_book_sin/27)*3, 0.2 );
		ameli_book_sin++;
		if ( !ameli_trail_cooldown-- &&  knife_state == 0 && grenade_cooldown <= 0 && state != e_player.hit ) {
			var amult_ = 3;
			var duration_ = 6;
			var bk_ = ameli_ranged_mode ? sameli_book_range : sameli_book;
			with ( create_fx( 
					ameli_book_x, 
					ameli_book_y,
					bk_, 0,
					0,
					depth+1 ) ) {
						image_index = 0;
						image_xscale = -other.draw_xscale;
						type = e_fx.fade;
						alpha_mult = amult_;
						duration   = duration_;
			}
			ameli_trail_cooldown = 3;
		}
				
	break;
}


#endregion

#region weapon select
var wep_select_input_hold  = false;
var wep_select_input_press = false;
wep_select_input_hold  = K4;
wep_select_input_press = K4P;


var check_m = char_index != e_char_index.maya || knife_state == 0;

if ( input_skip < 2 && check_m) {
	#macro KCP keyboard_check_pressed
	#macro sniper_cost  5
	
	#region quick switch
	if ( KQ0||KQ1||KQ2||KQ3||KQ4||KQ5 ) {
		var pre_wep = current_weapon;
		var quick_num_ = undefined;
			
		if ( KQ0 ) { quick_num_ = 0; }
		if ( KQ1 ) { quick_num_ = 5; }
		if ( KQ2 ) { quick_num_ = 1; }
		if ( KQ3 ) { quick_num_ = 4; }
		if ( KQ4 ) { quick_num_ = 3; }
		if ( KQ5 ) { quick_num_ = 2; }
			
			
		if ( quick_num_ != undefined ) {
			wep_dir = clamp( quick_num_, 0, 5 );
			
			previous_weapon = current_weapon;
			current_weapon = wep_dir;
					
			#region switch general
			if ( current_weapon != pre_wep ) {
				shoot_press_buffer = 0;
				audio_play_sound_pitch(snd_reload_0,.5,.6+random_fixed(0.1),0);
				switching_weapon = true;
				gun_charging = false;
				gun_charge = 0;
				RELOAD[current_weapon] = max(5,RELOAD[current_weapon]+2);
			}
					
			#endregion
					
		}
		
	}
	#endregion		
}
#endregion

