switch( attack_state ) {
	#region attack state idle
	case e_ameli_orb_attack_state.idle:
		image_xscale = 1;
		image_yscale = 1;
		
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
		
		switch(state) {
			#region Init time bomb
			case e_ameli_orb_state.time_bomb:
				if ( move_timer == 0 ) {
					var dr_ = point_direction( x, y, parent.MX, parent.MY );
					hsp = LDX( 10, dr_ );
					vsp = LDY( 10, dr_ );
					vsp -= 3;
				}
				depth = -220;
				if ( move_timer < 15 ) {
					move_timer++;
					x += hsp;
					y += vsp;
				}
				if ( !parent.K1 ) {
					var b_ = bullet_general( 20, 0, shitbox_circle, 0 );
					b_.image_xscale = timed_explotion_radius/96;
					b_.image_yscale = timed_explotion_radius/96;
					b_.parent = parent; b_.ghost = true;
					with ( oplayer ) { SHAKE += 1; }
					var spd,  dir_, sz_, size_, fx;
					repeat(5) {
		        		spd = 4+random_fixed(2); dir_ = random_fixed(360); sz_ = random_fixed(timed_explotion_radius/2); size_ = choose(1,2,3);
		        		fx = create_fx( x + LDX( sz_,dir_) + hsp, y + LDY( sz_,dir_) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
		        		fx.image_blend = main_blend; }
		        	repeat(4) MAKES(ospark_alt);
		        	state = e_ameli_orb_state.idle;
					attack_timer = 0;
				} else if ( parent.K7P ) {
					attack_state = e_ameli_orb_attack_state.passive;
					attack_timer = 0;
				}
				
				
			break;
			#endregion
			
			#region Init trap
			case e_ameli_orb_state.trap:
				var alt_col = gen_col_sort( x, y+2+vsp, layer_col, 2 ) && !gen_col_sort( x, y, layer_col, 2 );
				depth = -220;
				
				//Hold over head
				if ( move_timer < 120 ) {
					x = parent.x;
					y = parent.bbox_top-22;
					move_timer = min(move_timer+2,60);
					var dr_ = point_direction( x, y, parent.MX, parent.MY );
					hsp = LDX( move_timer/12, dr_ );
					vsp = LDY( move_timer/12, dr_ );
					vsp -= 2;
					if ( !parent.K1 ) {
						move_timer = 120;
					} else if ( parent.K7P ) {
						attack_state = e_ameli_orb_attack_state.passive;
					}
					
				} else {
					
					if (!( gen_col(x,y+1) || alt_col ) ) {
						attack_timer = max( 600, attack_timer+1 );
						if ( move_timer mod 4 == 3 ) {
							if ( own_hitbox == -1 || !instance_exists( own_hitbox ) ) {
								own_hitbox			= bullet_general( 3, 0, shitbox_circle, 0 );
								own_hitbox.dir		= saw_dir;
								own_hitbox.duration = 3;
								own_hitbox.parent	= parent;
								own_hitbox.ghost	= true;
								own_hitbox.piercing = true;
							}
						}
						if ( attack_timer > 660 ) {
							attack_state = e_ameli_orb_attack_state.passive;
						}
					} else {
						x += hsp;
						y += vsp;
						vsp += grav*0.4;
						if ( move_timer++ mod 4 == 0 ) {
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
				
				if ( move_timer == 0 ) {
					x = parent.x;
					y = parent.bbox_top-22;
					var dr_ = point_direction( x, y, parent.MX, parent.MY );
					hsp = LDX( 2, dr_ );
					vsp = LDY( 2, dr_ );
					vsp -= 4;
					// move_timer = 1;
					sprite_index = sameli_bomb; 
					image_xscale = 1.5;
					image_yscale = 1.5;
					parent.vsp -= 4;
					
					if ( !parent.K1 ) {
						move_timer = 1;
					} else if ( parent.K7P ) {
						
					}
				} else {
					if ( own_hitbox == -1 || !instance_exists( own_hitbox ) ) {
						own_hitbox			= bullet_general( 6, 0, shitbox_circle, 0 );
						own_hitbox.dir		= saw_dir;
						own_hitbox.duration = 6;
						own_hitbox.parent	= parent;
						own_hitbox.ghost	= true;
						own_hitbox.piercing = true;
						own_hitbox.image_xscale *= 1.5;
						own_hitbox.image_yscale *= 1.5;
					}
					attack_state = e_ameli_orb_attack_state.idle;
				}
				
				//vsp += grav* 0.25; 
				//if ( gen_col(x,y+vsp*2) ) {
				//	vsp = -vsp *0.9;
				//	hsp *= 0.8;
				//}
				//if ( hitfreeze ) {
				//	hitfreeze--;
				//} else {
				//	x += hsp;
				//	y += vsp;
				//}
				//if ( move_timer++ > 300 ) {
				//	state = e_ameli_orb_state.idle;
				//	image_xscale = 1;
				//	image_yscale = 1;
				//	sprite_index = sameli_orb;
				//}
				//if ( place_meeting(x,y,par_hitbox) ) {
				//	var t_ = instance_place(x,y,par_hitbox);
				//	if ( t_ != last_knockbox ) {
				//		hsp += LDX( t_.knockback*1.3, t_.dir );
				//		vsp += LDY( t_.knockback*1.3, t_.dir );
				//		vsp -= 1;
				//		last_knockbox = t_;
				//		hitfreeze = 3;
				//		
				//	}
				//	
				//}
				//if ( place_meeting( x, y, oplayer ) ) {
				//	
				//	var tl__ = instance_place( x, y, oplayer );
				//	
				//	if ( tl__ != parent ) {
				//		state = e_ameli_orb_state.idle;
				//		
				//		image_xscale = 1;
				//		image_yscale = 1;
				//		sprite_index = sameli_orb;
				//		with ( bullet_general( 20 , 0, shitbox, 0 ) ) {
				//			parent = other.parent;
				//			knockback *= 1.5;
				//			duration = 4;
				//			dir = 90;
				//			knockback *= 1.5;
				//			stun_mult *= 2;
				//		}
				//	}
				//}
				
			break;
			#endregion
			
			#region Init anti air
			case e_ameli_orb_state.anti_air:
				depth = 50;
				
				if ( move_timer == 0 ) {
					
					if ( !parent.K1 ) {
						move_timer = 1;
					} else if ( parent.K7P ) {
						attack_state = e_ameli_orb_attack_state.passive;
					}
				} else {
					var b_ = bullet_general( 20, 0, sameli_trap_spear, 0 );
					b_.parent = parent; b_.ghost = true;
					with ( oplayer ) { SHAKE += 1; }
					var spd,  dir_, sz_, size_, fx;
					repeat(5) {
						spd = 4+random_fixed(2); dir_ = random_fixed(360); sz_ = random_fixed(timed_explotion_radius/2); size_ = choose(1,2,3);
						fx = create_fx( x + LDX( sz_,dir_) + hsp, y + LDY( sz_,dir_) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
						fx.image_blend = main_blend; }
					repeat(4) MAKES(ospark_alt);
					state = e_ameli_orb_state.idle;
					attack_timer = 0;
				}
				if ( y > room_height ) {
					attack_state = e_ameli_orb_state.idle;
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
			
				if ( move_timer <= 60 ) {
					move_timer = min(move_timer+1,60);
					if ( !parent.K1 ) {
						move_timer += 70;
					} else if ( parent.K7P ) {
						attack_state = e_ameli_orb_attack_state.passive;
					}
				} else {
					var dir_ = laser_dir;
					var x_ = x;
					var y_ = y;
					var charge_ = 0.2 + (( move_timer - 70 ) / 60);
					repeat( 8 ) {
						var bl_ = bullet_general( 10*charge_, 0, ssameli_beam, 0 );
						bl_.duration = 30*charge_;
						bl_.parent = other.parent;
						bl_.dir = dir_;
						bl_.ghost = true;
						bl_.piercing = true;
						bl_.image_blend = main_blend;
						bl_.image_yscale = 0.5*charge_;
						bl_.knockback = 5;
						bl_.image_angle = dir_;
						
						x += LDX( 128, dir_ );
						y += LDY( 128, dir_ );
						i++;
					}
					x = x_;
					y = y_;
					attack_timer = 0;
					attack_state = e_ameli_orb_state.idle;
					with ( oplayer ) {
						SHAKE += 2;
					}
				}
				laser_dir = point_direction( x, y, parent.MX, parent.MY );
				// if ( parent.K1 ) {
				// 	if ( intro_timer++ > 30 ) {
				// 		state = target_state;
				// 	}
				// } else {
				// 	intro_timer = 0;
				// 	state = e_ameli_orb_state.idle;
				// }
			break;
			#endregion
			
			#region init saw
			case e_ameli_orb_state.strike:
				
				if ( move_timer < 60 ) { 
					if ( move_timer == 0 ) {
						move_timer = 1;
						saw_dir = point_direction( x, y, parent.MX, parent.MY ); 
					}
					if ( !parent.K1 ) {
						move_timer = 70;
					} else if ( parent.K7P ) {
						attack_state = e_ameli_orb_attack_state.passive;
					}
					
					if ( own_hitbox == -1 || !instance_exists( own_hitbox ) ) {
						own_hitbox			= bullet_general( 4, 0, shitbox, 0 );
						own_hitbox.dir		= saw_dir;
						own_hitbox.duration = 4;
						own_hitbox.parent	= parent;
						own_hitbox.ghost	= true;
						own_hitbox.piercing = true;
					}
					
					saw_dir = angle_approach(saw_dir, point_direction( x, y, parent.MX, parent.MY ), 1 );
					
					x += LDX( 1.5,saw_dir )*saw_spd;
					y += LDY( 1.5,saw_dir )*saw_spd;
					image_angle += 3;
					sprite_index = sbullet_saw_ameli;
					
				} else {
					
				}
			break;
			#endregion
			
		}
	break;
	#endregion
	#region attack state passive
	case e_ameli_orb_attack_state.passive:
		switch(state) {
			
			#region time bomb
			case e_ameli_orb_state.time_bomb: 
				if ( sticky_target == undefined && place_meeting(x,y,oplayer) ) {
					var t__ = instance_place(x,y,oplayer);
					if ( t__.id != parent ) {
						sticky_target = t__;
					}
				} else if ( instance_exists(sticky_target) ) {
					x = sticky_target.x;
					y = sticky_target.y-24;
				}
				
				if ( attack_timer++ > timer_explotion_duration ) {
					var b_ = bullet_general( 20, 0, shitbox_circle, 0 );
					b_.image_xscale = timed_explotion_radius/64;
					b_.image_yscale = timed_explotion_radius/64;
					b_.parent = parent;
					b_.ghost = true;
					b_.knockback *= 1.5;
					b_.stun_mult *= 2;
						
					state = e_ameli_orb_state.idle;
					attack_timer = 0;
					with ( oplayer ) {
						SHAKE += 2;
					}
					repeat(12) {
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
			break;
			#endregion
			
			#region trap
			case e_ameli_orb_state.trap: 
				if ( init_timer <= 60 ) {
					
					init_timer += spike_init_speed;
					if ( init_timer >= 60 ) {
						repeat(6) {
				        	var spd = 4+random_fixed(2);
				        	var dir_ = random_fixed(360);
				        	var sz_ = random_fixed(timed_explotion_radius/2);
				        	var size_ = choose(1,2,3);
				        	var fx = create_fx( x + LDX( sz_,dir_) + hsp, y + LDY( sz_,dir_) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
				        	fx.image_blend = main_blend;
				        	fx.image_xscale = size_;
							fx.image_yscale = size_;
				        }
			        	with ( parent ) SHAKE++;
					}
			        
				} else {
					var lt_ = instance_nearest( x, y, oplayer );
					if ( distance_to_object( lt_ ) <= spike_trap_size*0.95 ) {
						var b_ = bullet_general( 20, 0, shitbox_circle, 0 );
						b_.parent = parent;
						b_.ghost = true;
						b_.image_xscale = spike_trap_size/24;
						b_.image_yscale = spike_trap_size/24;
						b_.knockback *= 1.5;
						b_.stun_mult *= 2;
						
						state = e_ameli_orb_state.trap_triggered;
						attack_timer = 0;
						
					with ( oplayer ) {
						SHAKE += 2;
					}
					repeat(12) {
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
				if ( init_timer <= 10 ) {
					init_timer++;
					if ( init_timer == 10 ) {
						
					}
				} else {
					if ( attack_timer++ < 60 ) {
						var b_ = 	bullet_general( 20, 0, shitbox_circle, 0 );
						b_.parent = parent;
						b_.ghost = true;
					}
					scr_collision();
					vsp += grav;
				}
			break;
			#endregion
			
			
		#region anti_air
		case e_ameli_orb_state.anti_air: 
		
			if ( init_timer <= 60 ) {
				var i = 0; repeat(8) {
					if ( gen_col(x,y+i*12) ) {
						y -= 6;
					}
					i++;
				}
				init_timer = 70;
				if ( init_timer >= 60 ) {
					sprite_index = sameli_orb_anti_air;
					repeat(6) {
			        	var spd = 4+random_fixed(2);
			        	var dir_ = random_fixed(360);
			        	var sz_ = random_fixed(timed_explotion_radius/2);
			        	var size_ = choose(1,2,3);
			        	var fx = create_fx( x + LDX( sz_,dir_) + hsp, y + LDY( sz_,dir_) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
			        	fx.image_blend = main_blend;
			        	fx.image_xscale = size_;
						fx.image_yscale = size_;
			        }
		        	with ( parent ) SHAKE++;
				}
		        
			} else {
				if ( trap_max_timer++ > trap_max_timer_cap ) {
					attack_timer = 0;
					state = e_ameli_orb_state.idle;
					sprite_index = sameli_orb;
				} else {
				// image_xscale = 1.5;
				// image_yscale = 1.75;
					if ( place_meeting( x, y, oplayer ) ) {
						var b_ = bullet_general( 20, 0, sameli_trap_spear, 0 );
						b_.parent = parent;
						b_.ghost = true;
						b_.dir = 15;
						b_.image_xscale = 3;
						b_.image_yscale = 3;
						b_.image_angle = 15;
						b_.knockback *= 3;
						b_.stun_mult *= 2;
					
						var b_ =bullet_general( 20, 0, sameli_trap_spear, 0 );
						b_.parent = parent;
						b_.ghost = true;
						b_.dir  = -15;
						b_.image_xscale = 3;
						b_.image_yscale = 3;
						b_.image_angle = -15;
						b_.knockback *= 3;
						b_.stun_mult *= 2;
					
						var b_ =bullet_general( 20, 0, sameli_trap_spear, 0 );		
						b_.parent = parent;
						b_.ghost = true;
						b_.dir = 0;
						b_.image_xscale = 3;
						b_.image_yscale = 3;
						b_.image_angle = 0;
						b_.knockback *= 3;
						b_.stun_mult *= 2;
					
						attack_timer = 0;
						state = e_ameli_orb_state.anti_air_triggered;
						sprite_index = sameli_orb;
					
						with ( oplayer ) {
							SHAKE += 2;
						}
					
						repeat(12) {
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
					laser_dir = angle_approach( laser_dir, point_direction( x, y, parent.MX, parent.MY ), 2 );
				//}
				
			}
			
			if ( attack_timer >= 60 ) {
				
				if ( !parent.K1 ) {
					var i = 0; 
					var dir_ = laser_dir;
					var x_ = x;
					var y_ = y;
					repeat( 12 ) {
						var bl_ = bullet_general( 10, 0, ssameli_beam, 0 );
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
					state = e_ameli_orb_state.idle;
					with ( oplayer ) {
						SHAKE += 2;
					}
					
				}
			} else if (!parent.K1) {
				attack_timer++;
			}
			
		break;
		#endregion
		
		#region saw
		case e_ameli_orb_state.strike: 
			if ( attack_timer++ > 90 ) {
				state = e_ameli_orb_state.idle;
				sprite_index = sameli_orb;
			}
			if ( own_hitbox == -1 || !instance_exists( own_hitbox ) ) {
				own_hitbox = bullet_general(5,0,shitbox,0);
				own_hitbox.dir = saw_dir;
				own_hitbox.duration = 4;
				own_hitbox.parent = parent;
				own_hitbox.ghost = true;
				own_hitbox.piercing = true;
					
				
			}
			x += LDX( (( 90-attack_timer ) / 45)*saw_spd, saw_dir );
			y += LDY( (( 90-attack_timer ) / 45)*saw_spd, saw_dir );
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

