function scr_secondary_attack_maya(){
#region Maya grenade
	var dmg_mult = 1;
	var rocket_distance = 120;
	
	var max_charge = 30;
	switch( maya_grenade_state ) {
		case 0:
			#region charge maya grendade
			if ( !K7 ) {
				maya_grenade_state = 1;
				if ( current_weapon != 0 ) {
					if ( CLIP[current_weapon] == 3 ) {
						RELOAD[current_weapon] = 420;
					}
					CLIP[ current_weapon ]--;
						//pistol saw
					if( current_weapon == 5 )CLIP[5] = 0;
						//long swing?
					if( current_weapon == 2 )CLIP[2] = min(CLIP[2],1);
					
					//long swing?
					if( current_weapon == e_gun.sniper )CLIP[e_gun.sniper] = min(CLIP[e_gun.sniper],1);
					
				}
				knife_timer = min(floor(maya_grenade_charge),5);
				//maya_grenade_charge *= 0.3;
			} else {
				shoot_delay = 5;
				var pre_charge = maya_grenade_charge;
				
				//grenade, dash, large swing, long swing, dunno, saw
				var charge_levels = [ 1, 3, 1.2, 1, 1.2, 1 ];
				maya_grenade_charge = min( maya_grenade_charge + ( charge_levels[ current_weapon ] / 1.5 ), max_charge );
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
			
			#endregion
			
		break;
		case 1:
			knife_timer++;
			var charge_level = maya_grenade_charge/30;
			switch( current_weapon ) {
				#region base pistol
				case e_gun.pistol:
					if ( knife_timer == 6 ) {
						audio_play_sound_pitch( snd_maya_throw_grenade,RR( 0.9, 1 ) * 0.9, RR( 0.97, 1.05 ), 0 );
						
						
						var dmg_mult = 1;
						blink_state = 2;
						timer		= 20;
						var dr	= point_direction( x, y, MX, MY );
						var t	= ICD( x + draw_xscale * 16, y - 17, 0, par_hitbox );
						t.move_type 	= e_movetype.hvsp;
						t.hsp			= LDX( 6, dr ) * 1.1* (0.9+charge_level*0.2);
						t.vsp			= LDY( 8, dr ) * 1.1* (0.9+charge_level*0.2);
						t.custom_user	= 0;
						t.destroy_index = 1;
						t.anti_knockable = false;
						t.bounces = true;
						t.grav		= 0.21;
						t.duration = 62;
						t.angle_spin = ( 2 + random( 4 ) ) * choose( -1, 1 );
						t.draw_angle = random( 360 );
						t.dmg =  17 * 1 * dmg_mult * lerp( 0.7, 1.25, charge_level);
						t.size_mult =  1.4 * (0.7+(charge_level*0.6));
						t.knockback *= 2.5;
						t.lag_add 	*= 4;
						t.shake_add	*= 3;
						t.is_bullet = false;
						t.sprite_index = sbaseball_test;
						t.hsp *= 0.4;
						t.vsp *= 0.7;
						t.can_be_knocked = true;
						//t.dmg *= ;
						t.parent = id;
						t.stun_mult = 0.2;
						
						
						
						if (tplace_meeting_walls( x, y + 1, layer_col ) ) hsp += 1.2 * draw_xscale;
					}
					if ( knife_timer > 45 ) {
						knife_state = 0;
						knife_timer = 0;
						maya_grenade_charge = 0;
					}
					
				break;
				#endregion
				#region dash
				case e_gun.shotgun:
					var charge_pwr_ = lerp( 0.8, 1.2, charge_level );
					var tm_ = max( 0, 6 - ( maya_grenade_charge / 2.5 ) );
					if ( knife_timer >= tm_ && knife_timer < 100 ) {
						knife_timer += 100;
						var do_bounce_ = false;
				        audio_play_sound_pitch( snd_maya_swosh,		0.05, 1.00 + random( 0.05 ), 1 );
				        audio_play_sound_pitch( snd_maya_dash,		0.65, 0.95 + random( 0.05 ), 1 );
						
						
						gun_len		= 56;
						gun_height  = 20;
						var do_ver_spd = true;
						var can_wallbounce = true;
						var nmult_ = 1.4;
						SHAKE += 1;
						repeat( 2 ) {
							var b = bullet_general(  11*charge_pwr_, 0.1, splayer_maya_slash, 0, , 0.5 );
							b.knockback *= 1*charge_pwr_;
							b.duration  = 14;
							b.piercing  = true;
							b.image_xscale  = 0.95*charge_pwr_;
							b.image_yscale *= 1.2 *charge_pwr_;
							b.image_speed = 1.4;
							b.depth = depth-10;
							b.ghost = true;
							b.lag_add   *= 1;
							b.shake_add *= 1;
							b.alt_knockback = true;
							//b.stun_mult = 0.8;
							
						}
						
							
						var _dr =  point_direction(x,y-gun_height, MX, MY );
						
						
						var hspd_ = LDX( lerp(4.5,8,charge_level), _dr );
						var vspd_ = LDY( lerp(4.5,8,charge_level), _dr );
						var px_ = x + hspd_ * 6;
						var py_ = y + hspd_ * 6;
						
						var bb  = 0;
						var do_add_ = false;
						var _il = 0;
						var cx_ = abs( hspd_ ) < 5 ? ( sign( hspd_ ) > 0 ? 5 : -5) : hspd_;
						var cy_ = abs( vspd_ ) < 5 ? ( sign( vspd_ ) > 0 ? 5 : -5) : vspd_;
						while( _il < 12 ) {	
							if ( !gen_col( x +cx_, y + cy_ ) ) {
								x += hspd_;
								y += vspd_;
								maya_add_x += hspd_;
								maya_add_y += vspd_;
							}
							if ( vspd_ > 1 && gen_col( x, y+vspd_ ) ) {
								do_add_ = true;
								var il_ = 32;
								while ( il_-- && !gen_col(x,y+1)) {
									y++;
									maya_add_y++;
								}
								il_ = 32;
								while( il_-- && gen_col( x, y ) ) {
									y--;
									maya_add_y--;
								}
									
								_dr =  point_direction(0,0, hspd_, 0 );
								hspd_ = LDX( 8, _dr );
								vspd_ = 0;
								
								_il += 4;
									
							}
							
							if ( bb > 0 ) {
								bb = 0;
								//scr_player_maya_trail();
							} else {
								bb++;
							}
							
							_il++;
						}
						if ( do_add_ ) {
							hsp += sign(hspd_)*max(0,3-abs(hsp)*0.5);
						}
						
						if( sign( hsp ) == sign( hspd_ ) ) {
							// LOG("b");
							hsp += hspd_*.3;
						} else {
							hsp = hspd_*.4;
						}
						if (!gen_col(x,y+1) ) {
							if ( do_bounce_ ) {
								vsp = min(vsp-1,-4);
							} else {
								vsp = vspd_*0.5;
							}
							space_buffer = true;
						}
					}
					if ( knife_timer > tm_+100+10 ) {
						knife_state = 0;
						knife_timer = 0;
						maya_grenade_charge = 0;
					}
				break;
				#endregion
				#region Large swing
				case e_gun.rail:
					
					var ex_ = charge_level == 1;
					var charge_pwr_ = lerp(0.8,1.4,charge_level) + ( charge_level == 1 ? 0.5 : 0) + (maya_has_parry ? 0.7 : 0);
					if ( knife_timer == 7 ) {
						input_skip = 35;
					}
					if ( knife_timer < 30 ) {
						sprite_index = smaya_heavy_attack_start;
						image_index = clamp( (knife_timer/17 )* 8, 0, 15 );	
						image_speed = 0;
						draw_type = e_draw_type.animation;
					} else if ( knife_timer > 38 ) {
						sprite_index = smaya_heavy_attack_recover;
						image_index = clamp( ( ( knife_timer - 38 ) / 15 ) * 5, 0, 5 );
						draw_type = e_draw_type.animation;
					}
					
					if ( knife_timer == 14 ) {
						SHAKE += 4;
						audio_play_sound_pitch( snd_maya_quick_draw, 0.9, 0.76 + random( 0.05 ), 1 );
						audio_play_sound_pitch( snd_explotion_1,	 0.35, 1.95 + random( 0.1 ), 1 );
						gun_len		= 16;
						gun_height  = 24;
						var do_ver_spd = true;
						var can_wallbounce = true;
						var nmult_ = 1.4;
						SHAKE += ex_ ? 3 : 2;
						draw_xscale = sign(x-MX) == 1 ? -1 :  1;
						repeat( 2 ) {
							var b = bullet_general( 31*charge_pwr_, 0.1, splayer_maya_slash_hard, 0, , 0.5 );
							// b.y;
							b.knockback *=  0.2*charge_pwr_;
							b.duration  = 26;
							b.piercing  = true;
							b.image_xscale *= 2.0 * lerp( 1, 1.2, charge_level )*1.2;
							b.image_yscale *= 2.5 * lerp( 1, 1.2, charge_level )*1.2*-draw_xscale;
							b.image_speed = 3;
							b.depth = depth-1;
							b.ghost = true;
							b.lag_add   *= 1.2*charge_pwr_;
							b.shake_add *= 1.2*charge_pwr_;
							b.stun_mult = 0.4;
							b.alt_knockback = true;
							b.image_blend = ex_ ? c_aqua : c_white;
						}
						if ( maya_has_parry ) {
							maya_has_parry = false;
						}
						if ( !gen_col( x, y+1 ) ) {
							vsp = min( -3, vsp - 1 );
						}
						var _dir = point_direction( x, y-gun_height, MX, MY );
						 hsp -= LDX( 1.5, _dir )*0.9;
						 vsp = min( other.vsp - LDY( 2.8, _dir ), -LDY( 3.2, _dir ) )*0.9;
						
						space_buffer = true;
					}
					
					if ( knife_timer > 51 ) {
						knife_state = 0;
						knife_timer = 0;
						state = e_player.normal;
						image_speed = 1;
						maya_grenade_charge = 0;
						RELOAD[e_gun.rail] = 500;
					}
					
				break;
				#endregion
				
				#region long swing
				case e_gun.sniper:
					var ex_ = charge_level == 1;
					var charge_pwr_ = lerp( 0.6, 1.3, charge_level ) + ( ex_ ? 0.6 : 0 );
					if ( knife_timer == 6 ) {
				        audio_play_sound_pitch( snd_maya_quick_draw, 0.9, 0.95 + random( 0.1 ), 1 );
						audio_play_sound_pitch(snd_maya_charged_cut, 0.9, 0.95 + random( 0.1 ), 1 );
						gun_len		= 16;
						gun_height  = 20;
						var do_ver_spd = true;
						var can_wallbounce = true;
						var nmult_ = 1.4;
						SHAKE += ex_ ? 3 : 2;
						repeat( 2 ) {
							var b = bullet_general( 10*charge_pwr_, 0.1, splayer_maya_slash_long, 0, , 0.5 );
							
							b.knockback *=  0.35*charge_pwr_;
							b.duration  = 16;
							b.piercing  = true;
							b.image_xscale *= ( lerp( 0.8, 1.2, charge_level ) + ex_ ? 0.5 : 0 );
							b.image_yscale *= lerp( 0.7, 1, charge_level );
							b.image_speed = 1;
							b.depth = depth-1;
							b.ghost = true;
							b.lag_add   *= 1.2*charge_pwr_;
							b.shake_add *= 1.2*charge_pwr_;
							b.alt_knockback = true;
							b.image_blend = ex_ ? c_aqua : c_white;
							b.stun_mult = 0.7;
							
						}
						
						
						if (!gen_col(x,y+1)) {
							vsp = min( -4, vsp - 1 );
						}
						space_buffer = true;
					}
					
					if ( knife_timer > 15 ) {
						knife_state = 0;
						knife_timer = 0;
						maya_grenade_charge = 0;
					}
				break;
				#endregion
				
				#region Rocket
				case e_gun.grenade:
					if ( knife_timer < 10 ) {
						gun_charge = 0;
						knife_timer = 11;
						
						shoot_press_buffer = 0;
						gun_charge = 30;
						gun_len = 14;
						var drr = point_direction( x, y-gun_height, MX, MY );
						var xx = x+LDX( gun_len, drr );
						var yy = y - gun_height + LDY( gun_len, drr );
			
						var t = ICD( xx, yy, -1, oplayer_maya_star );
						t.charge_level = charge_level;
						t.parent = id;
						t.dmg *= 0.4;
						
						var rep_num = rocket_distance-4;	
						with ( t ) {
							while (rep_num--) {
								if ( rep_num mod 12 == 0 ) {
									with ( create_fx(x+RR(-6,6),y+RR(-6,6),sblink_fx,RR(1,2),random(360),10) ) {
										blendtype = e_blendtype.add;
										image_blend = c_orange;
										
									}
								}
								x += LDX(1,drr);
								y += LDY(1,drr);
								if ( gen_col( x, y ) ) {
									break;
								}
							}
						}
						audio_play_sound_pitch( snd_maya_create_star, RR( 0.9, 1.1 ), 0.95 + random( 0.2 ), 1 );
						audio_play_sound_pitch( snd_shoot_bullet_alt, 0.65,			  0.75 + random( 0.1 ), 1 );
						
						
					}
                    					
					if ( knife_timer > 20 ) {
						knife_state = 0;
						knife_timer = 0;
						maya_grenade_charge = 0;
						RELOAD[e_gun.grenade] = 400;
					}
				break;
				#endregion
				
				#region saw
				case e_gun.flame:
					var charge_pwr_ = lerp( 0.7, 1.3, charge_level );
					if ( knife_timer == 6 ) {
						var spr_ = sbullet_saw_player_aqua;
			            switch(player_id) {
			            	default: spr_ = sbullet_saw_player_aqua;  break;
			            	case 1:  spr_ = sbullet_saw_player_red;   break;
			            	case 2:  spr_ = sbullet_saw_player_lime;  break;
			            	case 3:  spr_ = sbullet_saw_player_white; break;
			            }
			            
						gun_len = 22;
						var drr = point_direction( x, y - gun_height, MX, MY );
						var xx = x + LDX( gun_len, drr );
						var yy = y - gun_height + LDY( gun_len, drr );
						
						var b = bullet_general( 4.25*lerp( 1.1, charge_pwr_, 0.3 )*0.1, 20*charge_pwr_, spr_, 0, ohitbox_saw );
						b.duration         *= 15;
						b.frc               = 0.85;
						b.fully_charged     = true;
						b.multihit          = true;
						b.dir_angle_spin    = RR(7,8);
						b.bounces		    = true;
						b.hsp			    = LDX( b.spd*0.25, b.dir );
						b.vsp			    = LDY( b.spd*0.25, b.dir );
						b.alt_movement      = true;
						b.parent = id;
						b.base_dmg *= 0.3;
						scr_set_size( b, charge_pwr_ *1.1 );
						shoot_delay = 20;
						
						//audio_play_sound_pitch(snd_railgun_shooting,.8,.85+random(.1),1);
						//audio_play_sound_pitch(snd_shoot_1,.25,.75+random(.1),1);
						
						audio_play_sound_pitch( snd_maya_summon_saw, RR( 0.9, 1 ) * 0.8, RR( 0.97, 1.05 ), 0 );
						
						//effect_general(3,12,6);
					}
					if ( knife_timer > 20 ) {
						knife_state = 0;
						knife_timer = 0;
						maya_grenade_charge = 0;
						RELOAD[e_gun.flame] = 500;
					}
				break;
				#endregion
			}
		break;
		case 3:
			
		break;
	}
	
	#endregion
}

function draw_rectangle_ca(x1, y1, x2, y2, color, alpha) {
	draw_set_color(color);draw_set_alpha(alpha);
	draw_rectangle(x1,y1,x2,y2,false);
	draw_set_color(c_white);draw_set_alpha(1);
}