function player_main_behaviour(){
player_input_init
if ( intro_timer > 0 ) {
		intro_timer--;
	}
	floor_type = tile_sort_genre(tplace_meeting_index(x+11,y+8+vsp,layer_type));
	walk_spd = base_walk_spd + 0.065 + 0.05;
	if ( grenade_cooldown ) grenade_cooldown--;

	#region input

	if ( global.training_mode ) lives_left = 4;
	//jump buffer
	if( jump_press )jump_buffer = 12;
	if (y > room_height) jump_buffer = 0;
	if( jump_buffer )jump_buffer--;

	//hook buffer
	if( K2  ) hook_cooldown     = 15;
	if( K2P ) hook_press_buffer =  5;
	hook_press_buffer--;

	var k2_ = K2;
	var k2p_ = hook_press_buffer;

	if( !input_skip ){
		if(  hook_cooldown ) hook_cooldown--;
	} else {
		hook_cooldown = 0;
		k2_  = false;
		k2p_ = false;
		wep_select = false;
	}

	#endregion

	#region platform down y
	mask_index = splayer_mask_platform;
	var alt_col = ( !gen_col_sort( x, y, layer_col, 2 ) && gen_col_sort( x, y+2, layer_col, 2 ) );
	mask_index = splayer_mask;
	touching_platform = alt_col;

	#endregion

#region main
	switch( state ) {
		#region hook
		case e_player.hook:
			pre_hook_state = state;
			shoot_delay = 5;
			switch( substate ) {
				case 0:
					draw_type = e_draw_type.starting_hook;
					if ( k2_ || hook_cooldown <= 0 || hook_type__ > 0 ) {
						//audio_play_sound_pitch( snd_blob_0, 0.7, 0.6, 1 );
						substate = 1;
						var drr = point_direction( x, y-gun_height, MX, MY );
						var t = instance_create_depth( x+LDX(gun_len,drr), y-gun_height+LDY(gun_len,drr), 1, ohook );
						t.dir = drr;
						t.parent = id;
					
						var bll =  merge_color(c_darkest,c_black,0.4);
						repeat( 3 ) {
							var sp = ICD( x+LDX(gun_len,drr), y-gun_height+LDY(gun_len,drr), 2, ospark_alt );
							sp.col =  bll;
							var ndir = drr;
							var nspd = 4;
							sp.hsp = LDX(nspd,ndir);
							sp.vsp = LDY(nspd,ndir)-2;
						}
						var fx = create_fx( x+LDX(gun_len,drr), y-gun_height+LDY(gun_len,drr), sgun_blink_2,1,drr,0);
						fx.image_blend = bll;
						hook_charges = 0;
						can_hook_delay = 15;
					} else {
						//if ( ( !alt_col && !gen_col(x,y+1) && KPDOWN == 1 &&  vsp < 3.8 ) ) {
						//	vsp = 3.8;hsp += .1*hh;
						//	repeat(3) {
						//		var spd = 3+random_fixed(1); var dir = random_fixed(360);
						//		fx = create_fx( x + LDX(6*1.5,dir) + hsp, y + LDY(6*1.5,dir) + vsp -24, sdot_wave, .3+random_fixed(.4), 0, -110 );
						//		fx.image_blend = merge_color(c_darkest,c_orange,.3+random_fixed(.5)); fx.hsp =  LDX(spd,dir); fx.vsp = LDY(spd,dir); fx.frc = .9;
						//	}
						//}
					}
				break;
				case 1:
					space_buffer = true;
					draw_type = e_draw_type.hook;
					if ( !instance_exists( ohook ) ) {
							
						substate = 0;
						state = e_player.normal;
						hook_air_cancel = true;
					}
				break;
			}
			player_state_general( alt_col );
			if  ( gen_col(x,y+1) || alt_col ) can_dash = true;
			if ( KDASHP && state == e_player.hook && can_dash ) {
				var hh = KRIGHT-KLEFT;
				var vv = KDOWN-KUP;
				dash_dir = point_direction(0,0,hh,vv);
				if hh == 0 && vv == 0 dash_dir = -1;
				state = e_player.parry;
				INVIS = 20;
				effect_create_depth(  40, ef_flare, x, y-22, 0, merge_colour(c_aqua,c_dkgray,0.8) );
					
			}
		break;
		#endregion
	
		#region normal
		case e_player.normal:
				
			skip_draw = false;
			pre_hook_state = state;
			//vsp += grav;
		
			player_state_general( alt_col );
			if( can_hook_delay )can_hook_delay--;
			if( !can_hook_delay && !hook_air_cancel && K2P ){
					
				state = e_player.hook;
				substate = 0;
			}
			draw_type = e_draw_type.aiming;
				
			if  ( gen_col(x,y+1) || alt_col ) can_dash = true;
			if ( KDASHP && state == e_player.normal && can_dash ) {
				var hh = KRIGHT-KLEFT;
				var vv = KDOWN-KUP;
					
				dash_dir = point_direction(0,0,hh,vv);
				if hh == 0 && vv == 0 dash_dir = -1;
				state = e_player.parry;
				INVIS = 20;
				effect_create_depth(  40, ef_flare, x, y-22, 0, merge_colour(c_aqua,c_dkgray,0.8) );
			}
			var lddd_ = id;
			if ( instance_exists( ohook ) ) {
				with ( ohook ) {
					if ( parent == lddd_ ) {
						state = 2;
					}	
				}
			}
							
		break;
		#endregion
	
		#region hit
		case e_player.hit:
			gun_charge = 0;
			gun_charging = false;
			gun_fully_charged = false;
			if ( !hit_timer-- ) {
				state = e_player.normal;
				skip_draw = false;
				if gen_col(x,y+3) {
					INVIS = 20;
				}
				with ICD(x, bbox_top-26, 0, otext_up ) {
					type = 1;
					str = "-"+add0_float( floor(other.damage_taken),2);
				}
			
			}
			if ( hit_timer mod 4 == 0 ) {
				effect_create_depth( depth-3 + (hit_timer mod 7), ef_smoke, x, y-22, 0, merge_colour(c_white,c_ltgray,random_range_fixed(0.5,1)) );
			}
			if ( gen_col(x+hsp,y) ) {
				vsp -= abs(hsp)*0.4;
				hsp = -hsp*1.3;
			}
				
			if ( gen_col(x,y+1) && vsp >= 0 ) {
				hit_timer -= 5;
			}
			sprite_index = splayer_hit;
			draw_type = e_draw_type.animation;
		
			if ( hit_freeze <= 0 ) {
				var hh = KRIGHT-KLEFT;
				var vv = KDOWN-KUP;
				if ( hh != 0 || vv != 0 ) {
					var di_dir = point_direction(0,0,hh,vv);
					hsp *= 0.98;
					//vsp *= 0.99;
					hsp += LDX( 0.12, di_dir );
					vsp += LDY( 0.12, di_dir );
				}
				
				if( bounce_cooldown ) bounce_cooldown--;
				if( bounce_cooldown && ( vsp > 3 ) &&  ( gen_col( x, y + 1 + vsp ) || alt_col ) ) {
					var i = 16;
					while ( i-- && !gen_col( x, y+1 ) ) y++;
					vsp = -vsp*0.7;
					hsp *= frc;
					hsp *= frc;
				}
				vsp += grav*0.25;
				player_unactive_general(alt_col);
			} else {
				hit_freeze--;
				//if gen_col(x,y+2) && !gen_col(x,y-2) {
				//	y--;
				//}
					
				bounce_cooldown = 26;
			}
			show_debug_message(hit_freeze);
		break;
		#endregion
		#region parry
		case e_player.parry:
			if (hit_timer == 0 && dash_dir != -1 ) {
				hsp = LDX( 5, dash_dir );
				vsp = LDY( 5, dash_dir );
					
			}
			can_dash = false;
			sprite_index = splayer_dodge;
			draw_type = e_draw_type.animation;
				
			if ( dash_dir == -1 ) {
				vsp += grav;
				if ( hit_timer++ > 13 ) {
					state = e_player.normal;
					skip_draw = false;
					//INVIS = 1;
					hit_timer = 0;
				}
					
			} else {
				if ( hit_timer++ > 10 || gen_col(x,y+1) || alt_col ) {
					state = e_player.normal;
					skip_draw = false;
						
					if ( !gen_col(x,y+1) && !alt_col ) {
						INVIS = 3;
					} else {
						INVIS = 0;
					}
						
					hit_timer = 0;
					hsp *= 0.85;
					if  ( vsp < 0 ) {
						vsp *= 0.3;
					} else {
						vsp *= 0.8;
					}
				}
			}
				
				
				
		break;
	
		#endregion
	
		#region Ledge
		case e_player.ledge:
			hook_air_cancel = false;
			draw_type = e_draw_type.animation;
			if ( sprite_index != splayer_wallhug && sprite_index != splayer_wallhug_still ) {
				sprite_index = splayer_wallhug;
				image_index = 0;
			}
		
			if( K2 ) hook_press_buffer = 5;
			var ex_check = dlc_mode ? !gen_col( x+draw_xscale*8, y ) : false;
			if( KPDOWN == 1 || ex_check ) {
				vsp++;
				state = pre_hook_state;
			} else if ( jump_buffer || K3P || vvp == -1 ) {
				jump_buffer = 0;
				state = pre_hook_state;
				vsp = min( -jump_pwr, vsp - jump_pwr )*1.1;
				space_buffer = false;
				audio_play_sound_pitch(snd_jump,0.95,RR(.95,1.05),0);
			} else {
				vsp = 0;
			}
		
			knife_state = 0;
			knife_timer = 0;
			ledge_detect_cooldown = 3;
		
			var i = 0; repeat(weapon_number) {
				if( RELOAD[i] > 0 ) RELOAD[i] = max(0,RELOAD[i]-2);
				i++;
			}
				
		break;
		#endregion
	
	}
	#endregion
	
if ( state != e_player.hit ) {
	damage_taken = 0;
} else {
	if ( pre_hp != hp ) {
		damage_taken += pre_hp-hp;
		pre_hp = hp;
	}
}
	

#region delete hp
if ( place_meeting(x,y,odelete_box) || hp <= 0 || ( state == e_player.hit && place_meeting(x,y,odelete_box_stun) ) ) {
	with ICD(x, bbox_top-26, 0, otext_up ) {
		type = 1;
		str = "-"+add0_float( floor(other.damage_taken),2);
	}
	var plc_ = player_colour;
	if plc_ == c_red plc_ = c_orange;
	var x_ = x;
	var y_ = y-22;
	var tx_ = room_width /2;
	var ty_ = room_height/3;
	if ( place_meeting( x, y, odelete_box ) || ( state == e_player.hit && place_meeting(x,y,odelete_box_stun) ) ) {
		repeat(32) {
			random_fixed(1);
			if ( random_fixed(1) < 0.8 ) {
				effect_create_depth(  irandom_range_fixed(-300,100), ef_smoke, x_+irandom_range_fixed(-64,64), y_+irandom_range_fixed(-64,64), irandom_fixed(2), merge_colour(plc_,c_gray,random_fixed(0.7)+0.3) );
			} else {
				effect_create_depth(  irandom_range_fixed(-300,100), ef_cloud, x_+irandom_range_fixed(-64,64), y_+irandom_range_fixed(-64,64), irandom_fixed(2),  merge_colour(plc_,c_gray,random_fixed(0.7)+0.3) );
			}
			effect_create_depth(  irandom_range_fixed(-300,100), ef_flare,  x_+irandom_range_fixed(-32,32), y_+irandom_range_fixed(-32,32), irandom_fixed(2), merge_colour(c_orange,c_gray,random_fixed(1)) );
			
			x_ = lerp(x_,tx_,0.027);
			y_ = lerp(y_,ty_,0.027);
		}
	} else {
		repeat(8) {
			random_fixed(1);
			if ( random_fixed(1) < 0.9 ) {
				effect_create_depth(  irandom_range_fixed(-300,100), ef_smoke, x_+irandom_range_fixed(-64,64), y_+irandom_range_fixed(-64,64), irandom_fixed(2), merge_colour(plc_,c_gray,random_fixed(0.7)+0.3) );
			} else {
				effect_create_depth(  irandom_range_fixed(-300,100), ef_cloud, x_+irandom_range_fixed(-64,64), y_+irandom_range_fixed(-64,64), irandom_fixed(1),  merge_colour(plc_,c_gray,random_fixed(0.7)+0.3) );
			}
			effect_create_depth(  irandom_range_fixed(-300,100), ef_flare,  x_+irandom_range_fixed(-32,32), y_+irandom_range_fixed(-32,32), irandom_fixed(2), merge_colour(c_orange,c_gray,random_fixed(1)) );
		}
	}
		
	hsp = 0;
	vsp = 0;
	with ( oplayer ) {
		SHAKE += 5;
		show_hp_timer = 1;
	}
	state  = 2;
		
	self_draw = false;
	lives_left--;
		
	meta_state = e_meta_state.dying;
		
	if ( lives_left <= 0 ) {
		meta_state = e_meta_state.dead;
	}
	INVIS = 120;//visible = false;
		
	x = lerp(x,room_width/2,0.05);
	y = lerp(y,room_height/2,0.1);
	var num = 1+irandom_fixed(2);
	repeat(num) {
		var t = ICD(x,y,0,ospark_alt);
		t.spark_col = c_aqua;
	}
	var n = 4+irandom_fixed(3);
	var r = 20;
		
	repeat(n) {
		var xx = x+random_range_fixed( -r, r );
		var yy = y+random_range_fixed( -r, r );
		var f = create_fx(xx,yy,sexplotion,(.9+random_fixed(1.7))*.7,0,-10);
		f.image_alpha = .5+random_fixed(1);
	}
	r = 32;
	n = 16+irandom_fixed(3);
	repeat(n) {
		var xx = x+random_range_fixed( -r, r );
		var yy = y+random_range_fixed( -r, r );
		ICD(xx,yy,0,osmoke_fx).image_blend = c_aqua;
	}
	
	}
#endregion
	
if ( meta_state != e_meta_state.main || state != e_player.hit ) {
	hit_freeze = 0;
}

#region movement and collision
player_platform_col( vv, jump_press );

if ( vsp >= -0.3 ) {
	var fbuffer = (hh != 0 ? hh : hsp);
	if( gen_col( x + fbuffer, y ) && !gen_col(x+fbuffer, y - 6 - abs( hsp ) ) ) {//
		while( gen_col( x+fbuffer, y ) ) y--;
	}
}

mask_index = splayer_mask;
hsp = clamp( hsp, -16, 16 );
vsp = clamp( vsp, -24, 16 );
if ( hit_freeze <= 0 ) {
	collision_function();
}
	
#endregion


#region blend fxs
if ( state == e_player.parry ) { 
	blend = merge_color(c_aqua,c_white,0.7);
	blend_timer = 3;
}
if ( blend != c_white ) {
	if( !blend_timer-- ) blend = c_white;
}
image_blend = blend;

#endregion

#region general player functions
player_gun_general(); //regulate gun vars
player_land_on_ground(); //juice for player landing
#endregion

#region extra input movement general
if ( input_skip							) input_skip--;
if ( ledge_detect_cooldown				) ledge_detect_cooldown--;
if ( close_bullet_sound_played_cooldown ) close_bullet_sound_played_cooldown--;
if ( jump_charge_buffer > 0 ) {
	var cl = choose_fixed(c_orange,c_yellow);
	var llh = jump_charge_buffer/10;
	draw_line_width_color( x-18*draw_xscale, y-llh-16, x-18*draw_xscale, y+llh-16, 3, cl, cl );
}
	
#endregion

#region weapon select
var wep_select_input_hold  = false;
var wep_select_input_press = false;
wep_select_input_hold  = K4;
wep_select_input_press = K4P;

if ( input_skip < 2 ) {
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
			if ( WEP_DATA[ wep_dir ].found ) {
				previous_weapon = current_weapon;
				current_weapon = wep_dir;
					
				#region switch general
				if ( current_weapon != pre_wep ) {
					audio_play_sound_pitch(snd_reload_0,.5,.6+random_fixed(0.1),0);
					switching_weapon = true;
					gun_charging = false;
					gun_charge = 0;
						
				}
					
				#endregion
					
			}
		}
	}
	#endregion		
}
#endregion
	
#region draw variables

var hh = ( state == e_player.normal) ? KRIGHT-KLEFT : 0;
var bdur = 4;

if ( shoot_delay ) {
var_dir = aim_dir;
} else {
if ( gen_col(x,y+1) ) {
	if ( current_weapon != e_gun.flame ) {
		aim_dir = lerp(aim_dir,wave(-10,-18,bdur,.68)-abs(hh)*8.5,.23);
	} else {
		aim_dir = lerp(aim_dir,wave(-24,-31,bdur,.68)-abs(hh)*8.5,.23);	
	}
} else {
	if ( current_weapon != e_gun.flame ) {
		vsp_add = clamp(vsp,-7,10);
		aim_dir = lerp(aim_dir,wave(-5,-12,bdur,.68)+(vsp < 0 ? vsp_add*8 : vsp_add*8.1)*.79,.23);
	} else {
		vsp_add = clamp(vsp,-4,12);
		aim_dir = lerp(aim_dir,wave(-22,-27,bdur,.68)+(vsp < 0 ? vsp_add*8 : vsp_add*7.1)*.79,.23);
	}
}
var_dir = aim_dir;
}


switch( draw_type ) {
case e_draw_type.hook:
case e_draw_type.aiming:
	hair_code();
	sprite_index = splayer_idle;
	switch( blink_state ) {
		case 0:  if ( !timer-- ) { blink_state = 1; timer = 5+random_fixed(20);   } break;
		case 1:  if ( !timer-- ) { blink_state = 0; timer = 60+random_fixed(180); } break;
		default: if ( !timer-- ) { blink_state = 0; timer = 60+random_fixed(180); } break;
	}
		
	if ( legs == splayer_legs_run ) {
		var ll = floor( legs_index );
		if ( ll == 1 || ll == 5 ) { 
			if ( !walk_sound_played ) {
				play_walk_sound(1,1);
				walk_sound_played = true;
			}
		} else {
			walk_sound_played = false;
		}
	} else {
		walk_sound_played = false;
	}
	land_y = land_y < 0.05 ? 0 : land_y*0.85;
	land_y = clamp(land_y,0,2.5);
		
	if ( knife_state == 0 ) {
			
	} else {
		player_throw_grenade();
	}
		
	if ( switching_weapon ) {
		switch_timer++;
		if (switch_timer > 10 ) {
			switching_weapon = false;
			switch_timer = 0;
		}
			
	}
break;
	
}
on_ground = gen_col(x,y+1) || alt_col;

if ( on_ground ) {
if (!crouching) {
	var hs = abs(hsp);
	if ( hs > 0 ) {
		if (hh > 0 ) {
			legs_index += (hs/14);// * draw_xscale;
			if( legs_index < 0	 ) legs_index = 7.9;
			if( legs_index > 7.9 ) legs_index = 0;
		} else {
			legs_index -= (hs/14);// * draw_xscale;
			if( legs_index < 0  ) legs_index = 7.9;
			if( legs_index > 7.9) legs_index = 0;
		} 

		switch( round(legs_index) mod 4 ) {
			case 0:
				target_y = 2;
			break;
			case 1:
				target_y = 1;
			break;
			case 2:
				target_y = 0;
			break;
			case 3:
				target_y = 1;
			break;
		}
	} else {
		legs_index = (legs_index + 0.01) mod 2;
		target_y = floor( legs_index );
	}



} else {
	legs = splayer_legs_crouching;
	legs_index = clamp( ( (-body_y)-1)/2, 0, 4 );
}
if( !crouching ) {
	body_y =  approach(body_y,target_y,2);
}


} else {
legs_index = 0;
target_y = 0;
body_y = 0;
}
legs_running_index = legs_index;
#endregion

if ( INVIS ) INVIS--;
draw_alpha = !( INVIS mod 4 > 1 );
	
}