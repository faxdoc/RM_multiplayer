switch( state ) {
	#region idle
	case e_ameli_orb_state.idle:
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
	break;
	#endregion
	
	#region init
	case e_ameli_orb_state.init:
		
		
		if ( trail_cooldown++ > 1 ) {
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
		
		switch(target_state) {
			#region Init time bomb
			case e_ameli_orb_state.time_bomb:
				if ( move_timer == 0 ) {
					var dr_ = point_direction( x, y, parent.MX, parent.MY );
					hsp = LDX( 5, dr_ );
					vsp = LDY( 5, dr_ );
					vsp -= 3;
				}
				depth = -220;
				x += hsp;
				y += vsp;
				vsp += grav*0.3;
				move_timer++;
				if ( move_timer > 30 ) {
					state = target_state;
				}
			break;
			#endregion
			#region Init trap
			case e_ameli_orb_state.trap:
				var alt_col = gen_col_sort( x, y+2+vsp, layer_col, 2 ) && !gen_col_sort( x, y, layer_col, 2 );
				depth = -220;	
				if ( move_timer < 120 ) {
					x = parent.x;
					y = parent.bbox_top-22;
					move_timer = min(move_timer+1,60);
					var dr_ = point_direction( x, y, parent.MX, parent.MY );
					hsp = LDX( move_timer/12, dr_ );
					vsp = LDY( move_timer/12, dr_ );
					vsp -= 2;
					if (!parent.K1) {
						move_timer = 120;
					}
				} else {
					x += hsp;
					y += vsp;
					vsp += grav*0.3;
					if ( gen_col(x,y+1) || alt_col ) {
						state = target_state;
					}
				}
				if ( y > room_height ) state = e_ameli_orb_state.idle;
				
			break;
			#endregion
			
			#region Init bomb
			case e_ameli_orb_state.bomb:
				depth = 20;
				if ( move_timer < 1 ) {
					x = parent.x;
					y = parent.bbox_top-22;
					// move_timer = min(move_timer+1,60);
					var dr_ = point_direction( x, y, parent.MX, parent.MY );
					hsp = LDX( 1, dr_ );
					vsp = LDY( 1, dr_ );
					vsp -= 4;
					move_timer = 1;
					sprite_index = sameli_bomb; 
					image_xscale = 1.5;
					image_yscale = 1.5;
					parent.vsp -= 4;
					
				} else {
					vsp += grav* 0.25; 
					if ( gen_col(x,y+vsp*2) ) {
						vsp = -vsp *0.9;
						hsp *= 0.8;
					}
					if ( hitfreeze ) {
						hitfreeze--;
					} else {
						x += hsp;
						y += vsp;
					}
					if ( move_timer++ > 300 ) {
						state = e_ameli_orb_state.idle;
						image_xscale = 1;
						image_yscale = 1;
						sprite_index = sameli_orb;
					}
					if ( place_meeting(x,y,par_hitbox) ) {
						var t_ = instance_place(x,y,par_hitbox);
						if ( t_ != last_knockbox ) {
							hsp += LDX( t_.knockback*1.1, t_.dir );
							vsp += LDY( t_.knockback*1.1, t_.dir );
							vsp -= 1;
							last_knockbox = t_;
							hitfreeze = 3;
						}
						
					}
					if ( place_meeting( x, y, oplayer ) ) {
						
						var tl__ = instance_place( x, y, oplayer );
						
						if ( tl__ != parent ) {
							state = e_ameli_orb_state.idle;
							
							image_xscale = 1;
							image_yscale = 1;
							sprite_index = sameli_orb;
							with ( bullet_general( 20 , 0, shitbox, 0 ) ) {
								parent = other.parent;
								knockback *= 1.5;
								duration = 4;
								dir = 90;
							}
						}
						
					}
				}
				
			break;
			#endregion
			
			#region Init anti air
			case e_ameli_orb_state.anti_air:
				depth = 50;
				if ( move_timer == 0 ) {
					x = lerp( x, parent.x+parent.draw_xscale*16, 0.95 );
					y = lerp( y, parent.y-22, 0.95 );
					move_timer = 1;
				}
				if ( move_timer < 120 ) {
					if ( !gen_col( x, y ) ) {
						vsp += grav*0.4;
						y += vsp;
					} else {
						vsp = 0;
						hsp += sign( parent.MX - parent.x )*0.2;
						hsp *= lerp( frc, 1, 0.8 );
						x += hsp;
						
						if ( !parent.K1 ) {
							state = target_state;
						}
						depth = -220;
					}
				}
					
				if ( y > room_height ) state = e_ameli_orb_state.idle;
			break;
			#endregion
			#region Init laser
			case e_ameli_orb_state.beam:
				if ( parent.K1 ) {
					if ( intro_timer++ > 30 ) {
						// state = e_ameli_orb_state.idle;
						state = target_state;
					}
				} else {
					intro_timer = 0;
					state = e_ameli_orb_state.idle;
				}
				
				laser_dir = point_direction( x, y, parent.MX, parent.MY );
					
			break;
			#endregion
			#region init saw
			case e_ameli_orb_state.strike:
				
				if ( intro_timer > 20 ) {
					if ( own_hitbox == -1 || !instance_exists( own_hitbox ) ) {
						own_hitbox = bullet_general(2,0,shitbox,0);
						own_hitbox.dir = saw_dir;
						own_hitbox.duration = 8;
						own_hitbox.parent = parent;
					}
					
					saw_dir = angle_approach(saw_dir, point_direction( x, y, parent.MX, parent.MY ),2 );
					
					x += LDX( 1.5,saw_dir );
					y += LDY( 1.5,saw_dir );
					image_angle += 3;
					sprite_index = sbullet_saw_ameli;
					if ( !parent.K1 ) {
						state = target_state;
					}
				} else {
					intro_timer++;
					saw_dir = point_direction( x, y, parent.MX, parent.MY ); 
				}
			break;
			#endregion
		}
		
		attack_timer = 0;
	break;
	#endregion
	
	#region time bomb
	
	case e_ameli_orb_state.time_bomb: 
		if ( attack_timer++ > timer_explotion_duration ) {
			var b_ = bullet_general( 20, 0, shitbox_circle, 0 );
			b_.image_xscale = timed_explotion_radius/64;
			b_.image_yscale = timed_explotion_radius/64;
			b_.parent = parent;
			b_.ghost = true;
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
        	repeat(4) MAKES(ospark_alt);
        	repeat(3) MAKES(osmoke);		
		}
		
	break;
	
	#endregion
	
	#region trap
	case e_ameli_orb_state.trap: 
		if ( init_timer <= 60 ) {
			
			init_timer++;
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
		// if (init_timer == 0 ){
		// 	var i = 0; repeat(8) {
		// 		while ( gen_col(x,y) ) {
		// 			y -= 16;
		// 		}
		// 		i++;
		// 	}
		// }
		
		
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
				
				var b_ =bullet_general( 20, 0, sameli_trap_spear, 0 );
				b_.parent = parent;
				b_.ghost = true;
				b_.dir  = -15;
				b_.image_xscale = 3;
				b_.image_yscale = 3;
				b_.image_angle = -15;
				
				var b_ =bullet_general( 20, 0, sameli_trap_spear, 0 );		
				b_.parent = parent;
				b_.ghost = true;
				b_.dir = 0;
				b_.image_xscale = 3;
				b_.image_yscale = 3;
				b_.image_angle = 0;
				
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
	
		if ( parent.K1 ) {
			if ( attack_timer >= 60 ) {
				laser_dir = angle_approach( laser_dir, point_direction( x, y, parent.MX, parent.MY ), 1 );
			} else {
				laser_dir = angle_approach( laser_dir, point_direction( x, y, parent.MX, parent.MY ), 2 );
			}
			
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
		} else {
			attack_timer++;
		}
		
	break;
	#endregion
	
	#region strike
	case e_ameli_orb_state.strike: 
		if ( attack_timer++ > 90 ) {
			
			// var i = 0; 
			// var dir_ = 0;
			// var x_ = x;
			// var y_ = y;
			// repeat( 32 ) {
			// 	bullet_general( 30, 0, sameli_fist, 0 ).duration = 60;
			// 	i++;
			// 	x += LDX( 16, dir_ );
			// 	y += LDY( 16, dir_ );
				
			// }
			// x = x_;
			// y = y_;
			// attack_timer = 0;
			state = e_ameli_orb_state.idle;
			sprite_index = sbullet_saw_ameli;
		}
		if ( own_hitbox == -1 || !instance_exists( own_hitbox ) ) {
			own_hitbox = bullet_general(4,0,shitbox,0);
			own_hitbox.dir = saw_dir;
			own_hitbox.duration = 4;
			own_hitbox.parent = parent;
		}
		x += LDX( (90-attack_timer)/45,saw_dir );
		y += LDY( (90-attack_timer)/45,saw_dir );
	break;
	#endregion
	
}

if ( state == e_ameli_orb_state.idle ) {
	image_blend = merge_colour( main_blend, c_dkgray, 0.6 );
} else {
	image_blend = main_blend;	
}

