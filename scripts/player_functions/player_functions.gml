function player_state_general(alt_col) {
	player_input_init
	#region slowdown on shoot
	// if player is hooking or aiming
	var pre_xscale = draw_xscale;
	if ( shoot_delay ) {
		shoot_delay--;
		aim_dir = round( point_direction( x, y-25, MX, MY ) );
		draw_xscale = x > MX ? -1 : 1;
	} else {
		shoot_delay = 0;
		if( hsp != 0 && ( gen_col( x, y + 1 ) || alt_col ) && knife_state = 0 ) {
			if( hh != 0 ) draw_xscale = hh;
		}
	}
	
	#endregion
	
	//walk code
	var mult = 1.6;
	if( state == e_player.hook ) {
		mult *= 0.92; 
	}
	if( current_weapon != e_gun.flame && gun_charge > 0 ) {
		mult *= 0.6;
	}
	walk_spd *= mult;
	
	#region grenade throw
	
	var grenade_input = K7P;

	if ( grenade_input ) {
		grenade_input_buffer = 7;
	} else if ( grenade_input_buffer ) {
		grenade_input_buffer--;
	}
	var ex_check = char_index = e_char_index.maya ? ( CLIP[current_weapon] > 0 || current_weapon == 0 ) : true;
	
	if ( grenade_input_buffer && knife_state == 0 && input_skip < 5 && !grenade_cooldown && ex_check ) {//&& ( !gun_charging )
		//if ( current_weapon == 0 || CLIP[ current_weapon ] > 0 ) {//MP >= grenade_cost && 
		knife_state = 1;
		draw_xscale = x > MX ? -1 : 1;
		grenade_input_buffer = 0;
		maya_grenade_charge = 0;
		maya_grenade_state = 0;
		//}
			//MP -= grenade_cost;
		
		
		// else if (  MP < grenade_cost ) {
			//grenade_input_buffer = 0;
			//ICD(x,y-24,depth+1,otext_up);
			//audio_play_sound_pitch(snd_menu_error,0.7,.8,1);
			//var tll = ICD(oplayer.x,oplayer.y-39,oplayer.depth+1,otext_up);
			//tll.str = "[smp_low]";
			//tll.base_col = c_white;
			//tll.back_col = c_darkest;
		//}
	}
	
	#endregion
	
	//general aim correct
	if( aim_dir > 270 )aim_dir -= 360;
	if (aim_dir > 90 && aim_dir <= 180) {
		aim_dir = abs(-180+aim_dir);
	}
	if( aim_dir > 180 && aim_dir <= 270 ){
		aim_dir = 180-aim_dir;
	}
	
	var gr = vsp >= 0 && ( (gen_col(x,y+1) ) || alt_col);
	#region on ground
	if ( gr ) {
		charge_swing_deterioation = 0;
		hook_air_cancel = false;
		space_buffer = false;
		
		
		//vsp = 0;
		#region croucing
		if ( vv == 1 ) {
			crouching = true;
			body_y = approach(body_y,-7,2);
			hsp *= lerp( frc, 1, 0.5 );
			
			player_charge_jump();
			if ( floor_type != e_floor.grass && jump_charge_buffer ) jump_charge_buffer--;
			
		#endregion
		#region standing on ground
		} else {
			//reset charge
			if ( jump_charge_buffer  ) jump_charge_buffer--;
			if ( !jump_charge_buffer ) jump_charge = 0;
			
			if ( jump_buffer ) {
				player_jump();
			} else {
				hsp += hh*walk_spd;
				
				if ( shoot_delay == 0 && knife_state == 0 && hh == sign(-pre_xscale) && hh != 0 ) {
					//sprite_index	= turnaround_sprite;
					draw_type		= e_draw_type.animation;
					draw_xscale		= hh;
					
				}
				hsp *= frc;
				jump_delay = FALL_MAX;
				
			}
			crouching = false;
		}
		player_legs_general( hh, gr );
	#endregion
	#endregion
	#region air	
	} else {
		
		jump_charge = 0;
		if( jump_delay ){
			jump_delay--;
			if( jump_buffer ){
				player_jump();
			}
		}
		crouching = false; 
		player_legs_general(hh,gr);
		
		var llt_ = false;
		var ld_ = id;
		
		var doing_hook = false;
		
		//with ( ohook ) {
		//	if parent = ld_ doing_hook = true;
		//}
		
		//if ( instance_exists( ohook ) ) {
		//	with ( ohook ) {
		//		if  ( hook_object != -1 && hook_object = ld_ ) {
		//			llt_  = true; 
		//			space_buffer = true;
		//		}
				
		//	}
		//}
		if ( !is_undefined(own_grapple) && instance_exists(own_grapple) ) {
			if ( own_grapple.parent == ld_ ) doing_hook = true;
		}
		
		if( doing_hook || move_hooked || llt_ ) {
			hsp += hh*walk_spd*0.08;
			move_hooked = false;
		} else {
			if ( hh != 0 && ( (sign(hsp) != hh ) || abs(hsp) < abs(hh)*walk_spd*4  ) ) {	
				hsp += hh*walk_spd*.5;
				hsp *= lerp(frc,1,.5 );
				hsp = clamp(hsp,-walk_spd*4 ,walk_spd*4);
			}
			if( vsp <= 0 && !jump_hold && !space_buffer ) { 
				vsp *= 0.8;
			}
		}
		
		vsp += grav;
		
		player_ledge_detect( hh, jump_hold );
	}
	switch( char_index ) {
		case e_char_index.fern:
			scr_gun_code();
		break;
		case e_char_index.maya:
			scr_primary_attack_maya();
		break;
		case e_char_index.ameli:
			scr_primary_attack_ameli();
		break;
	}
	if ( knife_state == 1 ) {
			switch( char_index ) {
				case e_char_index.fern:
				player_throw_grenade();
			break;
			case e_char_index.maya:
				scr_secondary_attack_maya();
			break;
			case e_char_index.ameli:
				scr_secondary_attack_ameli();
			break;
		}
	}


	#endregion
}


function player_charge_jump() {
	if (  ( floor_type == e_floor.grass || tile_sort_genre(tplace_meeting_index(x,y+8+vsp,layer_type))  == e_floor.grass || tile_sort_genre(tplace_meeting_index(x+22,y+8+vsp,layer_type))  == e_floor.grass || PLC(x,y+8,ograss_seperate_render) )  ) {
		var pre_charge = jump_charge;
		jump_charge = min(jump_charge_max,jump_charge+jump_charge_spd);
		if( jump_charge == jump_charge_spd) {
			//if( audio_is_playing(snd_charging_jump_new) )audio_stop_sound(snd_charging_jump_new);
			audio_play_sound_pitch(snd_charging_jump_new,RR(.8,.9), 1,0);
		}
		if (jump_charge != jump_charge_max) {
			if ( jump_charge > 4 ) {
				var dr = random_fixed(360);
				//if (random_fixed(1) > .6) {
				ICD(x+LDX(68,dr),y+LDY(68,dr),-1,ocharge_fx).target = id;
				//}
			}
		} else {
			jump_charge_buffer = 60;
		}

		if ( pre_charge != jump_charge_max && jump_charge == jump_charge_max ) {
			//if (audio_is_playing(snd_charging_jump_new)) audio_stop_sound(snd_charging_jump_new);
			SHAKE++;
			var size = 6;
			var spd;
			var bll = c_orange;
			repeat(4) {
				spd = 3+random_fixed(1);
				var dir = random_fixed(360);
				var fx = create_fx( x + LDX(size*1.5,dir) + hsp, y + LDY(size*1.5,dir) + vsp -6, sdot_wave, .3+random_fixed(.4), 0, -110 );
				fx.image_blend = merge_color(bll,c_orange,0.3+random_fixed(0.5));
				//fx.hsp = LDX(spd,dir);
				//fx.vsp = LDY(spd,dir);
				//fx.frc = 0.9;
			}
		}
	}
}
#macro ICD instance_create_depth

function player_jump() {
	if ( jump_charge_buffer == 0 ) {
		vsp = -jump_pwr*lerp( WORLD_GRAV, 1, .3 );
		land_y = 0;
		audio_play_sound_pitch(snd_jump,.35,RR(.95,1.05),0);
		
		switch(char_index) {
			case e_char_index.fern:
				audio_play_sound_pitch( choose(snd_voice_jump_0,snd_voice_jump_1), RR(0.95,1.05)*0.22,  RR(0.95,1.05), 0 );
			break;
			case e_char_index.maya:
				audio_play_sound_pitch( snd_voice_maya_jump_0, RR( 0.95, 1.05 )*0.22,RR(0.95,1.05),0);
			break;
			case e_char_index.ameli:
				audio_play_sound_pitch( snd_voice_ameli_jump_0, RR( 0.95, 1.05 )*0.22,RR(0.95,1.05),0);
			break;
		}
				
		
	} else {
		vsp = -( jump_pwr + 3 );
		land_y = 0;
		play_walk_sound( 1.2, 0.9 );
		
		//repeat(14)ICD( x, y, -1,  osmoke_fx );
		//repeat(4) ICD( x, y, -1, ospark_alt );
		//repeat(2) ICD( x, y, -1,     osmoke );
		SHAKE++;
		switch(char_index) {
			case e_char_index.fern:
				audio_play_sound_pitch( snd_voice_jump_0, RR(0.95,1.05),  RR(0.95,1.05), 0 );
			break;
			case e_char_index.maya:
				audio_play_sound_pitch( snd_voice_maya_jump_0, RR( 0.95, 1.05 )*0.22,RR(0.95,1.05),0);
			break;
			case e_char_index.ameli:
				audio_play_sound_pitch( snd_voice_ameli_jump_0, RR( 0.95, 1.05 )*0.22,RR(0.95,1.05),0);
			break;
		}
		audio_play_sound_pitch(snd_charged_jump,				0.85,RR(.9,1.1),0);
		
		
		
	}
	
	jump_buffer = 0;
	jump_charge = 0;
	jump_delay = 0;
	jump_charge_buffer = 0;
	flying = false;
	play_walk_sound(1.2,.9);
}

function play_walk_sound(vol_,pt_) {
	
	//if (random_fixed(1) > 0.5 ) {
		//switch(floor_type) {
		//	case e_floor.none:  audio_play_sound_pitch_falloff( snd_walk_stone, .6*vol_, 0.3 + random_fixed( 0.1 )*pt_, 0 ); break;
		//	case e_floor.grass: audio_play_sound_pitch_falloff( snd_walk_dirt,  .5*vol_,0.85 + random_fixed( 0.1 )*pt_, 0 ); break;
		//	case e_floor.stone: audio_play_sound_pitch_falloff( snd_walk_stone, .6*vol_, 0.3 + random_fixed( 0.1 )*pt_, 0 ); break;
		//	case e_floor.wood:  audio_play_sound_pitch_falloff( snd_walk_wood,  .8*vol_, 0.5 + random_fixed( 0.2 )*pt_, 0 ); break;
		//	case e_floor.metal: audio_play_sound_pitch_falloff( snd_walk_metal, .8*vol_, 0.6 + random_fixed( 0.2 )*pt_, 0 ); break;
		//}
	//}
}

function audio_play_sound_pitch_falloff(sound,volume,pitch,priority,falloff_ = 300 ) {
	var x_ = x, y_ = y+22;
	with ( oplayer ) {
		if ( player_local ) {
			var vol = audio_sound_get_gain(sound) * volume;
			var snd = audio_play_sound(sound,priority,false);
			var ds_ = clamp(1.2-point_distance(x_,y_,x,y)/310,0.1,1);
			audio_sound_gain(snd,vol*ds_,0);
			audio_sound_pitch(snd,pitch);
		}
	}
	//if !instance_exists(oplayer) exit;
	////var falloff_volume = 0.3;
	//var peak_vol = audio_sound_get_gain(sound) * volume * 0.6;
		
	//var snd = audio_play_sound( sound, priority, false );
	//audio_sound_gain( snd, peak_vol, 0 );
	//audio_sound_pitch( snd, pitch );
	//return snd;
	//if ( object_index == oplayer ) {
		
		
		//with ( oplayer ) {
		//	if (player_local ) {
		//		var vol = audio_sound_get_gain(sound) * volume;
		//		var snd = audio_play_sound(sound,priority,false);
		//		var ds_ = clamp(1.2-point_distance(x_,y_,x,y)/310,0.1,1);
		//		audio_sound_gain(snd,vol*ds_* 0.6,0);
		//		audio_sound_pitch(snd,pitch);
		//	}
		//}
		
		
		
			
		//	var ld_ = id;
		//	var x_ = x, y_ = y;
		//	with ( oplayer ) {
		//		if ( player_local && id != ld_ ) {
		//			var snd_2 = audio_play_sound(sound,priority,false);
		//			var ds_ = clamp(1.3-point_distance(x_,y_,x,y)/300,0.1,1);
		//			audio_sound_gain(snd_2,vol*ds_,0);
		//			audio_sound_pitch(snd_2,pitch);
		//		}
		//	 }
			
		//	return snd;
		//} else {
		//	return noone;
		//}
	//} else {
	//	var vol = audio_sound_get_gain(sound) * volume;
	//	var snd = audio_play_sound(sound,priority,false);
	//	audio_sound_gain(snd,vol,0);
	//	audio_sound_pitch(snd,pitch);
	//	return snd;
	//}
	
}



function hair_code() {
	if ( hair == -1 ) exit;
	var vert = hair[0];
	vert.x = hair_x+hsp;
	vert.y = hair_y+vsp+2;
	var ll_  = hair_number*1.5;
	var l = array_length(hair)-1,h,h2;
	
	var ds_ = hair_size / 3.2;
	var ns_ = 3.5 * ds_;
	
	var xoff = (draw_xscale * 0.5 + ( 1 - WORLD_GRAV )*2.3)*ds_;
	var yoff = 2.9*WORLD_GRAV*ds_;
	var pwr_ = 0.5*WORLD_GRAV*ds_;
	var i = 0; repeat(l) {
		h = hair[i];
		var c_ = merge_color( hair_start_col, hair_end_col, i/ll_ );
		if( draw_alpha != 0 )draw_circle_color(h.x,h.y,hair_size-i/ll_,c_,c_,false);
		i++;
		h = hair[i];
		h2 = hair[i-1];
		
		h.x = lerp(h.x,h2.x-xoff, pwr_ );
		h.y = lerp(h.y,h2.y+yoff, pwr_ );
		
		
		if( point_distance(h.x,h.y,h2.x,h2.y) > ns_ ){
			var dir = point_direction(h.x,h.y,h2.x,h2.y);
			h.x = h2.x-LDX(ns_,dir);
			h.y = h2.y-LDY(ns_,dir);
			
		}
	}
}

function player_gun_general() {
	if (recoil > .1) {
		recoil = lerp(recoil,0,.4);
	} else {
		recoil = 0;
	}
	 gun_col = make_color_rgb(
		lerp(color_get_red(gun_col)  ,0,.08),
		lerp(color_get_green(gun_col),0,.08),
		lerp(color_get_blue(gun_col) ,0,.08)
	);
}


function player_hook_visuals() {
	if( hook_charges > 0 ) {
		var size = random_fixed( 10 );
		var bll =  merge_color( c_darkest, c_black, 0.4 );
		repeat( hook_charges ) {
			if ( 0.005 > random_fixed( 1 ) ) {
				var dir = random_fixed( 360 );
				ICD( x + LDX(size,dir) + hsp, y + LDY(size,dir) + vsp-24, 1, odrop );
			}
			if ( random_fixed( 1 ) > 0.96 ) {
				var dir = random_fixed(360);
				fx = create_fx( x + LDX(size*1.5,dir) + hsp, y + LDY(size*1.5,dir) + vsp -24, sdot_wave, .3+random_fixed(.4), 0, 1 );
				fx.image_blend = bll;
			}
		}
		if ( hook_charges >=  1 ) {
			if( hook_fx++ mod 120 == 0 ){
				blend = c_ltgray;
				blend_timer = 3;
			}
			if( !wave_done ){
				wave_done = true;
				//SHAKE += 2;
				blend = c_dkgray;
				blend_timer = 3;
				var size = 6;
				var spd;
				repeat(7) {
					spd = 3+random_fixed(1);
					var dir = random_fixed(360);
					fx = create_fx( x + LDX(size*1.5,dir) + hsp, y + LDY(size*1.5,dir) + vsp -24, sdot_wave, .3+random_fixed(.4), 0, -110 );
					fx.image_blend = merge_color(bll,c_orange,.3+random_fixed(.5));
					fx.hsp =  LDX(spd,dir);
					fx.vsp = LDY(spd,dir);
					fx.frc = .9;
				}
			}
		}
	} else {
		wave_done = false;
	}
}


function player_land_on_ground() {
	//fall on ground sound
	if ( gen_col( x, y + 2 + vsp ) && !gen_col( x, y + 2 ) && vsp > 0 ) {
		//play_walk_sound( 1.2, 0.8 );
		audio_play_sound_pitch( snd_land, RR( 0.9, 1 ), RR( 0.9, 1.1 ), 0 );
		////ICD( x, y,   0, odistortion_ball_fall );
		
		////ICD( x, y+4, 0, osmoke_ball );
		land_y = vsp*0.5;
		
		//switch(floor_type) {
		//	case e_floor.grass:
		//		var n = 2 + irandom_fixed( 3 );
		//		repeat(n) {
		//			var grass = ICD(x,y-1,0,ograss_particle); 
		//			grass.vsp *= 1.3;
		//		}
		//	break;
		//}
		//var n = 2 + irandom_fixed( 4 );
		//repeat(n) ICD( x, y-1, 0, ophy_dot_stone ); 
		//repeat(3) ICD( x, y, 1, osmoke );
	}
}

function player_legs_general(hh,ground) {
	//if( live_call( hh, ground ) )return live_result;
	var target_y = 0;
	//if( ground ) {
	//	if ( hh != 0 ) {
				
	//		if ( ( legs == splayer_legs || legs == splayer_legs_stop ) && hh == draw_xscale ) {
	//			legs = splayer_legs_start_run;
	//			legs_index = 1;
	//		} else if ( legs == splayer_legs_start_run && legs_index > 4 ) {
	//			legs = splayer_legs_run;
	//			legs_index = 4;
	//		} else if ( legs != splayer_legs_start_run ) {
	//			legs = splayer_legs_run;
	//		}
				
	//		//legs = sprite_legs_run;
	//		if ( legs == splayer_legs_run ) {
	//			var hs = abs(hsp);
	//			if (hh > 0 ) {
	//				legs_index += (hs/14) * draw_xscale;
	//				if( legs_index < 0	 ) legs_index = 7.9;
	//				if( legs_index > 7.9 ) legs_index = 0;
	//			} else {
	//				legs_index -= (hs/14) * draw_xscale;
	//				if( legs_index < 0  ) legs_index = 7.9;
	//				if( legs_index > 7.9) legs_index = 0;
	//			} 
	//		} else {
	//			var hs = abs(hsp);
	//			legs_index += (hs/6);
	//		}
	//		switch( round(legs_index) mod 4 ) {
	//			case 0:
	//				target_y = 2;
	//			break;
	//			case 1:
	//				target_y = 1;
	//			break;
	//			case 2:
	//				target_y = 0;
	//			break;
	//			case 3:
	//				target_y = 1;
	//			break;
	//		}
	//	} else {
	//		if (!crouching) {
	//			if ( legs == splayer_legs_run ) {
	//				legs = splayer_legs_stop;
	//				legs_index = 0;
	//			} else if ( legs == splayer_legs_stop ) {
	//				legs_index += 0.18;
	//				if ( legs_index > 7.5 ) {
	//					legs = splayer_legs;
	//					legs_index = 0;
	//				}
	//			} else if ( legs != splayer_legs_stop ) {
	//				legs = splayer_legs;
	//				legs_index = wave(1.8,0,4,.87);
	//				target_y = 0;
	//			}
					
	//		} else {
	//			legs = splayer_legs_crouching;
	//			legs_index = clamp( ( (-body_y)-1)/2, 0, 4 );
	//		}
	//	}
	//} else {
	//	legs = splayer_legs_jump;
	//	legs_index = vsp < -1 ? 0 : (vsp > 0 ? (vsp > 1 ? 3 : 2) : 1);
	//	target_y = 0;
	//}
	//if( !crouching ) {
	//	body_y =  approach(body_y,target_y,2);
	//}
}




function player_ledge_detect(hh,jump_hold) {
	//if speed was less or holding jump (vsp >= -4 || jump_buffer || jump_hold)
	if (hh != 0  && ledge_detect_cooldown <= 0) {// && (state = e_player.normal || jump_buffer || jump_hold) {
		mask_index = splayer_legde_mask;
		image_xscale = hh;
		var cll = false;
		if (vsp >= 0) {//down
			cll = gen_col(x,y-13) && !gen_col(x,y-13-vsp);
		} else {//up
			cll = gen_col(x,y-13) && !gen_col(x,y-13+max( -10, vsp ) );
		}
		//used to be if either slow up or pressing
		if ( cll ) {
			while ( !gen_col( x, y-15 ) ) {
				y++;
			}
			while ( gen_col(x,y-15) ){
				y--;
			}
			mask_index = splayer_mask;
			while( !gen_col(x+hh,y) ){
				x += hh;
			}
			hsp = 0;
			hook_air_cancel = false;
			//if pressing up cancel and add speed
			if ( jump_buffer || K3P || KPUP == -1 ) {
				vsp = min(-jump_pwr,vsp-jump_pwr*.32)*lerp(WORLD_GRAV,1,.3);
				//state = e_player.ledge;
				if( substate == 1 ){
					pre_hook_state = e_player.normal;
					state = e_player.normal;
				}
				can_hook_delay = 0;
				if( instance_exists(own_grapple) ){
					//IDD(own_grapple);
					own_grapple.state = 2;
				}
				draw_xscale = hh;
				audio_play_sound_pitch(snd_ledge_grab, 0.85, RR(.9,1.1)+.05, 0);
			//otherwise if speed is high drop input
			} else if ( vsp <= -4 && state == e_player.normal ) {
				if ( substate == 1 ) {
					pre_hook_state = e_player.normal;
					state = e_player.normal;
				}
				can_hook_delay = 0;
				if( instance_exists(own_grapple) ){
					//IDD(own_grapple);
					own_grapple.state = 2;
				}
			} else {
				if( substate == 1 ) pre_hook_state = e_player.normal;
				vsp = 0;
				can_hook_delay = 0;
				state = e_player.ledge;
				do_wings = false;
				audio_play_sound_pitch(snd_ledge_grab, .8, RR(.9,1.1), 0);
				var dl_ = id;
				with ( ohook ) {
					if ( parent == dl_ ) IDD();
				}
				with ( overlet_object ) {
					if ( parent == dl_ ) IDD();
				}
				//if( instance_exists( ohook ) ){
					
				//	IDD(ohook);
					
				//}
				
				
				draw_xscale = hh;
			}
		}
		mask_index = splayer_mask;
		image_xscale = 1;
	}
}


#macro DSC draw_set_color



enum e_floor {
	none,
	grass,
	stone,
	wood,
	metal,
}

enum e_player {
	normal,
	dead,
	cutscene,
	hit,
	swing,
	ledge,
	hook,
	active,
	extra,
	void,
	idle,
	look_around,
	parry,
	animation,
}

enum e_draw_type {
	aiming,
	animation,
	hook,
	starting_hook,
}

enum e_gun {
    pistol,
    shotgun,
    rail,
    sniper,
    grenade,
    flame,
    height,
    sword_large,
    dolk,
    pop,
}
function approach(current,target,spd) {
	if (current < target) {
	    current = min(current+spd, target); 
	} else {
	    current = max(current-spd, target);
	}
	return current;
}


function player_platform_col(vv,jump_press) {
	//stop if going down to
	mask_index = splayer_mask_platform;
	//var parry_skip = (  state == e_player.parry && vsp > 0 );
	if ( vsp > 0 && gen_col_sort(x,y+vsp+1.5,layer_col,2) && !gen_col_sort(x,y,layer_col,2 ) && ( state != e_player.parry || vsp <= grav*1.5 ) ) {// && !(state == e_player.parry && vsp >= 0) 
		y = round(y);
		var v = sign(vsp);
		while( !gen_col_sort(x,y+v,layer_col,2) ){
			y += v;
		}
		vsp = 0;
		floor_type = e_floor.wood;
		
	}// || state == e_player.parry && vsp > 0
	//fall trough
	if (state == e_player.normal || state = e_player.hook ) && ( ( (jump_press  && vv == 1) ) && gen_col_sort(x,y+1,layer_col,2) && !gen_col_sort(x,y,layer_col,2) && !gen_col_sort(x,y+1,layer_col,1) ) && vsp == 0 {
		jump_buffer = 0;
		y++;
		vsp += 1.8;
		audio_play_sound_pitch( snd_fall_trough_platforms, 1, RR(.95,1.1), 0 );
	}
	mask_index = crouching ? splayer_mask_crouch : splayer_mask;
}

#macro IDD instance_destroy

#macro fog_off  	gpu_set_fog( false, 0,		   0, 0 );
#macro fog_white	gpu_set_fog( true,  c_white , -1, 0 );
#macro fog_ltgray	gpu_set_fog( true,  c_ltgray, -1, 0 );
#macro fog_gray 	gpu_set_fog( true,  c_gray	, -1, 0 );
#macro fog_yellow	gpu_set_fog( true,  c_yellow, -1, 0 );
#macro fog_black	gpu_set_fog( true,  c_black , -1, 0 );
#macro fog_custom	gpu_set_fog( true,  fog_color , -1, 0 );

function scr_player_draw_guns(var_dir,bdur,bmax,bmin,y_off) {
	var aidir = var_dir div 2 * 2;
	var bwave;
	
	var recoil_x = LDX(recoil,var_dir)*draw_xscale;
	var recoil_y = LDY(recoil,var_dir);
  
	bwave = round( wave( bmax, bmin, bdur, 0.88 ) );
	
	switch( current_weapon ) {
		#region nail
		case e_gun.rail:
			
			var recoil_x = LDX(recoil,var_dir)*draw_xscale;
			var recoil_y = LDY(recoil,var_dir);
			var charge_cap = 24;
			
			bwave = round( wave( bmax, bmin, bdur, 0.88 ) );
			draw_sprite_ext( splayer_gun_rail,  0,x-4*draw_xscale-recoil_x,y-24+bwave+y_off-recoil_y, draw_xscale, 1, var_dir*draw_xscale, image_blend, draw_alpha );
			bwave = round(wave(bmax,bmin,bdur,.9));

			recoil_x *= 0.9;
			recoil_y *= 0.9;
			shader_set( shd_palette );
			draw_sprite_ext( splayer_hand_outer, 2, x-5*draw_xscale						 -recoil_x*.8,y-24+bwave+y_off-recoil_y*.8, draw_xscale, 1,     aidir*draw_xscale, image_blend, draw_alpha );
			draw_sprite_ext( splayer_hand_outer, 1, x-5*draw_xscale-(var_dir/40)*draw_xscale-recoil_x*.6,y-24+bwave+y_off-recoil_y*.6, draw_xscale, 1,     aidir*draw_xscale, image_blend, draw_alpha );
			draw_sprite_ext( splayer_hand_outer, 0, x-5*draw_xscale-(var_dir/30)*draw_xscale-recoil_x*.25,y-23+y_off+bwave-recoil_y*.25, draw_xscale, 1,   aidir*draw_xscale*1.2, image_blend, draw_alpha );
			shader_reset();
			
		break;
		#endregion
		#region rail
		case e_gun.pistol:
			var recoil_x = LDX(recoil,var_dir)*draw_xscale;
			var recoil_y = LDY(recoil,var_dir);
			bwave = round(wave(bmax,bmin,bdur,.88));
			
			var wep = WEP_DATA[current_weapon];
			var _rl = RELOAD[current_weapon];
			
			
			if ( floor(_rl) == 19 ) {
				var xx_ = x			  +LDX(gun_len*0.5,var_dir)*draw_xscale;
				var yy_ = y-gun_height+LDY(gun_len*0.5,var_dir);
			}
			draw_sprite_ext( splayer_gun_pistol,  1,x-4*draw_xscale-recoil_x,y-24+bwave+y_off-recoil_y, draw_xscale, 1, var_dir*draw_xscale, image_blend, draw_alpha );
			
			bwave = round(wave(bmax,bmin,bdur,.9));

			recoil_x *= 0.9;
			recoil_y *= 0.9;
			shader_set( shd_palette );
			draw_sprite_ext( splayer_hand_outer, 2, x-5*draw_xscale						 -recoil_x*.8,y-24+bwave+y_off-recoil_y*.8, draw_xscale, 1,     aidir*draw_xscale, image_blend, draw_alpha );
			draw_sprite_ext( splayer_hand_outer, 1, x-5*draw_xscale-(var_dir/40)*draw_xscale-recoil_x*.6,y-24+bwave+y_off-recoil_y*.6, draw_xscale, 1,     aidir*draw_xscale, image_blend, draw_alpha );
			draw_sprite_ext( splayer_hand_outer, 0, x-5*draw_xscale-(var_dir/30)*draw_xscale-recoil_x*.25,y-23+y_off+bwave-recoil_y*.25, draw_xscale, 1,   aidir*draw_xscale*1.2, image_blend, draw_alpha );
			shader_reset();
			
		break;
		#endregion
		
		#region default

		case e_gun.grenade:
			var recoil_x = LDX(recoil,var_dir)*draw_xscale;
			var recoil_y = LDY(recoil,var_dir);
  
			bwave = round(wave(bmax,bmin,bdur,.88));
			draw_sprite_ext( splayer_gun_grenade,  0,x-4*draw_xscale-recoil_x,y-24+bwave+y_off-recoil_y, draw_xscale, 1, var_dir*draw_xscale, image_blend, draw_alpha );
		
			bwave = round(wave(bmax,bmin,bdur,.9));

			recoil_x *= 0.9;
			recoil_y *= 0.9;
			shader_set( shd_palette );
			draw_sprite_ext( splayer_hand_outer, 2, x-5*draw_xscale						 -recoil_x*.8,y-24+bwave+y_off-recoil_y*.8, draw_xscale, 1,     aidir*draw_xscale, image_blend, draw_alpha );
			draw_sprite_ext( splayer_hand_outer, 1, x-5*draw_xscale-(var_dir/40)*draw_xscale-recoil_x*.6,y-24+bwave+y_off-recoil_y*.6, draw_xscale, 1,     aidir*draw_xscale, image_blend, draw_alpha );
			draw_sprite_ext( splayer_hand_outer, 0, x-5*draw_xscale-(var_dir/30)*draw_xscale-recoil_x*.25,y-23+y_off+bwave-recoil_y*.25, draw_xscale, 1,   aidir*draw_xscale*1.2, image_blend, draw_alpha );
			shader_reset();
			
		break;
		
		#endregion
		
		#region shotgun
		case e_gun.shotgun:
			var recoil_x = LDX(recoil,var_dir)*draw_xscale;
			var recoil_y = LDY(recoil,var_dir);
			
			bwave = round(wave(bmax,bmin,bdur,.88));
			var wep = WEP_DATA[current_weapon];
			var _rl = RELOAD[current_weapon];
			
			draw_sprite_ext( splayer_gun_shotgun,  1,x-4*draw_xscale-recoil_x,y-24+bwave+y_off-recoil_y, draw_xscale, 1, var_dir*draw_xscale, image_blend, draw_alpha );
			
			bwave = round(wave(bmax,bmin,bdur,.9));

			recoil_x *= 0.9;
			recoil_y *= 0.9;
			shader_set( shd_palette );
			draw_sprite_ext( splayer_hand_outer, 2, x-5*draw_xscale						 -recoil_x*.8,y-24+bwave+y_off-recoil_y*.8, draw_xscale, 1,     aidir*draw_xscale, image_blend, draw_alpha );
			draw_sprite_ext( splayer_hand_outer, 1, x-5*draw_xscale-(var_dir/40)*draw_xscale-recoil_x*.6,y-24+bwave+y_off-recoil_y*.6, draw_xscale, 1,     aidir*draw_xscale, image_blend, draw_alpha );
			draw_sprite_ext( splayer_hand_outer, 0, x-5*draw_xscale-(var_dir/30)*draw_xscale-recoil_x*.25,y-23+y_off+bwave-recoil_y*.25, draw_xscale, 1,   aidir*draw_xscale*1.2, image_blend, draw_alpha );
			shader_reset();
		break;
		#endregion
		
		#region pistol
		case e_gun.flame:
			var recoil_x = LDX(recoil,var_dir)*draw_xscale;
			var recoil_y = LDY(recoil,var_dir);
  
			bwave = round(wave(bmax,bmin,bdur,.88));
			draw_sprite_ext( splayer_gun_small,  min(recoil*2,4),x-5*draw_xscale-recoil_x-(var_dir/80),y-24+bwave+y_off-recoil_y, draw_xscale, 1, aidir*draw_xscale, image_blend, draw_alpha );
			shader_reset();
		
			recoil_x *= 0.9;
			recoil_y *= 0.9;
			shader_set( shd_palette );
			draw_sprite_ext( splayer_hand_outer_pistol,2,x-5*draw_xscale-(var_dir/80)						    -recoil_x*.8, y-24+bwave+y_off-recoil_y*.8, draw_xscale, 1,  aidir*draw_xscale, image_blend, draw_alpha );
			draw_sprite_ext( splayer_hand_outer_pistol,1,x-5*draw_xscale-(var_dir/34)*draw_xscale-recoil_x*.6, y-24+bwave+y_off-recoil_y*.6, draw_xscale, 1,  aidir*draw_xscale, image_blend, draw_alpha );
			draw_sprite_ext( splayer_hand_outer_pistol,0,x-5*draw_xscale-(var_dir/30)*draw_xscale-recoil_x*.25,y-23+bwave+y_off-recoil_y*.25, draw_xscale, 1, aidir*draw_xscale, image_blend, draw_alpha );
			shader_reset();
			
		break;
		#endregion
		
		#region sniper
		case e_gun.sniper:
			var recoil_x = LDX(recoil,var_dir)*draw_xscale;
			var recoil_y = LDY(recoil,var_dir);
			
			bwave = round( wave( bmax, bmin, bdur, 0.88 ));
			var wep = WEP_DATA[ current_weapon ];
			var reload_ = RELOAD[ current_weapon ];
			var rl_ = reload_ == 0 ? draw_alpha : draw_alpha-( reload_ / 40 ) + 0.5;
			
			if ( floor( reload_ ) == 25 ) {
				var xx_ = x			  +LDX(gun_len*0.1,var_dir)*draw_xscale;
				var yy_ = y-gun_height+LDY(gun_len*0.1,var_dir);
				
			}
			
			if ( gun_charge < 1 ) {
				draw_sprite_ext( splayer_gun_sniper, 1, x - 4*draw_xscale-recoil_x,y-24+bwave+y_off-recoil_y, draw_xscale, 1, var_dir*draw_xscale, image_blend, draw_alpha );
				if ( floor( reload_/8 ) == 1 ) {
					//blend_add;
					draw_sprite_ext( splayer_gun_sniper, 2, x - 4*draw_xscale-recoil_x,y-24+bwave+y_off-recoil_y, draw_xscale, 1, var_dir*draw_xscale, image_blend, draw_alpha*0.9 );
					//blend_normal;
				} else {
					draw_sprite_ext( splayer_gun_sniper, 2, x-4*draw_xscale-recoil_x,y-24+bwave+y_off-recoil_y, draw_xscale, 1, var_dir*draw_xscale, image_blend, rl_ );
				}
			} else {
				
				var dv_ = gun_fully_charged ?  50 : 110;
				var lv_ = gun_fully_charged ? 0.7 : 1;
				draw_sprite_ext(splayer_gun_sniper_charge,  0,x-4*draw_xscale-recoil_x,y-24+bwave+y_off-recoil_y, draw_xscale, 1, var_dir*draw_xscale, image_blend, draw_alpha );
				draw_sprite_ext(splayer_gun_sniper_charge,  1,x-4*draw_xscale-recoil_x,y-24+bwave+y_off-recoil_y, draw_xscale, 1, var_dir*draw_xscale, image_blend, draw_alpha );
				draw_sprite_ext(splayer_gun_sniper_charge,  1,x-4*draw_xscale-recoil_x,y-24+bwave+y_off-recoil_y, draw_xscale, 1, var_dir*draw_xscale, image_blend, (gun_charge/120)*lv_ );
			}
			//shader_reset();
			
		
			bwave = round( wave( bmax, bmin, bdur, 0.9 ) );
			
			recoil_x *= 0.9;
			recoil_y *= 0.9;
			shader_set( shd_palette );
			draw_sprite_ext( splayer_hand_outer, 2, x-5*draw_xscale						 -recoil_x*.8,y-24+bwave+y_off-recoil_y*.8, draw_xscale, 1,     aidir*draw_xscale, image_blend, draw_alpha );
			draw_sprite_ext( splayer_hand_outer, 1, x-5*draw_xscale-(var_dir/40)*draw_xscale-recoil_x*.6,y-24+bwave+y_off-recoil_y*.6, draw_xscale, 1,     aidir*draw_xscale, image_blend, draw_alpha );
			draw_sprite_ext( splayer_hand_outer, 0, x-5*draw_xscale-(var_dir/30)*draw_xscale-recoil_x*.25,y-23+y_off+bwave-recoil_y*.25, draw_xscale, 1,   aidir*draw_xscale*1.2, image_blend, draw_alpha );
			shader_reset();
		break;
		#endregion
		
		
	}
	
}

function scr_player_draw_guns_inner(var_dir,recoil_x,bwave,y_off,recoil_y) {
	//if LIVE && (live_call(var_dir,recoil_x,bwave,y_off,recoil_y)) return live_result;
	switch(current_weapon) {
		default:
			draw_sprite_ext( splayer_hand_inner,	 var_dir > 20 ? 1 : 0,x-4*draw_xscale-recoil_x,y-24+bwave+y_off-recoil_y, draw_xscale, 1, var_dir*draw_xscale, image_blend, draw_alpha );
		break;
		case e_gun.sniper:
		case e_gun.shotgun:
		
			
			var _rl = RELOAD[current_weapon];
			
			if ( current_weapon == e_gun.shotgun ) {
				var val_ =-2;
				if ( _rl > 0 ) {
				
					switch(floor(min( ( _rl ) div 7, 6 ))) {
						case 6: val_ =-1; break;
						case 5: val_ =-2; break;
						case 4: val_ = 5; break;
						case 3: val_ = 5; break;
						case 2: val_ = 5; break;
						case 1: val_ = 5; break;
						case 0: val_ = 0; break;
					}
					//val_ -= 1;
				}
				
			} else {
				var val_ = 0;
				if ( _rl > 0 ) {
				
					switch(floor(min( ( _rl ) div 7, 6 ))) {
						case 6: val_ = 0; break;
						case 5: val_ =-1; break;
						case 4: val_ = 4; break;
						case 3: val_ = 4; break;
						case 2: val_ = 4; break;
						case 1: val_ = 4; break;
						case 0: val_ = 1; break;
					}
				}
			}
			recoil_x += LDX(val_,var_dir)*draw_xscale;
			recoil_y += LDY(val_,var_dir);
			draw_sprite_ext( splayer_hand_inner,	0,x-4*draw_xscale-recoil_x,y-24+bwave+y_off-recoil_y, draw_xscale, 1, var_dir*draw_xscale, image_blend, draw_alpha );
			
		break;
	}
}
			
			
			function col_to_array(col,a){
	return [color_get_red(col)/255,color_get_green(col)/255,color_get_blue(col)/255,a];
}

function struct_gen() {
	var a = {
		x : x,
		y : y,
	}return a;
}

function verlet_create_vertex(xx_,yy_,zz_,xprev_,yprev_,zprev_,radius_,active_) {
	vert = {
		xx : xx_,
		yy : yy_,
		zz : zz_,
		oldx : xprev_,
		oldy : yprev_,
		oldz : zprev_,
		radius : radius_,
		frozen : active_,
	}
	return vert;
}



function verlet_generate(length_,width_,draw_type_,line_len_,parent_) {
	var t = ICD(x,y,0,overlet_object);
	t.xnum = width_;
	t.ynum = length_;
	t.index = draw_type_;
	t.line_len = line_len_;
	t.parent = parent_;
	return t;
}

function verlet_generate_parent(length_,width_,draw_type_,line_len_,parent_,x_off_,y_off_,z_off_) {
	var t = ICD(x,y,0,overlet_object);
	t.xnum = width_;
	t.ynum = length_;
	t.index = draw_type_;
	t.line_len = line_len_;
	
	t.parent = parent_;
	t.x_off = x_off_;
	t.y_off = y_off_;
	t.z_off = z_off_;
	
	return t;
}

function verlet_generate_ext(length_,width_,draw_type_,line_len_,parent_,grav_,ground_frc_,un_frc_,bounce_) {
	
	var t = ICD(x,y,0,overlet_object);
	
	t.xnum = width_;
	t.ynum = length_;
	t.index = draw_type_;
	t.line_len = line_len_;
	
	t.grav 			 = grav_;
	t.ground_frc	 = ground_frc_;
	t.universal_frc	 = un_frc_;
	t.bounce		 = bounce_;
	
	if parent_ != -1 parent = id;
	
	return t;
}

function verlet_create_line( p1_,p2_,len_,active_) {
	line = {
		p1     : p1_,
		p2     : p2_,
		len    : len_,
		active : active_,
	}
	return line;
}
	
function player_unactive_general(alt_col) {
	var gr = vsp >= 0 && ( (gen_col(x,y+1) ) || alt_col);
	if( gr ){hsp *= frc; } else { vsp += grav;}
	player_legs_general(0,gr);
	knife_state = 0;
	knife_timer = 0;
}
