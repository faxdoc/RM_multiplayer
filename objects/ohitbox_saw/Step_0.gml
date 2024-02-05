if ( !player_exists ) exit;
event_inherited();
switch(move_state) {
	case 0:
		lag_add = 0;
		if ( !init ) {
			hsp *= 0.85;
			vsp *= 0.85;
			init = true;
			multihits_left = 12;
			knockback *= 2;
			
			multihit_cooldown_amount = 7;
			lag_add *= 0;
			shake_add *= .2;
		}
		
		silhouette_draw = true;
		
		
		if( place_meeting( x, y, par_hitbox ) ) {
			
			
			var t_ = instance_place( x, y, par_hitbox );
			//audio_play_sound_pitch_falloff( snd_maya_hit_saw, RR( 0.8, 0.9 ), RR( 0.95, 1.1 ), -10 );//RR(1.5,1.7)
			//hit_list[? t_] = 1;
			if ( can_push_cooldown <= 0 ) {
				can_push_cooldown = 20;
				hit_freeze = max( hit_freeze, 2 );
			}
			switch(t_.sprite_index ) {
				case splayer_grenade_blue:
				case splayer_grenade_green:
				case splayer_grenade_red:
				case splayer_grenade_white:
					enflamed = clamp( enflamed + 0.3, 1, 2 );
					SHAKE++;
				
					vsp  += t_.vsp*0.55;
					hsp  += t_.hsp*0.55;
					hsp *= 0.9;
					with( t_ ) {
						if ( object_index != ohitbox_saw ) {
							destroy_function();
							IDD();
						}
					}
					//IDD( t_ );
				break;
				default:
					hsp = lerp( hsp, LDX( 6, t_.dir ), 0.4 );
					vsp = lerp( vsp, LDY( 6, t_.dir ), 0.4 );
					x += RR(-2,2);
					y += RR(-2,2);
					with( t_ ) {
						destroy_function();
						IDD();
					}
				break;
			}
			//if ( t_.sprite_index == splayer_grenade ) {
				
			//} else if ( t_.object_index != object_index ) {
				
				
			//}
		}
		if ( PLC( x, y, ogrenade ) && !can_push_cooldown ) {
			can_push_cooldown = 3;	
			vsp -= 4;
		}
		
		if ( can_push_cooldown ) {
			can_push_cooldown--;
			
		}
		if ( multihits_left < 12 ) {
			multihits_left = 12;
			hit_freeze = 4;
		} 
		
		if ( !alt_movement ) {
			if ( hit_freeze <= 0 ) {
				if ( vsp > 0 || bounces_left <= 0 ) {
					vsp += 0.15*1.15;
					vsp *= 1.02;
				} else {
					vsp += 0.06*1.2;
				}
				vsp += enflamed*0.03;
				x += hsp;
				y += vsp;
			} else {
				hit_freeze--;
			}
		}
		dmg = base_dmg * 2;
	
		image_xscale = base_xscale*0.8;
		image_yscale = base_yscale*0.8;
		
		
		image_blend = merge_color( base_blend, merge_colour( c_white, c_aqua, 0.5 ), 0.5 );
		mask_index = sdot_black;
		
		if ( !alt_movement ) {
			duration = 290;
			if ( gen_col( x, y ) ) {
				if ( bounces_left > 0 && vsp > 0 ) {  
					bounces_left--;
					y -= vsp;
					vsp = -1.5;
					hsp *= 0.05;
					var i = 0;
					mask_index = sdot_wave;
					
					while ( i++ < 32 && gen_col( x, y+4 ) ) {
						y--;
					}
				} else {
					multihits_left = 4;
					move_state = 1;
					var i = 0;
					multihit_cooldown_amount = 12;
					lag_add   *= 2.0;
					shake_add *= 2.0;
				
					while ( i++ < 32 && gen_col( x, y ) ) {
						image_xscale = base_xscale*1.3;
						image_yscale = base_yscale*1.3;
						x -= hsp*0.05;
						y -= vsp*0.05;
					}
				}
			}
		#region alt movement
		} else {
			if ( instance_exists( parent ) ) {
				var drr_ =  point_direction(x,y,parent.x,parent.y);
				var _ds =  point_distance(x,y,parent.x,parent.y);
				hsp *= 0.97;
				vsp *= 0.97;
				var sp_ = min(0.3,(_ds-10) /100);
				hsp += LDX( sp_, drr_ );
				vsp += LDY( sp_, drr_ );
				depth = -220;
				grav = 0;
				x += hsp;
				y += vsp;
				draw_angle += 10;
				dir = 85;
				if ( !duration-- ) {
					IDD();
				}
				if (!alt_init_2) {
					knockback *= 1.5;
					duration = 600;
					hsp *= 0.5;
					vsp *= 0.5;
					base_xscale += 0.25;
					base_yscale += 0.25;
					alt_init_2 = true;
					stun_mult *= 2;
					base_dmg *= 2;
				}
			}
		}
		#endregion
			
		mask_index = sprite_index;
		if ( !alt_movement ) {
			angle_spin =  sign(hsp)*5;
			draw_angle += angle_spin;
			if ( sign(hsp) != 0 ) {
				spin_dir = sign(hsp) ? 0 : 180;
			}
		}
		silhouette_timer -= .2;
		silhouette_blend = enflamed ? c_orange : c_aqua;
		//sprite_index = sbullet_big_red_alt;
		if ( bbox_bottom > room_height + 20 ) {
			//if ( !is_undefined(hitmap) && ds_exists( hitmap, ds_type_map ) ) ds_map_clear( hitmap );
			IDD();
		}
		
	break;
	case 1:
		
		
		if (!can_push_cooldown ) {
			if( place_meeting(x,y,par_hitbox) ){
				can_push_cooldown = 2;
				//var t_ = instance_place(x,y,par_hitbox);

				//if ( t_.sprite_index == splayer_grenade ) {
				//	enflamed = clamp( enflamed + 0.3, 1, 2 );
				//	SHAKE++;
				//	IDD(t_);
				//}
			}
		} else {
			can_push_cooldown--;
		}
		
		dmg = base_dmg * 4;
		image_alpha			= RR(.75,.8);
		draw_angle			-= angle_spin*3;
		image_xscale		= base_xscale*1.4;
		image_yscale		= base_yscale*1.4;
		silhouette_blend	= merge_colour(c_gray,c_aqua,0.2);
		silhouette_timer += .5;
		
		var vv_ = vsp;
		var spd_ = 1;
		
		var i = 0;
		
		if (start_delay > 0 ) {
			start_delay--;
		} else {
			
				
			image_angle = 0;
			repeat(3) {
				hsp = LDX( spd_, spin_dir );
				vsp = LDY( spd_, spin_dir );
				x += hsp;
				y += vsp;
				mask_index = sdot_wave;
		
				if ( !gen_col(x,y) ) {
					
					if ( gen_col( x+LDX(8,spin_dir+180+45), y+LDY(8,spin_dir+180+45) ) ) {
					
						while( i++ < 32 && !gen_col( x, y ) ) {
							x += LDX(1,spin_dir+180+45);
							y += LDY(1,spin_dir+180+45);
						}
					
						spin_dir -= 10;
					} 
				
					else if ( gen_col( x+LDX(8,spin_dir+180-45), y+LDY(8,spin_dir+180-45) ) ) {
						while( i++ < 32 && !gen_col( x, y ) ) {
							x += LDX(1,spin_dir+180-45);
							y += LDY(1,spin_dir+180-45);
						}
						spin_dir += 10;
					}
				}
				
				mask_index = sdot_black;
				if ( gen_col(x,y) ) {
				
					var spl_ = 1;
					if (!gen_col(x+LDX(5,spin_dir+90),y+LDY(5,spin_dir+90))) {
						spl_ = 1;
					}
					if (!gen_col(x+LDX(5,spin_dir-90),y+LDY(5,spin_dir-90))) {
						spl_ = -1;
					}
					while( i++ < 32 &&  gen_col( x, y ) ) {
						x += LDX( 1, spin_dir + 180 );
						y += LDY( 1, spin_dir + 180 );
					}
					spin_dir += 45*spl_;
				}
			}
		}
		
		if ( random_fixed( 1 ) > 0.8 ) {
			var dr_ = spin_dir;
			var t = ICD( x - LDX( 16, dr_ + 90 ), y - LDY( 16 ,dr_ + 90 ), 0, ospark_alt );
			var ddr = dr_-45+RR(-30,30);
			t.hsp = LDX(-RR(3,5),ddr);
			t.vsp = LDY(-RR(3,5),ddr);
			t.col = c_black;
		}
		
		if ( random_fixed( 1 ) > 0.8 ) {
			var dr_ = point_direction(0,0,hsp,vsp);
			ICD(x-LDX(8,dr_+45),y-LDY(8,dr_+45),0,ophy_dot_stone);
		}
		mask_index = sprite_index;
		
		if ( place_meeting( x, y, ogrenade ) ) {
			vsp = -0.5;
			angle_spin = 3;
			if ( bounces_left <= 0 ) bounces_left++;
			move_state = 0;
		}
		
		
		if ( bbox_right < 0 || bbox_bottom < 0 || bbox_left > room_width || bbox_top > room_height ) {
			IDD();
		}
	break;
	case 2:
		
	break;
}
dir = 90;


if ( enflamed ) {
	var scale_ = lerp( 1.3, 2, (enflamed-1) / 1.5 );
	dmg *= scale_;
	if( move_state == 0 ){
		image_xscale  *= lerp( scale_, 1, 0.4 );
		image_yscale  *= lerp( scale_, 1, 0.4 );
	} else {
		image_xscale  *= lerp( scale_, 1, 0.4 );
		image_yscale  *= lerp( scale_, 1, 0.4 );
	}
	//image_blend = merge_colour( image_blend, c_orange, scale_-1 );
}
draw_angle += 4;

//general_position_sound_step( snd_maya_saw_loop, 0.7 );

