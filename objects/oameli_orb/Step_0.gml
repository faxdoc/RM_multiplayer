
if ( attack_state != e_ameli_orb_attack_state.idle && attack_state != 99 ) {
	
	if ( attack_state == e_ameli_orb_attack_state.active ) {
		attack_alt_cooldown = 105;
	} else {
		attack_alt_cooldown = 40;
	}
	
	
} else if ( attack_alt_cooldown > 0 ) {
	attack_alt_cooldown--;
	if (attack_alt_cooldown <= 0 ) {
		attack_state = e_ameli_orb_attack_state.idle;
	} else {
		attack_state = 99;
	}
}

switch( attack_state ) {
	#region attack state idle
	case e_ameli_orb_attack_state.idle:
		image_xscale = 1;
		image_yscale = 1;
		image_angle = 0;
		
		trap_max_timer = 0;
		attack_timer = 0;
		idle_timer++;
		init_timer = 0;
		depth = 10;
		if ( init ) {
			init = false;
			if ( parent != undefined ) {
				main_blend		= merge_color( parent.player_colour, c_black, 0.3 );
				secondary_blend = merge_color( main_blend, c_black, 0.5 );
			}
		}
		
		if ( instance_exists( parent ) ) {
			target_x = parent.x+00+sin(idle_timer/44)*42;
			target_y = parent.y-29+cos(idle_timer/ 74)*24;
			//depth = parent.depth + sin(idle_timer/64)*12;
			x = lerp(x,target_x, 0.17 );
			y = lerp(y,target_y, 0.17 );
		}
		start_moving_x = x;
		start_moving_y = y;
		move_timer = 0;
		image_alpha = 1;
		hsp = 0;
		vsp = 0;
		intro_timer = 0;
		sticky_target = undefined;
		sprite_index = sameli_orb;
		
	break;
	#endregion
	
	#region attack state active
	case e_ameli_orb_attack_state.active:
		if ( trail_cooldown++ > 2 ) {
			with ( create_fx( 
				x, 
				y,
				sprite_index, 0,
				0,
				depth+1 ) ) {
					image_index = 6;
					type		 = e_fx.fade;
					alpha_mult   = 2;
					duration     = 4;
					image_blend  = other.secondary_blend;
					image_xscale = other.image_xscale;
					image_yscale = other.image_yscale;
			}
			trail_cooldown = 0;
		}
		var mxdr_ = point_direction( parent.x, parent.y, parent.MX, parent.MY );
		var ms_dx_ = parent.x+LDX( 16, mxdr_ );
		var ms_dy_ = parent.y+LDY( 16, mxdr_ )-22;
		
		switch(state) {
			#region Init time bomb
			case e_ameli_orb_state.time_bomb:
				if ( move_timer == 0 ) {
					x = ms_dx_;
					y = ms_dy_;
					var dr_ = point_direction( x, y, parent.MX, parent.MY );
					hsp = LDX( 11, dr_ );
					vsp = LDY( 11, dr_ );
					vsp -= 3;
				}
				depth = -220;
				if ( move_timer < 22 ) {
					if ( move_timer >= 8 ) {
						hsp *= 0.8;
						vsp *= 0.8;
					} else {
						vsp += grav*0.8;
					}
					x += hsp;
					y += vsp;
				}
				move_timer++;
					
				if ( !parent.K1 || move_timer > 55 ) {
					
					if ( move_timer > 55 ) {
						effect_create_depth( -40, ef_ring, MX, MY, 0, merge_colour( main_blend, c_gray, 0.4 ) );
						attack_state = e_ameli_orb_attack_state.passive;
						attack_timer = 0;
						audio_play_sound_pitch( snd_ameli_activate,    RR(0.8,0.9), RR(0.9,1.1), 0 );
					} else if ( move_timer > 5 ) {
						audio_play_sound_pitch( snd_ameli_explotion_1, RR(0.6,0.7), RR(0.95,1.1), 0 );
						var b_ = bullet_general( 12, 0, shitbox_circle, 0 );
						b_.image_xscale = (timed_explotion_radius/96)*0.65;
						b_.image_yscale = (timed_explotion_radius/96)*0.65;
						b_.parent = parent; b_.ghost = true;
						b_.dir = 90;
						b_.knockback *= 2.1;
						b_.stun_mult = 0.5;
						
						with ( parent ) { SHAKE += 1.5; }
						var spd,  dir_, sz_, size_, fx;
						repeat(5) {
			        		spd = 4+random_fixed(2); dir_ = random_fixed(360); sz_ = random_fixed((timed_explotion_radius/4)*0.65); size_ = choose(1,2,3);
			        		fx = create_fx( x + LDX( sz_,dir_) + hsp, y + LDY( sz_,dir_) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
			        		fx.image_blend = main_blend; }
			        	repeat(4) MAKES(ospark_alt);
			        	attack_state = e_ameli_orb_attack_state.idle;
						attack_timer = 0;
						fnc_general_explode( 0.75, 0.75 );
						
					}
					
				}
				// else if ( parent.K7P ) {
				//	effect_create_depth( -40, ef_ring, MX, MY, 0, merge_colour( main_blend, c_gray, 0.4 ) );
				//	attack_state = e_ameli_orb_attack_state.passive;
				//	attack_timer = 0;
				//	
				//}
				
				
			break;
			#endregion
			
			#region Init trap
			case e_ameli_orb_state.trap:
				var alt_col = gen_col_sort( x, y+4+vsp-8, layer_col, 2 ) && !gen_col_sort( x, y-8, layer_col, 2 );
				depth = -220;
				
				//Hold over head
				if ( move_timer < 120 ) {
					x = parent.x;
					y = parent.bbox_top-22;
					move_timer = min(move_timer+2,60);
					var dr_ = point_direction( x, y, parent.MX, parent.MY );
					hsp = LDX( move_timer/8, dr_ );
					vsp = LDY( move_timer/8, dr_ );
					vsp -= 2;
					if ( !parent.K1 ) {
						move_timer = 120;
					}// else if ( parent.K7P ) {
						//attack_state = e_ameli_orb_attack_state.passive;
					//}
					
				} else {
					
					if ( ( gen_col(x,y+1) || alt_col ) ) {
						attack_timer = max( 900, attack_timer+1 );
						if ( attack_timer mod 4 == 3 ) {
							if ( own_hitbox == -1 || !instance_exists( own_hitbox ) ) {
								own_hitbox			= bullet_general( 3, 0, shitbox_circle, 0 );
								own_hitbox.dir		= saw_dir;
								own_hitbox.duration = 3;
								own_hitbox.parent	= parent;
								own_hitbox.ghost	= true;
								own_hitbox.piercing = true;
								own_hitbox.dir = 90;
								own_hitbox.image_xscale = 2;
								own_hitbox.image_yscale = 2;
							}
						}
						if ( attack_timer > 945 ) {
							attack_state = e_ameli_orb_attack_state.idle;
						}
					} else {
						x += hsp;
						y += vsp;
						vsp += grav*0.3;
						if ( attack_timer++ mod 4 == 0 ) {
							if ( own_hitbox == -1 || !instance_exists( own_hitbox ) ) {
								own_hitbox			= bullet_general( 3, 0, shitbox_circle, 0 );
								own_hitbox.dir		= saw_dir;
								own_hitbox.duration = 3;
								own_hitbox.parent	= parent;
								own_hitbox.ghost	= true;
								own_hitbox.piercing = true;
								own_hitbox.image_xscale *= 0.2;
								own_hitbox.image_yscale *= 0.2;
							}
						}
					}
				}
				if ( y > room_height ) {
					attack_state = e_ameli_orb_attack_state.idle;
				}
				
			break;
			#endregion
			
			#region Init bomb
			case e_ameli_orb_state.bomb:
				depth = 20;
				
				x = parent.x;
				y = parent.y-22;
				var dr_ = point_direction( x, y, parent.MX, parent.MY );
				charge_level = 1;
				dmg = 1;
				var ex_dmg = 1;
				var dmg_mult = 1;
				dmg_mult *= ex_dmg;
				shoot_press_buffer = 0;
				gun_charge = 30;
				
				audio_play_sound_pitch( snd_maya_create_star, RR( 0.8, 0.9 ), RR(0.95, 1.1 )*0.85, 0 );
				var mdr_ = point_direction(parent.x,parent.y-22,parent.MX,parent.MY);
				var t = ICD( parent.x+LDX(22,mdr_), parent.y-22+LDY(22,mdr_), -1, ogrenade );
				t.bounce = 0;
				t.hsp  = 0;
				t.vsp  = 0;
				t.grav = 0;
				t.explode_on_ground = true;
				t.explotion_size	= 1.5*ex_dmg;
				t.explode_on_contact = true;
				t.push_player		 = true;
				t.duration			 = 12*ex_dmg;
				t.do_explotion_sound = false;
				t.overide_dir = mdr_;
				
				t.explode_damage = 16*dmg_mult*lerp( 0.8, 1.3, charge_level )*dmg;
				t.sprite_index	 = srocket_alt;
				t.spin			 = 0;
				t.draw_angle	 = image_angle;
				t.duration		 = 0;
				t.parent = parent;
				
				with ( create_fx(t.x,t.y,splayer_maya_cut_cross, 1/ex_dmg, 0,  5 ) ) {
					blendtype = e_blendtype.add;
					image_xscale = 1.25*ex_dmg;
					image_yscale = 1.25*ex_dmg;
				}
				//audio_play_sound_pitch( snd_railg

				attack_state = e_ameli_orb_attack_state.idle;
				
				//if ( move_timer == 0 ) {//
				
					// move_timer = 1;
					// image_xscale = 1.5;
					// image_yscale = 1.5;
					// if ( !parent.K1 ) {
					// 	move_timer = 1;
					// } //else if ( parent.K7P ) {
					// //	attack_state = e_ameli_orb_attack_state.passive;
				//	}
				//} //&&//&/else {
					// if ( own_hitbox == -1 || !instance_exists( own_hitbox ) ) {
						// own_hitbox			= bullet_general( 12, 0, shitbox_circle, 0 );
						// own_hitbox.dir		= 90;
						// own_hitbox.duration = 6;
						// own_hitbox.parent	= parent;
						// own_hitbox.ghost	= true;
						// own_hitbox.piercing = true;
						// own_hitbox.image_xscale *= 2;
						// own_hitbox.image_yscale *= 2;
						// own_hitbox.y += 22;
						// own_hitbox.knockback *= 2;
					// }
					
				
			//	}
				
				
				
			break;
			#endregion
			
			#region Init anti air
			case e_ameli_orb_state.anti_air:
				depth = 50;
				
				if ( move_timer < 300 ) {
					if ( move_timer == 0 ) {
						var szl_ = sign(parent.MX - parent.x);
						x = parent.x+szl_*16;//lerp( x, parent.x+parent.draw_xscale*16, 1 );
						y = parent.y-8;//lerp( y, parent.y, 0.95 );
						hsp = szl_*10;
					} else {
						hsp += sign( parent.MX - parent.x )*0.22;
						hsp *= lerp( frc, 1, 0.55 );
						x += hsp;
					}
					move_timer++;
					if ( !parent.K1 ) {
						move_timer = 300;
					} //else if ( parent.K7P ) {
					//	attack_state = e_ameli_orb_attack_state.passive;
					//}
				} else {
					var b_ = bullet_general( 20, 0, sameli_trap_spear, 0 );
					b_.parent = parent; b_.ghost = true;
					b_.dir			= 90;
					b_.image_angle	= 90;
					b_.duration 	= 60;
					b_.image_xscale = 1.5;
					b_.image_yscale = 1.5;
					b_.knockback	*= 3;
					b_.y += 8;
					
					
					with ( oplayer ) { SHAKE += 1; }
					var spd,  dir_, sz_, size_, fx;
					repeat(5) {
						spd = 4+random_fixed(2); dir_ = random_fixed(360); sz_ = random_fixed(timed_explotion_radius/2); size_ = choose(1,2,3);
						fx = create_fx( x + LDX( sz_,dir_) + hsp, y + LDY( sz_,dir_) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
						fx.image_blend = main_blend; }
					repeat(4) MAKES(ospark_alt);
					attack_state = e_ameli_orb_attack_state.idle;
					attack_timer = 0;
					
				}
				
				if ( y > room_height ) {
					attack_state = e_ameli_orb_attack_state.idle;
				}
				
				// if ( move_timer == 0 ) {
				// 	x = lerp( x, parent.x+parent.draw_xscale*16, 0.95 );
				// 	y = lerp( y, parent.y-22, 0.95 );
				// 	move_timer = 1;
				// }
				// if ( move_timer < 120 ) {
				// 	if ( !gen_col( x, y ) ) {
				// 		vsp += grav*0.8;
				// 		y += vsp;
				// 	} else {
				// 		vsp = 0;
				// 		hsp += sign( parent.MX - parent.x )*0.4;
				// 		hsp *= lerp( frc, 1, 0.8 );
				// 		x += hsp;
						
				// 		if ( !parent.K1 ) {
				// 			state = target_state;
				// 		}
				// 		depth = -220;
				// 	}
				// }
				
			break;
			#endregion
			
			#region Init laser
			case e_ameli_orb_state.beam:
				
				
				if ( attack_timer == 0 ) {
					laser_dir = point_direction( x, y, parent.MX, parent.MY );
				}
				if ( move_timer == 0 ){
					x = parent.x;
					y = parent.y-29;
					audio_play_sound_pitch(snd_maya_blue_overlay, RR(0.8,0.9), RR(0.7,0.75), 1 );
				}
				if ( move_timer <= 60 ) {
					move_timer = min(move_timer+1,60);
					if ( !parent.K1 ) {
						move_timer += 70;
						audio_play_sound_pitch(snd_cute_highpitch, RR(0.8,0.9)*0.3, RR(0.7,0.75)*0.5, 1 );
						audio_play_sound_pitch(snd_ameli_can_deal_damage, RR(0.8,0.9), RR(0.9,0.95), 1 );
					}
				} else if ( attack_timer++ > 25 ) {
					var dir_ = laser_dir;
					// var x_ = x;
					// var y_ = y;
					fnc_general_explode( 0.75, 0.75 );
					
					var charge_ = 0.2 + ( ( move_timer - 70 ) / 60 );
					//audio_play_sound_pitch( snd_ameli_activate,    RR(0.8,0.9)*min(1,charge_*2), RR(0.8,0.86)*0.9, 1, 0.9 );
					audio_play_sound_pitch( snd_ameli_explotion_1, RR(0.8,0.9)*min(1,charge_*2), RR(0.9,1.00)*0.6, 1, 0.9 );
					audio_play_sound_pitch( snd_ameli_explotion_0, RR(0.8,0.9)*min(1,charge_*2), RR(0.9,1.00)*1.1, 1, 0.9 );
					audio_play_sound_pitch( snd_shoot_0, RR(0.8,0.9)*min(0.5,charge_), RR(0.9,1.00), 1, 0.9 );
					
					// repeat( 8 ) {
						var bl_ = bullet_general( 25*charge_, 0, ssameli_beam, 0 );
						bl_.duration	= 10*charge_;
						bl_.parent		= other.parent;
						bl_.dir 		= dir_;
						bl_.ghost		= true;
						bl_.piercing	= true;
						bl_.image_blend  = main_blend;
						bl_.image_yscale = 0.3;
						bl_.knockback = charge_*3.5;
						bl_.image_angle = dir_;
						bl_.image_xscale = 0.05;
						bl_.stun_mult = 0.3;
						bl_.sprite_index = ssameli_beam;
						
						var ww_ = 0;
						with ( bl_ ) {
							var xx_ = x;
							var yy_ = y;
							repeat(64) {
								if ( !gen_col( xx_, yy_ ) ) {
									ww_++;
									xx_ += LDX(8,dir_);
									yy_ += LDY(8,dir_);
								} else {
									break;
								}
							}
						}
						bl_.image_xscale = (ww_/256) * 8;
						bl_.image_yscale = 0.7*charge_;
						// x += LDX( 128, dir_ );
						// y += LDY( 128, dir_ );
					// }
					
					// x = x_;
					// y = y_;
					attack_timer = 0;
					move_timer = 0;
					attack_state = e_ameli_orb_attack_state.idle;
					state = e_ameli_orb_state.idle;
					// if ( charge_ >= .0 ) {
					with ( oplayer ) {
						SHAKE += charge_+0.5;
					}
					// }
					
				}
				
				
				
			break;
			#endregion
			
			#region init saw
			case e_ameli_orb_state.strike:
				
				if ( move_timer < 60 ) {
					with ( parent ) {
						hsp *= 0.6;
						if ( vsp < 0 ) {
							vsp *= 0.8;
						}
					}
					if ( move_timer == 0 ) {
						x = ms_dx_;
						y = ms_dy_;
						saw_dir = point_direction( x, y, parent.MX, parent.MY ); 
						audio_play_sound_pitch(snd_ameli_init_0, RR(0.7,0.9), RR(0.8,0.9),0 );
					}
					move_timer++;
					if ( !parent.K1 ) {
						attack_state = e_ameli_orb_attack_state.passive;
						audio_play_sound_pitch(snd_ameli_init_1, RR(0.7,0.9), RR(0.8,0.9),0 );
						// move_timer = 70;
					}// else if ( parent.K7P ) {
					//	attack_state = e_ameli_orb_attack_state.passive;
				//	}
					
					if ( own_hitbox == -1 || !instance_exists( own_hitbox ) ) {
						own_hitbox			= bullet_general( 4, 0, sbullet_saw_ameli, 0 );
						own_hitbox.dir		= saw_dir;
						own_hitbox.duration = 10;
						own_hitbox.parent	= parent;
						own_hitbox.ghost	= true;
						own_hitbox.piercing = true;
						own_hitbox.delete_other_bullets = true;
					}
					
					saw_dir = angle_approach(saw_dir, point_direction( x, y, parent.MX, parent.MY ), 1.5 );
					
					x += LDX( 1.5,saw_dir )*saw_spd;
					y += LDY( 1.5,saw_dir )*saw_spd;
					image_angle += 3;
					sprite_index = sbullet_saw_ameli;
					
				} else {
					own_hitbox			= bullet_general( 12, 0, sbullet_saw_ameli, 0 );
					own_hitbox.dir		= saw_dir;
					own_hitbox.duration = 8;
					own_hitbox.parent	= parent;
					own_hitbox.ghost	= true;
					own_hitbox.piercing = true;
					own_hitbox.knockback *= 2;
					own_hitbox.stun_mult *= 1.5;
					own_hitbox.image_xscale = 2;
					own_hitbox.image_yscale = 2;
					own_hitbox.delete_other_bullets = true;
					
					with ( oplayer ) {
						SHAKE++;
					}
					attack_state = e_ameli_orb_attack_state.idle;
				}
				
				
			break;
			#endregion
			
		}
	break;
	#endregion
	#region attack state passive
	case e_ameli_orb_attack_state.passive:
		var mxdr_ = point_direction( parent.x, parent.y, parent.MX, parent.MY );
		var ms_dx_ = parent.x+LDX( 16, mxdr_ );
		var ms_dy_ = parent.y+LDY( 16, mxdr_ )-22;
		switch(state) {
			
			#region time bomb
			case e_ameli_orb_state.time_bomb: 
				if ( move_timer < 18 ) {
					if ( move_timer == 0 ) {
						x = ms_dx_;
						y = ms_dy_;
						var dr_ = point_direction( x, y, parent.MX, parent.MY );
						hsp = LDX( 12, dr_ );
						vsp = LDY( 12, dr_ );
						vsp -= 3;
					}
					move_timer++;
					depth = -220;
					if ( move_timer < 18 ) {
						if ( move_timer >= 10 ) {
						hsp *= 0.8;
							vsp *= 0.8;
						} else {
							vsp += grav*1.2;
						}
						x += hsp;
						y += vsp;
					}
					
				} else {
					if ( sticky_target == undefined && place_meeting(x,y,oplayer) ) {
						var t__ = instance_place(x,y,oplayer);
						if ( t__.id != parent ) {
							sticky_target = t__;
							audio_play_sound_pitch( snd_ameli_charge_alt, RR(0.6,0.7), RR(0.95,1.1), 0 );
						}
					} else if ( instance_exists(sticky_target) ) {
						x = sticky_target.x;
						y = sticky_target.y-24;
					}
					
					if ( attack_timer++ > timer_explotion_duration ) {
						var b_ = bullet_general( 24, 0, shitbox_circle, 0 );
						b_.image_xscale = timed_explotion_radius/42;
						b_.image_yscale = timed_explotion_radius/42;
						b_.parent = parent;
						b_.ghost = true;
						b_.knockback *= 3.1;
						b_.stun_mult *= 1.5;
						b_.dir = 90;
						
						audio_play_sound_pitch( snd_ameli_explotion_1, RR(0.6,0.7), RR(0.9,1.1)*0.9, 0 );
						audio_play_sound_pitch( snd_ameli_explotion_0, RR(0.6,0.7), RR(0.9,1.1)*0.9, 0 );
						
						state = e_ameli_orb_state.idle;
						attack_state = e_ameli_orb_attack_state.idle;
						attack_timer = 0;
						with ( parent ) {
							SHAKE += 2;
						}
						fnc_general_explode( 1, 1 );
						repeat( 12 ) {
			        		var spd = 4+random_fixed(2);
			        		var dir_ = random_fixed(360);
			        		var sz_ = random_fixed(timed_explotion_radius/2);
			        		var size_ = choose(1,2,3);
			        		var fx = create_fx( x + LDX( sz_,dir_) + hsp, y + LDY( sz_,dir_) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
			        		fx.image_blend = main_blend;
			        		fx.image_xscale = size_;
							fx.image_yscale = size_;
			        	}
			        	
			        	repeat( 4 ) MAKES(ospark_alt);
			        	repeat( 3 ) MAKES(osmoke);		
					}
				}
			break;
			#endregion
			
			#region trap
			case e_ameli_orb_state.trap: 
				var alt_col = gen_col_sort( x, y+4+vsp-8, layer_col, 2 ) && !gen_col_sort( x, y-8, layer_col, 2 );
				depth = -220;
				move_timer++;
				//Hold over head
				if ( move_timer < 120 ) {
					x = parent.x;
					y = parent.bbox_top-12;
					move_timer = min(move_timer+2,60);
					var dr_ = point_direction( x, y, parent.MX, parent.MY );
					hsp = LDX( move_timer/11, dr_ );
					vsp = LDY( move_timer/11, dr_ );
					vsp -= 2;
					if ( !parent.K1 ) {
						move_timer = 120;
						audio_play_sound_pitch( snd_ameli_init_0, RR(0.6,0.7), RR(0.95,1.1)*1.2, 0 );
					}
				} else if ( move_timer < 900 ) {
					
					if ( ( gen_col(x,y+1) || alt_col ) ) {
						move_timer = 900;
						audio_play_sound_pitch( snd_ameli_charge_alt, RR(0.6,0.7), RR(0.95,1.1), 0 );
					} else {
						x += hsp;
						y += vsp;
						vsp += grav*0.3;
						// if ( attack_timer++ mod 2 == 0 ) {
						if ( own_hitbox == -1 || !instance_exists( own_hitbox ) ) {
							own_hitbox			= bullet_general( 3, 0, shitbox_circle, 0 );
							own_hitbox.dir		= 90;
							own_hitbox.duration = 3;
							own_hitbox.piercing = true;
							own_hitbox.parent	= parent;
							own_hitbox.ghost	= true;
							own_hitbox.piercing = true;
							own_hitbox.stun_mult = 2;
						}
						// }
					}
				} else {
					if ( init_timer < 60 ) {
						init_timer += 3;
						if ( init_timer >= 59 ) {
							audio_play_sound_pitch( snd_ameli_can_deal_damage, RR(0.6,0.7), RR(0.95,1.1), 0 );
						}
					} else {
						// var lt_ = instance_nearest( x, y, oplayer );
						var ld__ = id, pr_ = parent, r_ = spike_trap_size;
						var do_explode = false;
						with ( oplayer ) if ( id != pr_ && distance_to_object(ld__) <= r_ ) do_explode = true;
					
						if ( do_explode ) {
							audio_play_sound_pitch( snd_ameli_activate,    RR(0.8,0.9), RR(0.9,1.1), 0 );
							audio_play_sound_pitch( snd_ameli_explotion_0, RR(0.6,0.7), RR(0.95,1.1), 0 );
							
							var b_ = bullet_general( 23, 0, shitbox_circle, 0 );
							b_.parent = parent;
							b_.ghost = true;
							b_.image_xscale = spike_trap_size/22;
							b_.image_yscale = spike_trap_size/22;
							b_.knockback *= 2.5;
							b_.stun_mult *= 0.6;
							b_.dir = 90;
						
							attack_state = e_ameli_orb_attack_state.idle;
							state = e_ameli_orb_state.idle;
							attack_timer = 0;
						
							with ( oplayer ) {SHAKE += 2;}
							var spd, dir_, sz_, size_, fx;
							repeat(12) {
					    		spd = 4+random_fixed(2);dir_ = random_fixed(360);sz_ = random_fixed(timed_explotion_radius/2);size_ = choose(1,2,3);
					    		fx = create_fx( x + LDX( sz_,dir_) + hsp, y + LDY( sz_,dir_) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
					    		fx.image_blend = main_blend;fx.image_xscale = size_;fx.image_yscale = size_;
					    	}
					    	repeat(3) MAKES(osmoke);
						}
					}
					
				}
				if ( y > room_height ) {
					attack_state = e_ameli_orb_attack_state.idle;
				}
				
				// if (gen_col(x,y+1)) {
				// 	if ( init_timer <= 60 ) {
				// 		init_timer += spike_init_speed;
				// 		if ( init_timer >= 60 ) {
				// 			repeat(6) {
				// 	        	var spd = 4+random_fixed(2);
				// 	        	var dir_ = random_fixed(360);
				// 	        	var sz_ = random_fixed(timed_explotion_radius/2);
				// 	        	var size_ = choose(1,2,3);
				// 	        	var fx = create_fx( x + LDX( sz_,dir_) + hsp, y + LDY( sz_,dir_) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
				// 	        	fx.image_blend = main_blend;
				// 	        	fx.image_xscale = size_;
				// 				fx.image_yscale = size_;
				// 	        }
				//         	with ( parent ) SHAKE++;
				// 		}
				// 	} else {
				// 		var lt_ = instance_nearest( x, y, oplayer );
				// 		if ( distance_to_object( lt_ ) <= spike_trap_size*0.95 ) {
				// 			var b_ = bullet_general( 20, 0, shitbox_circle, 0 );
				// 			b_.parent = parent;
				// 			b_.ghost = true;
				// 			b_.image_xscale = spike_trap_size/24;
				// 			b_.image_yscale = spike_trap_size/24;
				// 			b_.knockback *= 1.5;
				// 			b_.stun_mult *= 2;
				// 			b_.dir = 90;
							
				// 			attack_state = e_ameli_orb_attack_state.idle;
				// 			state = e_ameli_orb_state.idle;
				// 			attack_timer = 0;
							
				// 			with ( oplayer ) {SHAKE += 2;}
				// 			var spd, dir_, sz_, size_, fx;
				// 			repeat(12) {
				// 	    		spd = 4+random_fixed(2);dir_ = random_fixed(360);sz_ = random_fixed(timed_explotion_radius/2);size_ = choose(1,2,3);
				// 	    		fx = create_fx( x + LDX( sz_,dir_) + hsp, y + LDY( sz_,dir_) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
				// 	    		fx.image_blend = main_blend;fx.image_xscale = size_;fx.image_yscale = size_;
				// 	    	}
				// 	    	repeat(3) MAKES(osmoke);
				// 		}
				// 	}
				// } else {
				// 	x += hsp;
				// 	hsp *= 0.99;
				// 	vsp = max(-3,vsp);
				// 	vsp += grav*0.3;
				// 	y += vsp;
				// }
				
			break;
			#endregion
			
			#region trap triggered
			case e_ameli_orb_state.trap_triggered:
				if ( triggered_timer++ > 20 ) {
					state = e_ameli_orb_state.idle;
					triggered_timer = 0;
				}
			break;
			#endregion	
			
			#region bomb
			case e_ameli_orb_state.bomb: 
				
				if ( move_timer == 0 ) {
					x = parent.x;
					y = parent.bbox_top-22;
					var dr_ = point_direction( x, y, parent.MX, parent.MY );
					hsp = LDX( 4, dr_ );
					vsp = LDY( 4, dr_ );
					vsp -= 3;
					// move_timer = 1;
					sprite_index = sameli_bomb; 
					image_xscale = 2;
					image_yscale = 2;
					if ( !parent.K7 ) {
						var dr__ = point_direction(x, y, parent.x, parent.y-22);
						var ii = 32; while ( gen_col(x,y+1) && ii-- ) {
							x += LDX(3,dr__);
							y += LDY(1,dr__);
						}
						move_timer = 1;
						audio_play_sound_pitch( snd_ameli_init_0, RR(0.6,0.7), RR(0.95,1.1)*1.2, 0 );
					} //else if ( parent.K7P ) {
					//	attack_state = e_ameli_orb_attack_state.passive;
				//	}
				} else {
				
					vsp += grav* 0.25; 
					if ( gen_col(x,y+vsp*2) ) {
						if ( vsp > 0 ) {
							while ( !gen_col(x,y+1)) {
								y++;
							}
						} else {
							while ( !gen_col(x,y-1)) {
								y--;
							}
						}
						audio_play_sound_pitch( snd_grenade_bounce, RR( 0.4, 0.5 ), RR( 0.95, 1.1 ), 0 );
						
						vsp = -vsp *0.9;
						hsp *= 0.8;
					}
					
					if ( gen_col(x+hsp*2,y) ) {
						hsp = -hsp*0.9;
						audio_play_sound_pitch( snd_grenade_bounce, RR( 0.4, 0.5 ), RR( 0.95, 1.1 ), 0 );
					}
						
					if ( hitfreeze ) {
						hitfreeze--;
					} else {
						x += hsp;
						y += vsp;
					}
					if ( move_timer++ > 240 ) {
						state = e_ameli_orb_state.idle;
						attack_state = e_ameli_orb_attack_state.idle;
						image_xscale = 1;
						image_yscale = 1;
						sprite_index = sameli_orb;
					}
					if ( place_meeting(x,y,par_hitbox) ) {
						audio_play_sound_pitch( snd_maya_hit_ball, RR( 0.4, 0.5 ), RR( 0.95, 1.1 ), 0 );
						var t_ = instance_place( x, y, par_hitbox );
						if ( t_ != last_knockbox ) {
							var kn_dir = point_direction(x,y,t_.x,t_.y);
							hsp += LDX( -t_.knockback*1.3, kn_dir );
							vsp += LDY( -t_.knockback*1.3, kn_dir );
							vsp -= 1;
							last_knockbox = t_;
							hitfreeze = 3;
							
						}
						
					}
					
					if ( place_meeting( x, y, oplayer ) ) {
						var tl__ = instance_place( x, y, oplayer );
						if ( tl__ != parent ) {
							audio_play_sound_pitch( snd_ameli_explotion_1, RR(0.6,0.7), RR(0.9,1.1)*0.9, 0 );
							audio_play_sound_pitch( snd_ameli_explotion_0, RR(0.6,0.7), RR(0.9,1.1)*0.9, 0 );
							state = e_ameli_orb_state.idle;
							attack_state = e_ameli_orb_attack_state.idle;
							image_xscale = 1;
							image_yscale = 1;
							sprite_index = sameli_orb;
							with ( bullet_general( 20 , 0, shitbox, 0 ) ) {
								parent = other.parent;
								knockback *= 2.5;
								duration = 4;
								dir = 90;
								image_xscale = 1.5;
								image_yscale = 1.5;
								stun_mult *= 1.1;
							}
						}
					}
				}
				
				// if ( init_timer <= 10 ) {
				// 	init_timer++;
				// 	if ( init_timer == 10 ) {
						
				// 	}
				// } else {
				// 	if ( attack_timer++ < 60 ) {
				// 		var b_ = 	bullet_general( 20, 0, shitbox_circle, 0 );
				// 		b_.parent = parent;
				// 		b_.ghost = true;
				// 	}
				// 	scr_collision();
				// 	vsp += grav;
				// }
				if ( y > room_height ) {
					state = e_ameli_orb_state.idle;
					attack_state = e_ameli_orb_attack_state.idle;
				}
			break;
			#endregion
			
			
		#region anti_air
		case e_ameli_orb_state.anti_air: 
			// image_xscale = 1.5;
			// image_yscale = 1.75;
			// if ( init_timer <= 60 ) {
			// 	var i = 0; repeat(8) {
			// 		if ( gen_col(x,y+i*12) ) {
			// 			y -= 6;
			// 		}
			// 		i++;
			// 	}
			// 	init_timer = 70;
			// 	if ( init_timer >= 60 ) {
			// 		sprite_index = sameli_orb_anti_air;
			// 		repeat(6) {
			//         	var spd = 4+random_fixed(2);
			//         	var dir_ = random_fixed(360);
			//         	var sz_ = random_fixed(timed_explotion_radius/2);
			//         	var size_ = choose(1,2,3);
			//         	var fx = create_fx( x + LDX( sz_,dir_) + hsp, y + LDY( sz_,dir_) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
			//         	fx.image_blend = main_blend;
			//         	fx.image_xscale = size_;
			// 			fx.image_yscale = size_;
			//         }
		 //       	with ( parent ) SHAKE++;
			// 	}
			// } else {
			if ( move_timer < 100 ) {
				if ( move_timer == 0 ) {
					var szl_ = sign(parent.MX - parent.x);
					x = parent.x-szl_*6;//lerp( x, parent.x+parent.draw_xscale*16, 1 );
					y = parent.y+4;//lerp( y, parent.y, 0.95 );
					hsp = szl_*14;
				} else {
					hsp += sign( parent.MX - parent.x )*0.12;
					hsp *= lerp( frc, 1, 0.55 );
					x += hsp;
				}
				move_timer++;
				if ( !parent.K1 ) {
					move_timer = 100;
					audio_play_sound_pitch( snd_ameli_charge,		irandom_range_fixed(0.8,0.9), irandom_range_fixed(0.95,1.1), 0 );
					audio_play_sound_pitch( snd_ameli_charge_alt,	irandom_range_fixed(0.8,0.9), irandom_range_fixed(0.95,1.1), 0 );
					
				} //else if ( parent.K7P ) {
				//	attack_state = e_ameli_orb_attack_state.passive;
				//}
				image_xscale = 1;
				image_yscale = 1;
			} else {
				
			sprite_index = sameli_trap_spear;
			if ( move_timer++ > 195 ) {
				image_xscale *= 0.95;
				image_yscale *= 0.8;
			}
			if ( move_timer == 118 ) {
				audio_play_sound_pitch( snd_ameli_can_deal_damage, RR(0.6,0.7), RR(0.95,1.1), 0 );
				with ( parent ) SHAKE++;
			} 
			image_angle = 90;
			if ( image_yscale < 0.15 ) {
				attack_timer = 0;
				state = e_ameli_orb_state.idle;
				attack_state = e_ameli_orb_attack_state.idle;
				//image_xscale = 1;
			} else if ( move_timer > 118 ) {
			
				var tl_ = instance_place(x,y,oplayer);
				if ( tl_ ) {
					if (tl_ == parent) {
						parent.vsp = min(-7,parent.vsp-5);
						parent.space_buffer = true;
					}
					audio_play_sound_pitch( snd_ameli_activate,    RR(0.8,0.9), RR(0.9,1.1),  2 );
					audio_play_sound_pitch( snd_ameli_explotion_1, RR(0.6,0.7), RR(0.95,1.1), 2 );
							
					var b_ = bullet_general( 10, 0, sameli_trap_spear, 0 );
					b_.parent = parent;
					b_.ghost = true;
					b_.dir = 90+15;
					b_.image_xscale = 1.2;
					b_.image_yscale = 1.2;
					b_.image_angle = 15;
					b_.knockback *= 3;
					b_.stun_mult *= 1.1;
					b_.piercing = true;
					b_.image_angle = b_.dir;
					b_.duration *= 3;
				
					var b_ = bullet_general( 10, 0, sameli_trap_spear, 0 );
					b_.parent = parent;
					b_.ghost = true;
					b_.dir  = 90-15;
					b_.image_xscale = 1.2;
					b_.image_yscale = 1.2;
					b_.image_angle = -15;
					b_.knockback *= 3;
					b_.stun_mult *= 1.1;
					b_.piercing = true;
					b_.image_angle = b_.dir;
					b_.duration *= 3;
				
					var b_ =bullet_general( 10, 0, sameli_trap_spear, 0 );		
					b_.parent = parent;
					b_.ghost = true;
					b_.dir = 90;
					b_.image_xscale = 1.5;
					b_.image_yscale = 1.5;
					b_.image_angle = b_.dir;
					b_.knockback *= 3;
					b_.stun_mult *= 1.1;
					b_.piercing = true;
					b_.duration *= 3;
			
					attack_timer = 0;
					state = e_ameli_orb_state.idle;
					attack_state = e_ameli_orb_attack_state.idle;
					sprite_index = sameli_orb;
			
					with ( oplayer ) {
						SHAKE += 2;
					}
			
					repeat(8) {
						var spd = 4+random_fixed(2);
						var dir_ = random_fixed(360);
						var sz_ = random_fixed(timed_explotion_radius/2);
						var size_ = choose(1,2,3);
						var fx = create_fx( x + LDX( sz_,dir_) + hsp, y + LDY( sz_,dir_) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
						fx.image_blend = main_blend;
						fx.image_xscale = size_;
						fx.image_yscale = size_;
			        }
		        
			        repeat(4) MAKES(ospark_alt);
			        repeat(3) MAKES(osmoke);
				}
				}
			}
			
		break;
		#endregion
		
		#region anti_air_trigger
		case e_ameli_orb_state.anti_air_triggered:
			if ( triggered_timer++ > 20 ) {
				state = e_ameli_orb_state.idle;
				triggered_timer = 0;
			}
			sprite_index = sameli_orb;
			image_xscale = 1;
			image_yscale = 1;
		break;
		#endregion	
		
		#region beam
		case e_ameli_orb_state.beam:
		
			if ( parent.K1 && attack_timer == 0 ) {
				//if ( attack_timer >= 60 ) {
				//	laser_dir = angle_approach( laser_dir, point_direction( x, y, parent.MX, parent.MY ), 1 );
				//} else {
					laser_dir = point_direction( x, y, parent.MX, parent.MY );//angle_approach( laser_dir, point_direction( x, y, parent.MX, parent.MY ), 4 );
				//}
				
			}
			
			if ( attack_timer >= 120 ) {
				
				// if ( !parent.K1 ) {
					var i = 0; 
					var dir_ = laser_dir;
					var x_ = x;
					var y_ = y;
					repeat( 12 ) {
						var bl_ = bullet_general( 12, 0, ssameli_beam, 0 );
						bl_.duration = 30;
						bl_.parent = other.parent;
						bl_.dir = dir_;
						bl_.ghost = true;
						bl_.piercing = true;
						bl_.image_blend = main_blend;
						bl_.image_yscale = 0.5;
						bl_.knockback = 5;
						bl_.image_angle = dir_;
						
						x += LDX( 128, dir_ );
						y += LDY( 128, dir_ );
						i++;
					}
					
					x = x_;
					y = y_;
					attack_timer = 0;
					attack_state = e_ameli_orb_attack_state.idle;
					state = e_ameli_orb_state.idle;
					with ( oplayer ) {
						SHAKE += 2;
					}
					
				// }
			} else if ( !parent.K1 || attack_timer > 0 ) {
				attack_timer++;
			}
			
		break;
		#endregion
		
		#region saw
		case e_ameli_orb_state.strike: 
			// if ( move_timer == 0 ) {
			// 	x = ms_dx_;
			// 	y = ms_dy_;
			// 	move_timer = 1;
			// 	saw_dir = point_direction( x, y, parent.MX, parent.MY ); 
			// }
					
			if ( attack_timer++ > 30 ) {
				attack_state = e_ameli_orb_attack_state.idle;
				state = e_ameli_orb_state.idle;
				sprite_index = sameli_orb;
				own_hitbox			= bullet_general( 12, 0, sbullet_saw_ameli, 0 );
				own_hitbox.dir		= saw_dir;
				own_hitbox.duration = 8;
				own_hitbox.parent	= parent;
				own_hitbox.ghost	= true;
				own_hitbox.piercing = true;
				own_hitbox.knockback *= 2;
				own_hitbox.stun_mult *= 1.5;
				own_hitbox.image_xscale = 2;
				own_hitbox.image_yscale = 2;
				own_hitbox.delete_other_bullets = true;
				own_hitbox.dir = 90;
				audio_play_sound_pitch(snd_ameli_explotion_1, RR(0.7,0.9), RR(0.8,0.9),0 );
				with ( parent ) SHAKE += 2;
				with ( oplayer ) {
					SHAKE++;
				}
				fnc_general_explode( 1.00, 1.00 );
			}
			if ( own_hitbox == -1 || !instance_exists( own_hitbox ) ) {
				own_hitbox = bullet_general(4,0,sbullet_saw_ameli,0);
				own_hitbox.dir = saw_dir;
				own_hitbox.duration = 9;
				own_hitbox.parent = parent;
				own_hitbox.ghost = true;
				own_hitbox.piercing = true;
				own_hitbox.delete_other_bullets = true;
				own_hitbox.dir = 90;
					
				
			}
			x += LDX( (( 30-attack_timer ) / 45)*saw_spd, saw_dir );
			y += LDY( (( 30-attack_timer ) / 45)*saw_spd, saw_dir );
		break;
		#endregion
		
		}
	break;
	#endregion
	
}

if ( attack_state == e_ameli_orb_attack_state.idle ) {
	image_blend = merge_colour( main_blend, c_dkgray, 0.6 );
} else {
	image_blend = main_blend;	
}

