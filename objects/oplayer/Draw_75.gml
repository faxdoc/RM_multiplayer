

if ( player_local ) {
	var xoffset_ = 0;
	var yoffset_ = 0;
	
	
	if !( opreference_tracker.player_anti_flicker[player_id] ) {
		shader_set(shd_max_a);
		draw_surface_part( application_surface, frac(camera_x), frac(camera_y),GW*2,GH*2,round(screen_shake_x)-xoffset_, round(screen_shake_y)-yoffset_);
		shader_reset();
	}
	var ii = 0,c = -1;
	var yl_ = floor( GH*0.91 );
	var xx  = floor( GW*0.08 );
	var yy = yl_;
	var ds_ = GW*0.25;
	var c;
	
	var i = 0; with ( oplayer ) {
		if ( player_colour == c_red ) {
			draw_sprite_ext(portrait_base,		0,  xx+i*ds_, yy, 1, 1, 0, c_white, 1 );
			
			if ( hit_timer <= 0 ) {
				switch(char_index) {
					default:
					case e_char_index.fern:
						draw_sprite_ext( sface_fern_normal,	0,	xx+i*ds_, yy, 1, 1, 0, c_white, 1 );
					break;
					case e_char_index.maya:
						draw_sprite_ext( sface_maya_normal,	0,	xx+i*ds_, yy, 1, 1, 0, c_white, 1 );
					break;
					case e_char_index.ameli:
						draw_sprite_ext( sface_ameli_normal,	0,	xx+i*ds_, yy, 1, 1, 0, c_white, 1 );
					break;
				}
				
			} else {
				switch(char_index) {
					default:
					case e_char_index.fern:
						draw_sprite_ext( sface_fern_hit,	0,	xx+i*ds_+ ((hit_freeze*342) mod 4) - 2, yy+ ((hit_freeze*1462) mod 4) - (2*min(hit_freeze,1)), 1, 1, 0, merge_colour( c_white, c_red, min( hit_freeze/4, 1 ) ), 1 );
					break;
					case e_char_index.maya:
						draw_sprite_ext( sface_maya_hit,	0,	xx+i*ds_+ ((hit_freeze*342) mod 4) - 2, yy+ ((hit_freeze*1462) mod 4) - (2*min(hit_freeze,1)), 1, 1, 0, merge_colour( c_white, c_red, min( hit_freeze/4, 1 ) ), 1 );
					break;
					case e_char_index.ameli:
						draw_sprite_ext( sface_ameli_hit,	0,	xx+i*ds_+ ((hit_freeze*342) mod 4) - 2, yy+ ((hit_freeze*1462) mod 4) - (2*min(hit_freeze,1)), 1, 1, 0, merge_colour( c_white, c_red, min( hit_freeze/4, 1 ) ), 1 );
					break;
				}
			}
			
			ii = 0; repeat( lives_left ) {
				draw_sprite_ext( splayer_hp,	 0,  xx+i*ds_ + ii*15+31, yy+11, 1, 1, 0, c_white, 1 );
				ii++;
			}
		} else {
			c = merge_colour( c_white, player_colour, 0.5 );
			draw_sprite_ext( sportrait_base_grayscale,  0, xx+i*ds_, yy, 1, 1, 0, c, 1 );
			
			if ( hit_timer <= 0 ) {
				//draw_sprite_ext( portrait_expression_base,	0,	xx+i*ds_, yy, 1, 1, 0, c_white, 1 );
				switch(char_index) {
					default:
					case e_char_index.fern:
						draw_sprite_ext( sface_fern_normal,	0,	xx+i*ds_, yy, 1, 1, 0, c_white, 1 );
					break;
					case e_char_index.maya:
						draw_sprite_ext( sface_maya_normal,	0,	xx+i*ds_, yy, 1, 1, 0, c_white, 1 );
					break;
					case e_char_index.ameli:
						draw_sprite_ext( sface_ameli_normal,	0,	xx+i*ds_, yy, 1, 1, 0, c_white, 1 );
					break;
				}
				
			} else {
				switch(char_index) {
					default:
					case e_char_index.fern:
						draw_sprite_ext( sface_fern_hit,	0,	xx+i*ds_+ ((hit_freeze*342) mod 4) - 2, yy+ ((hit_freeze*1462) mod 4) - (2*min(hit_freeze,1)), 1, 1, 0, merge_colour( c_white, c_red, min( hit_freeze/4, 1 ) ), 1 );
					break;
					case e_char_index.maya:
						draw_sprite_ext( sface_maya_hit,	0,	xx+i*ds_+ ((hit_freeze*342) mod 4) - 2, yy+ ((hit_freeze*1462) mod 4) - (2*min(hit_freeze,1)), 1, 1, 0, merge_colour( c_white, c_red, min( hit_freeze/4, 1 ) ), 1 );
					break;
					case e_char_index.ameli:
						draw_sprite_ext( sface_ameli_hit,	0,	xx+i*ds_+ ((hit_freeze*342) mod 4) - 2, yy+ ((hit_freeze*1462) mod 4) - (2*min(hit_freeze,1)), 1, 1, 0, merge_colour( c_white, c_red, min( hit_freeze/4, 1 ) ), 1 );
					break;
				}
				
				//draw_sprite_ext( portrait_expression_hurt,	0,	xx+i*ds_ + ((hit_freeze*342) mod 4) - 2, yy + ((hit_freeze*1462) mod 4) - (2*min(hit_freeze,1)), 1, 1, 0,  merge_colour( c_white, c_red, min( hit_freeze/4, 1 ) ), 1 );
			}
			
			ii = 0; repeat( lives_left ) {
				draw_sprite_ext( splayer_hp_grayscale, 0,  xx+i*ds_ + ii*15+31, yy+11, 1, 1, 0, c, 1 );
				ii++;
			}
		}
		
		c = merge_colour( c_gray, player_colour, 0.5 );
		DSC( c_black );DSA(0.9);
		draw_text( xx+i*ds_+26-1, yy+16-1,  display_name );
		draw_text( xx+i*ds_+26-1, yy+16,  display_name );
		DSC( c );DSA(1);
		
		draw_text( xx+i*ds_+26, yy+16,   display_name );
		
		//ii = 0; repeat( lives_left ) {
		//	draw_sprite_ext(shp_icon,0, ( GW*0.15 + ( i*(GW*0.2)) )+(ii++*18)+8, yl_-4, 1, 1, 0, c, 1  );
		//}
		
		
		
		i++;
		
		DSC(c_white);
	}
	
	
	#region debug input
	if ( global.training_mode ) {
		
		var commands = [
			"I: Toggle game speed"						,
			"O: change map"								,
			"P: Toggle debug visibility"				,
			"K: frame by frame (broken atm)"	,
			"L: Increase frame by one"					,
			"N: No cooldowns"							+ (global.training_nocooldown	? " On" : " Off"),
			"M: Infinite hp"							+ (global.training_infinite_hp	? " On" : " Off"),
			"B: Display stunframes/invis"				,
			"C: Display speed"							,
			"V: Display hitboxes"
		];
		var keys = [
			ord("I"),
			ord("O"),
			ord("P"),
			ord("K"),
			ord("L"),
			ord("N"),
			ord("M"),
			ord("B"),
			ord("C"),
			ord("V"),
		];
		var functions = [
			function() { game_set_speed( game_get_speed(gamespeed_fps) == 60 ? 15 : ( game_get_speed(gamespeed_fps) == 30 ? 60 : 30 ),gamespeed_fps)},
			function() { global.training_mode_change_stage	= !global.training_mode_change_stage  },
			function() { global.training_mode_visible		= !global.training_mode_visible		  },
			function() { global.frame_by_frame_mode			= !global.frame_by_frame_mode		  },
			function() {},
			function() { global.training_nocooldown			= !global.training_nocooldown		 },
			function() { global.training_infinite_hp		= !global.training_infinite_hp		 },
			function() { global.training_stun_render		= !global.training_stun_render		 },
			function() { global.speed_render		= !global.speed_render		 },
			function() { global.training_display_hitboxes	= !global.training_display_hitboxes  },
		];
		var tr_x = floor(GW*0.6);
		var tr_y = floor(GH*0.05);
		var idis = 12;
		
		if ( global.frame_by_frame_mode ) {
			scr_freeze_game();
		}
		var render_ = global.training_mode_visible;
		
		if ( render_  ) {
			draw_rectangle_ca(tr_x-8,tr_y-8,tr_x+218,tr_y+array_length(keys)*idis + 8, c_black, 0.8 );
			var i = 0; repeat(array_length(keys)) {
				if KCP(keys[i]) functions[i]();
				draw_text(tr_x,tr_y+idis*i,commands[i]);
				i++;
			}
		} else {
			draw_text(tr_x+190,tr_y-12,"P:vis");
			var i = 0; repeat(array_length(keys)) {
				if KCP(keys[i]) functions[i]();
				i++;
			}
		}
		
		if ( global.training_stun_render ) {
			draw_set_font(global.fnt_number_big);
			var cx_ = camera_x;
			var cy_ = camera_y;
			with (oplayer) {
				
				DSC(c_aqua);
				draw_text( x-cx_, bbox_top-cy_-68, INVIS );
				DSC(c_red);
				draw_text( x-cx_, bbox_top-cy_-48, hit_timer );
				DSC(c_white);
			}
			draw_set_font(fnt_default);
		}
		
		if ( global.speed_render ) {
			draw_set_font(global.fnt_number_big);
			var cx_ = camera_x;
			var cy_ = camera_y;
			with (oplayer) {
				
				DSC(c_ltgray);
				draw_text( x-cx_-12, bbox_bottom-cy_+16, hsp );
				draw_text( x-cx_-12, bbox_bottom-cy_+32, vsp );		
				DSC(c_white);
			}
			draw_set_font(fnt_default);
		}
		
		if ( global.training_display_hitboxes ) {
			var cx_ = camera_x;
			var cy_ = camera_y;
			DSC(c_aqua);
			with (oplayer) {
				draw_rectangle(bbox_right-cx_,bbox_top-cy_,bbox_left-cx_,bbox_bottom-cy_,true);
			}
			DSC(c_red);
			with (par_hitbox) {
				draw_rectangle(bbox_right-cx_,bbox_top-cy_,bbox_left-cx_,bbox_bottom-cy_,true);
			}
			DSC(c_white);
		}
		
	}
	
	#endregion
	
	var bx = GW*0.5;
	var by = floor( GH*0.87 )+1;
	var mds_ = 19;
	var rl_ = 0;
	var ex_ = 0;
	var myl_ = 0;
	var wep_list  = [ 0, 5, 1, 4, 3, 2 ];
	var rls			= [ 96, 320, 120,  135, 135,  900 ];
	var cl_col = merge_color( c_dkgray, c_red, 0.5 );
	var visual_i = -3.5;
	
	//var gun_sprites = [ splayer_gun_pistol_silhouette, splayer_gun_small_silhouette, splayer_gun_shotgun_silhouette, splayer_gun_grenade_silhoutte, splayer_gun_sniper_silhouette, splayer_gun_rail_silhouette ];
	
	switch( char_index ) {
		#region fern
		case e_char_index.fern:
			var i = 0; repeat( 6 ) {
		
				myl_ = 1;
				if ( current_weapon == wep_list[i] ) {
					myl_ = 0;
				}
		
				rl_ = RELOAD[wep_list[i]];
				if ( rl_ > 0 ) {
					//draw_sprite_ext( scooldown_box, 0, ex_+bx+visual_i*mds_, by+myl_,					1.1, 1.1, 0,  merge_colour(c_dkgray,c_red,0.5), 1 );		
					draw_sprite_ext( sabilities_icon,		i, ex_+bx+visual_i*mds_, by+myl_,				1, 1, 0,  merge_colour(c_dkgray,c_red,0.6), 1 );
					draw_sprite_ext( scooldown, 27-( rl_/rls[i] )*27, ex_+bx+visual_i*mds_, by+myl_, 1, 1, 0, c_white, 0.7 );
				} else {
					//draw_sprite_ext( scooldown_box, 0, ex_+bx+visual_i*mds_, by+myl_,    1.1, 1.1, 0, c_ltgray, 1 );		
					if ( current_weapon == wep_list[i] ) {
						draw_sprite_ext( sabilities_icon,		i, ex_+bx+visual_i*mds_, by+myl_,  1, 1, 0, merge_colour( c_white, c_orange, 0.1 ), 1 );
						if ( gun_flash_data[i] > 0 ) {
							draw_sprite_ext( sreload_flash, gun_flash_data[i], ex_+bx+visual_i*mds_, by+myl_,  1, 1, 0, c_white, 0.75 );
						}
				
					} else {
						draw_sprite_ext( sabilities_icon,		i, ex_+bx+visual_i*mds_, by+myl_,  1, 1, 0, merge_color( c_gray, c_dkgray, 0.6 ), 1 );	
						if ( gun_flash_data[i] > 0 ) {
							draw_sprite_ext( sreload_flash, gun_flash_data[i], ex_+bx+visual_i*mds_, by+myl_,  1, 1, 0, c_gray, 0.7 );
						}
				
					}
				}
		
				visual_i++;
				i++;
		
			}
			myl_ = 3;
			if ( grenade_cooldown ) {
				//draw_sprite_ext( scooldown_box, 0,								ex_+bx+visual_i*mds_, by+myl_, 1.1, 1.1, 0,  merge_colour(c_dkgray,c_red,0.5), 1 );		
				draw_sprite_ext( sabilities_icon,		6,								ex_+bx+visual_i*mds_, by+myl_, 1.1, 1.1, 0,  merge_colour(c_dkgray,c_red,0.5), 1 );
				draw_sprite_ext( scooldown,		27-( grenade_cooldown/140 )*26, ex_+bx+visual_i*mds_, by+myl_, 1.1, 1.1, 0, c_white, 0.9 );
			} else {
				//draw_sprite_ext( scooldown_box, 0, ex_+bx+visual_i*mds_, by+myl_,  1.1, 1.1, 0, c_orange, 1 );
				draw_sprite_ext( sabilities_icon,		6, ex_+bx+visual_i*mds_, by+myl_,  1.1, 1.1, 0, merge_color( c_gray, c_dkgray, 0.5 ), 1 );	
			}
			draw_sprite_ext( snumbers, 6, ex_+bx+visual_i*mds_, by+myl_,  1, 1, 0, c_gray, 1 );
	
			wep_list  = [ 0, 2, 5, 4, 3, 1 ];
			draw_sprite_ext( scooldown_box_outer,0,  ex_+bx+(wep_list[current_weapon]-3.5)*mds_, by, 1, 1, 0, c_white, 1 );
	
			wep_list  = [ 0, 5, 1, 4, 3, 2 ];
			var i = 0; repeat(6) {
				if ( current_weapon == wep_list[i] ) {
					draw_sprite_ext( snumbers, i, ex_+bx+(i-3.5)*mds_-2, by+myl_-3-1,  1, 1, 0, c_white, 1 );
				} else {
					draw_sprite_ext( snumbers, i, ex_+bx+(i-3.5)*mds_+1, by+myl_+1,  1, 1, 0, c_gray, 1 );
				}
		
				i++;
			}
		break;
		#endregion
		#region maya
		case e_char_index.maya:
				var amult = 1;
				var xx = floor( GW * 0.45 )-15;
				var yy = floor( GH * 0.85 );
				
				
				var ds_ = 14;
				draw_sprite_ext( smaya_abilities_bar, 0, xx, yy, 1, 1, 0, c_white, amult );
				
				var cw_ = clamp( current_weapon, 0, 5 );
				var nms_ = [ 0, 2, 5, 4, 3, 1 ];
				var exe		=  20;
				var exy		= -10;
				var ang_	= -90;
				var vl_		= nms_[ floor( clamp( current_weapon, 0, 5 ) ) ];
		
				if ( CLIP[current_weapon] != 0 ) {
					exe += 2;
					draw_sprite_ext( smaya_abilities_icons, vl_, xx+76-1+exe, yy+14+exy,   1, 1 ,  ang_, c_dkgray, amult );
					draw_sprite_ext( smaya_abilities_icons, vl_, xx+76+1+exe, yy+14+exy,   1, 1 ,  ang_, c_dkgray, amult );
					draw_sprite_ext( smaya_abilities_icons, vl_, xx+76  +exe, yy+14-1+exy, 1, 1 ,  ang_, c_dkgray, amult );
					draw_sprite_ext( smaya_abilities_icons, vl_, xx+76  +exe, yy+14+1+exy, 1, 1 ,  ang_, c_dkgray, amult );
			
					draw_sprite_ext( smaya_abilities_icons, vl_, xx+76+exe, yy+14+exy, 1, 1,  ang_, merge_colour(c_orange,c_gray,wave(0.0,0.3,5,0)), amult );
				} else {
					exe -= 5;
					draw_sprite_ext( smaya_abilities_icons, vl_, xx+76-1+exe, yy+14+exy,   1, 1 ,  ang_, c_dkgray,  amult );
					draw_sprite_ext( smaya_abilities_icons, vl_, xx+76+1+exe, yy+14+exy,   1, 1 ,  ang_, c_dkgray,  amult );
					draw_sprite_ext( smaya_abilities_icons, vl_, xx+76  +exe, yy+14-1+exy, 1, 1 ,  ang_, c_dkgray,  amult );
					draw_sprite_ext( smaya_abilities_icons, vl_, xx+76  +exe, yy+14+1+exy, 1, 1 ,  ang_, c_dkgray,  amult );
			
					draw_sprite_ext( smaya_abilities_icons, vl_, xx+76+exe, yy+14+exy, 1, 1,  ang_, c_gray,  amult );
				}
		
				var nms_ = [
					0,
					5,
					1,
					4,
					3,
					2,
				];
		
				var nnm_ = 0;
				var rl_val_ = 0;
				var pw_val_ = 0;
				var i = 0;
				draw_sprite_ext( smaya_abilities_icons, i, xx - 1 + ( i * ds_ )+4, yy+4, 1, 1, 0, c_white, amult );
			
				i = 1; repeat( 5 ) {
					nnm_ = nms_[i];
					rl_val_ = RELOAD[nnm_];
					pw_val_ = ( 480 - rl_val_ ) / 480;
					if ( WEP_DATA[ nnm_ ].found ) {
						if ( CLIP[nnm_] == 0 ) {
							draw_sprite_ext( smaya_abilites_fill,   1, xx - 0 + ( i * ds_ )+4, yy+5+11, 1, pw_val_, 0, merge_colour(c_gray, c_red, 0.6 ), amult*0.8 );
							draw_sprite_ext( smaya_abilities_icons, i, xx - 1 + ( i * ds_ )+4, yy+4, 1, 1, 0, c_dkgray, amult );
						} else if ( rl_val_ > 0 ) {
							draw_sprite_ext( smaya_abilites_fill,   1, xx - 0 + ( i * ds_ )+4, yy+5+11, 1, pw_val_, 0, c_aqua, amult*0.7 );
							draw_sprite_ext( smaya_abilities_icons, i, xx - 1 + ( i * ds_ )+4, yy+4, 1, 1, 0, c_ltgray, amult );
						} else {
							draw_sprite_ext( smaya_abilites_fill,   0, xx - 0 + ( i * ds_ )+4, yy+4+12, 1, 1, 0, c_gray, amult );
							draw_sprite_ext( smaya_abilities_icons, i, xx - 1 + ( i * ds_ )+4, yy+4, 1, 1, 0, c_ltgray,  amult );
						}
					} else {
						draw_sprite_ext( smaya_abilities_icons, i, xx - 1 + ( i * ds_ )+4, yy+4, 1, 1, 0, c_black, amult );
					}
					i++;
				}
				
				var alt_col_ = CLIP[current_weapon] != 0 || current_weapon == 0;
				if ( alt_col_ ) {
					draw_sprite_ext( smaya_abilities_bar, 1, xx, yy, 1, 1, 0, c_gray, amult );
				} else {
					draw_sprite_ext( smaya_abilities_bar, 1, xx, yy, 1, 1, 0, merge_colour( c_gray, c_red, 0.2 ), amult );
				}
				var nms_ = [
					0,
					2,
					5,
					4,
					3,
					1,
				];
				var vl_ = nms_[ floor(clamp( current_weapon, 0, 5 )) ];
				
				
				if ( alt_col_ ) {
					draw_sprite_ext( smaya_abilities_icons, vl_, xx - 1 + ( vl_ * ds_ )+4, yy+4, 1, 1, 0, c_orange, amult );
				}
				draw_sprite_ext( smaya_abilites_select,	   0, xx + ( vl_ * ds_ )+5, yy+1, 1, 1, 0, alt_col_ ? c_white : merge_colour(c_ltgray,c_red,0.5), amult );
				
		break;
		#endregion
		#region ameli
		case e_char_index.ameli:
			var i = 0; repeat( 6 ) {
		
				myl_ = 1;
				if ( current_weapon == wep_list[i] ) {
					myl_ = 0;
				}
				//draw_sprite_ext( scooldown_box, 0, ex_+bx+visual_i*mds_, by+myl_,    1.1, 1.1, 0, c_ltgray, 1 );		
				if ( current_weapon == wep_list[i] ) {
					
					// if ( ameli_ranged_mode ) {
						// draw_sprite_ext( sabilities_ameli_ranged,		i, ex_+bx+visual_i*mds_, by+myl_,  1, 1, 0, merge_colour( c_white, c_orange, 0.1 ), 1 );
					// } else {
						draw_sprite_ext( sabilities_ameli,		i, ex_+bx+visual_i*mds_, by+myl_,  1, 1, 0, merge_colour( c_white, c_orange, 0.1 ), 1 );
					// }
					if ( gun_flash_data[i] > 0 ) {
						draw_sprite_ext( sreload_flash, gun_flash_data[i], ex_+bx+visual_i*mds_, by+myl_,  1, 1, 0, c_white, 0.75 );
					}
			
				} else {
					// if ( ameli_ranged_mode ) {
						// draw_sprite_ext( sabilities_ameli_ranged,		i, ex_+bx+visual_i*mds_, by+myl_,  1, 1, 0, merge_color( c_gray, c_dkgray, 0.6 ), 1 );
					// } else {
						draw_sprite_ext( sabilities_ameli,		i, ex_+bx+visual_i*mds_, by+myl_,  1, 1, 0, merge_color( c_gray, c_dkgray, 0.6 ), 1 );
					// }
				}
				visual_i++;
				i++;
			}
			
			myl_ = 3;
			// if ( grenade_cooldown ) {
			// 	if ( ameli_ranged_mode ) {
			// 		draw_sprite_ext( sabilities_ameli,		6,								ex_+bx+visual_i*mds_, by+myl_, 1.1, 1.1, 0,  merge_colour(c_dkgray,c_red,0.5), 1 );
			// 	} else {
					
			// 	}
			// 	draw_sprite_ext( scooldown,		27-( grenade_cooldown/140 )*26, ex_+bx+visual_i*mds_, by+myl_, 1.1, 1.1, 0, c_white, 0.9 );
			// } else {
			// 	draw_sprite_ext( sabilities_ameli,		6, ex_+bx+visual_i*mds_, by+myl_,  1.1, 1.1, 0, merge_color( c_gray, c_dkgray, 0.5 ), 1 );	
			// }
			
			// draw_sprite_ext( snumbers, 6, ex_+bx+visual_i*mds_, by+myl_,  1, 1, 0, c_gray, 1 );
			
			wep_list  = [ 0, 2, 5, 4, 3, 1 ];
			// if ( ameli_ranged_mode ) {
				// draw_sprite_ext( scooldown_box_outer,0,  ex_+bx+(wep_list[current_weapon]-3.5)*mds_, by, 1, 1, 0, c_white, 1 );
			// } else {
				draw_sprite_ext( scooldown_box_outer,0,  ex_+bx+(wep_list[current_weapon]-3.5)*mds_, by, 1, 1, 0, c_red, 1 );
			// }
	
			wep_list  = [ 0, 5, 1, 4, 3, 2 ];
			by += 3;
			var i = 0; repeat(6) {
				if ( current_weapon == wep_list[i] ) {
					draw_sprite_ext( snumbers, i, ex_+bx+(i-3.5)*mds_-2, by+myl_-3-1,  1, 1, 0, c_white, 1 );
				} else {
					draw_sprite_ext( snumbers, i, ex_+bx+(i-3.5)*mds_+1, by+myl_+1,  1, 1, 0, c_gray, 1 );
				}
				i++;
			}
			draw_sprite_ext( sorbs_counter, 0, bx-16, by-32, 0.5, 0.5, 0, merge_color(player_colour, c_gray,0.68), 0.5 );
			var orbs_left = 0;
			if ( orbs[0].attack_state == e_ameli_orb_attack_state.idle ) orbs_left++;
			if ( orbs[1].attack_state == e_ameli_orb_attack_state.idle ) orbs_left++;
			if ( orbs[2].attack_state == e_ameli_orb_attack_state.idle ) orbs_left++;
			
			draw_set_font(global.fnt_number_big);
				
			var c = merge_color(player_colour, c_dkgray,0.9);
			draw_text_transformed_color( bx, by-32+1, orbs_left, 2, 2, 0,  c,c,c,c,1 );	
			c = merge_color(player_colour, c_gray,0.8);
			draw_text_transformed_color( bx, by-32, orbs_left, 2, 2, 0, c,c,c,c,1 );
		
			draw_set_font(fnt_default);
			bx -= 16;
			by += 12;
			draw_rectangle( bx-78, by-64+8, bx-78+flying_charge,by+12-64+8,false );
				
		break;
		#endregion
	}
	
	if ( flash_alpha > 0 ) {
		DSC( screen_flash_col	 );
		DSA( flash_alpha	* 0.6);
		draw_rectangle( 0, 0, room_width, room_height, false );
		DSC(c_white);
		DSA(1);
		
	}
	switch( meta_state ) {
		#region char select
		case e_meta_state.char_select:
			DSC(c_darkest);
			DSA( 1 );
			draw_rectangle(0,0,room_width,room_height,false);
			DSC(c_white);
			DSA(1);
			draw_sprite_tiled_ext(spattern_victory,0, -level_select_timer*0.1, -level_select_timer*0.1, 2, 2, c_purple, 0.35 );
			
			
			
			if ( opreference_tracker.char_index_progress[ other.player_id ] != -1 ) {
				var _ts = opreference_tracker.char_index_progress[ other.player_id ];
				switch( opreference_tracker.char_index[ other.player_id ] ) {
					case e_char_index.fern:
						draw_sprite_ext( sready_up_fern, 0,  8, 36+_ts, 1, 1, 0, c_white, 1 );
						draw_sprite_ext( sfern_nametag,  0,  8, 18-_ts, 1, 1, 0, c_white, 1 );
					break;
					case e_char_index.maya:
						draw_sprite_ext( sready_up_maya, 0,  8, 36+_ts, 1, 1, 0, c_white, 1 );
						draw_sprite_ext( smaya_name_tag, 0,  8, 18-_ts, 1, 1, 0, c_white, 1 );
					break;
					case e_char_index.ameli:
						draw_sprite_ext( sready_up_ameli, 0,  8, 36+_ts, 1, 1, 0, c_white, 1 );
						draw_sprite_ext( sameli_name_tag, 0,  8, 18-_ts, 1, 1, 0, c_white, 1 );
					break;
				}
			}
			
			if ( player_colour == c_red ) {
				draw_sprite_ext( sready_screen_player_panel,	0, 4, 232, 1, 1, 0, c_white, 1 );
			} else {
				draw_sprite_ext( sready_screen_player_panel_bw, 0, 4, 232, 1, 1, 0, merge_color( c_white, player_colour, 0.4 ), 1 );
			}
			
			
			draw_sprite_ext( sready_UI_text, opreference_tracker.ready_state[ other.player_id ] ? 0 : 1, 13, 40, 1, 1, 0, c_white, 1 );//
			draw_sprite_ext( sgrapple_mode_UI,	0, 14, 244, 1, 1, 0, c_white, 1 );
			draw_sprite_ext( sjump_on_W_UI,		0, 14, 260, 1, 1, 0, c_white, 1 );
			draw_sprite_ext( sready_UI,			0, 15, 276, 1, 1, 0, c_white, 1 );
			
			draw_text( 12,300, display_name );
			
			
			var c = c_aqua;
			var crx_ = floor(GW*0.5);
			var cry_ = floor(GH*0.15);
			// draw_set_halign( fa_center );
			// draw_text_transformed_color( crx_,cry_, "Select character", 2, 2, 0, c,c,c,c, 1 );
			// draw_set_halign( fa_left );
			
			with ( obutton_character ) {
				
				var cxoffset_ = 2+2;
				var cyoffset_ = 3;
				
				if ( instance_position( device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id ) ) {
					draw_sprite_ext( schar_select_frame, 1, x-cxoffset_, y-cyoffset_,	1,	 1, 		0, c_white, 1.0 );
					draw_sprite_ext( sdark_gradient,	 0, GW, 		 0, 			1.5, GH/128,	0, c_black, 0.9 );
					
					var inf_x =floor( GW*0.77 ) - 2, inf_y = 96, inf_dis = 12;
					var inf_l_ = array_length(info);
					
					draw_text_transformed_color( inf_x-1, inf_y - 58+1, name,    2, 2, 0, c_purple, c_purple, c_purple, c_purple, 0.7	);
					draw_text_transformed_color( inf_x,   inf_y - 58,	name,    2, 2, 0, c_orange, c_orange, c_orange, c_orange, 1 	);
					draw_text_transformed_color( inf_x-8, inf_y - 29,	tagline, 1, 1, 0, c_gray,   c_gray,   c_gray,   c_gray,   1 	);
					
					var i = 0; repeat(inf_l_) {
						draw_text( inf_x, inf_y + ( i * inf_dis ), info[ i ] );
						i++; 
					}
				} else {
					draw_sprite_ext( schar_select_frame, 0, x-cxoffset_, y-cyoffset_, 1, 1, 0, c_white, 1 );
				}
				
				draw_self();
				if ( opreference_tracker.char_index[ other.player_id ] == index ) {
					draw_sprite_ext( schar_select_frame_selected, 0, x-cxoffset_, y-cyoffset_, 1, 1, 0, c_white, 1 );
				}
			}
			with ( obutton_grapplemode ) {
				if ( instance_position( device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id ) ) {
					draw_sprite_ext( sdark_gradient,	 0, GW, 		 0, 			1.5, GH/128,	0, c_black, 0.9 );
					var inf_x =floor( GW*0.77 ) - 2, inf_y = 96, inf_dis = 12;
					var inf_l_ = array_length(text);
					var i = 0; repeat(inf_l_) {
						draw_text( inf_x, inf_y + ( i * inf_dis ), text[ i ] );
						i++; 
					}
				}
			}
			
			with ( obutton_grapplemode_off ) {
				if ( instance_position( device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id ) ) {
					draw_sprite_ext( sdark_gradient,	 0, GW, 		 0, 			1.5, GH/128,	0, c_black, 0.9 );
					var inf_x =floor( GW*0.77 ) - 2, inf_y = 96, inf_dis = 12;
					var inf_l_ = array_length(text);
					var i = 0; repeat(inf_l_) {
						draw_text( inf_x, inf_y + ( i * inf_dis ), text[ i ] );
						i++; 
					}
				}
			}
			
			with ( otoggle_button ) {
				c = c_gray;
				draw_text_transformed_color( x + 8, y-7, text, 1, 1, 0, c, c, c, c, 1 );
				draw_sprite_ext( sprite_index, return_function( other.player_id ),x,y,1,1,0,c_white,1);
			}
			
			with ( obutton_ready ) {
				if ( opreference_tracker.char_index_progress[ other.player_id ] != -1 ) {
					draw_sprite_ext( sprite_index, opreference_tracker.ready_state[ other.player_id ] ? 2 : 0, x, y, 1, 1, 0, c_white, 1 );
				}
			}
			with (obutton_rollback ) {
				event_perform( ev_draw, 0 );
			}
			
			with ( obutton_rollback_text ) {
				event_perform( ev_draw, 0 );
			}
			
			with ( obutton_flicker_test ) event_perform( ev_draw, 0 );
			with ( obutton_flicker_on   ) event_perform( ev_draw, 0 );
			with ( obutton_flicker_off  ) event_perform( ev_draw, 0 );
			
			
			var vld_ = 0;
			var d__ = id;
			var ci = 1;
			var sep_x = 142;
			var xx = 0;
			with ( oplayer ) {
				if ( id != d__ ) {
					vld_ = player_id;
					
					if ( opreference_tracker.char_index_progress[ vld_ ] != -1 ) {
						var _ts = opreference_tracker.char_index_progress[ vld_ ];
						switch(opreference_tracker.char_index[ vld_ ]) {
							case e_char_index.fern:
								draw_sprite_ext( sready_up_fern, 0,  xx+(sep_x*ci)+8, 36+_ts, 1, 1, 0, c_white, 1 );
								draw_sprite_ext( sfern_nametag,  0,  xx+(sep_x*ci)+8, 18-_ts, 1, 1, 0, c_white, 1 );
							break;
							case e_char_index.maya:
								draw_sprite_ext( sready_up_maya, 0,   xx+(sep_x*ci)+8, 36+_ts, 1, 1, 0, c_white, 1 );
								draw_sprite_ext( smaya_name_tag,  0,  xx+(sep_x*ci)+8, 18-_ts, 1, 1, 0, c_white, 1 );
							break;
							case e_char_index.ameli:
								draw_sprite_ext( sready_up_ameli, 0,  xx+(sep_x*ci)+8, 36+_ts, 1, 1, 0, c_white, 1 );
								draw_sprite_ext( sameli_name_tag, 0,  xx+(sep_x*ci)+8, 18-_ts, 1, 1, 0, c_white, 1 );
							break;
						}
					}
					
					draw_sprite_ext( sready_UI_text, opreference_tracker.ready_state[  vld_ ] ? 0 : 1, xx+(sep_x*ci)+13, 40, 1, 1, 0, c_white, 1 );//
					
					if ( player_colour == c_red ) {
						draw_sprite_ext( sready_screen_player_panel,	0, xx+(sep_x*ci)+4, 232, 1, 1, 0, c_white, 1 );
					} else {
						draw_sprite_ext( sready_screen_player_panel_bw, 0, xx+(sep_x*ci)+4, 232, 1, 1, 0, merge_color( c_white, player_colour, 0.4 ), 1 );
					}
					draw_text(  xx + ( sep_x * ci ) + 12, 300, display_name );
					ci++;
				}
				
			}
			
		break;
		#endregion
		#region level select
		case e_meta_state.level_select:
			DSC(c_darkest);
			DSA( 1 );
			draw_rectangle(0,0,room_width,room_height,false);
			DSC(c_white);
			DSA(1);
			draw_sprite_tiled_ext(spattern_victory,0, -level_select_timer*0.1, -level_select_timer*0.1, 2, 2, c_purple, 0.35 );
			
			
			
			if ( first_looser != undefined && first_looser.priority_select_timer > 0 ) {
				with ( first_looser ) {
					var _c_ = player_colour;
					draw_set_halign(fa_center);
					draw_text_transformed_color( GW*0.5, floor(GH*0.18), display_name + " is choosing stage", 2, 2, 0, _c_, _c_, _c_, _c_, 1 );
					draw_set_halign(fa_left);
					var mdx_ = GW*0.5, mdy_ = GH*0.4;
					var ww_ = priority_select_timer/2;
					DSC(_c_);
					draw_rectangle( mdx_-ww_, mdy_-12, mdx_+ww_, mdy_+12, false );
					DSC(c_white);
				}
			} else {
				var _c_ = player_colour;
				draw_set_halign(fa_center);
				draw_text_transformed_color( GW*0.5, floor(GH*0.18), "Anyone can choose stage", 2, 2, 0, _c_, _c_, _c_, _c_, 1 );
				draw_set_halign(fa_left);
			}
			
			if ( global.display_room_name != "" ) {
				var xx_ = floor( GW * 0.50 );
				var yy_ = floor( GH * 0.75 );
				draw_set_halign( fa_center );
				var c = merge_colour( c_white, c_black, 0.9 );
				draw_text_transformed_color( xx_, yy_+1,	global.display_room_name, 3, 3, 0, c,c,c,c, 1 );
				var c = merge_colour( c_white, c_ltgray, 0.1 );
				draw_text_transformed_color( xx_, yy_,		global.display_room_name, 3, 3, 0, c,c,c,c, 1 );
				draw_set_halign( fa_left );
				
				
			}
			
			if ( instance_exists(obutton_levels) ) {
				with ( obutton_levels ) draw_self();
			}
			
		break;
		#endregion
		#region round start
		case e_meta_state.round_start:
			
			if ( instance_exists( oplayer ) < 3 ) {
				draw_sprite_ext( sreadyversus_bg, intro_timer, 0, GH/2, 1, 1, 0, c_white, 1 );
				
				var vll_ = (120-intro_timer)/60;
				vll_ = vll_ * vll_ * vll_;
				var xx = GW*0.5;
				var yy = GH*0.5;
				
				blend_add;
				DSC(  c_orange );DSA( (intro_timer)/120 );
				draw_rectangle( xx-vll_*42, yy-47, xx+vll_*42, yy+46, false );
				DSC( c_white );DSA(1);
				blend_normal;
				
				with ( oplayer ) {
					if ( player_id == 0 ) {
						switch(char_index) {
							case e_char_index.fern:  draw_sprite_ext( sfern_eye,  0,		floor( GW*0.05 ), GH/2-44,  1, 1, 0, c_white, 1 ); break;
							case e_char_index.maya:  draw_sprite_ext( smaya_eye,  0,		floor( GW*0.05 ), GH/2-44,  1, 1, 0, c_white, 1 ); break;
							case e_char_index.ameli: draw_sprite_ext( sameli_eye, 0,		floor( GW*0.05 ), GH/2-44,  1, 1, 0, c_white, 1 ); break;
						}
					} else {
						switch(char_index) {
							case e_char_index.fern:  draw_sprite_ext( sfern_eye_alt,	0,	floor( GW*0.95 ), GH/2-44, -1, 1, 0, c_white, 1 ); break;
							case e_char_index.maya:  draw_sprite_ext( smaya_eye,		0,	floor( GW*0.95 ), GH/2-44, -1, 1, 0, c_white, 1 ); break;
							case e_char_index.ameli: draw_sprite_ext( sameli_eye,		0,	floor( GW*0.95 ), GH/2-44, -1, 1, 0, c_white, 1 ); break;
						}
					}
				}
				
				
				
				draw_sprite_ext( sstart, 0, GW/2-4, GH/2+4, 1, 1, 0, c_blue, 0.4 );
				draw_sprite_ext( sstart, 0, GW/2,	GH/2,	1, 1, 0, c_white, 1 );
				
				
			} else {
				draw_sprite_ext( sstart_bg_rep, 0,  0   + ( ( intro_timer * 40 ) mod 580 ), GH/2, 1, 1, 0, c_white, 1 );
				draw_sprite_ext( sstart_bg_rep, 0, -580 + ( ( intro_timer * 40 ) mod 580 ), GH/2, 1, 1, 0, c_white, 1 );
				var vll_ = (120-intro_timer)/60;
				vll_ = vll_ * vll_ * vll_;
				var xx = GW*0.5;
				var yy = GH*0.5;
				
				blend_add;
				DSC(  c_orange );DSA( (intro_timer)/120 );
				draw_rectangle( xx-vll_*42, yy-47, xx+vll_*42, yy+46, false );
				DSC( c_white );DSA(1);
				blend_normal;
				
				draw_sprite_ext( sstart, 0, GW/2-4, GH/2+4, 1, 1, 0, c_blue, 0.4 );
				draw_sprite_ext( sstart, 0, GW/2,	GH/2,	1, 1, 0, c_white, 1 );
			
			}
			
			//DSC(  merge_color( c_gray, c_orange, 0.5 + ( intro_timer / 240 ) ) );
			//draw_rectangle( xx-vll_*32, yy, xx+vll_*32, yy+16, false );
			//DSC( c_white );
			
			DSC( c_darkest );
			DSA( 0.9 - ( intro_timer / 30 ) );
			draw_rectangle( 0, 0, room_width, room_height, false );
			DSC( c_white );
			DSA( 1 );
			
		break;
		#endregion
		#region main
		case e_meta_state.main:
			if ( intro_timer > 0 ) {
				var sz_ = max( 2, ( ( intro_timer * intro_timer ) / 140 ) );
				draw_sprite_ext( sstart, 1, GW/2, GH/2, sz_, sz_,0, c_orange, 1 );
			}
			
			
		break;
		#endregion
		
		#region round
		case e_meta_state.round_end:
			
			//DSC(c_darkest);
			//DSA( );
			//var rt_ = max( 0.1, -(150-final_timer)/128 );
			
			draw_sprite_tiled_ext( spattern_victory, 0, final_timer*final_effect_speed,final_timer*final_effect_speed, 2, 2, c_darkest,  min( 1, ( final_timer/12 ) - 9 ) );
			//draw_rectangle(0,0,room_width,room_height,false);
			//DSC(c_white);
			//DSA(1);
			
			if ( final_timer == 125*0.95 ) {
				audio_play_sound_pitch( snd_victory, 0.8, 1, 0 );
			}
			
			var xxl_ = GW*0.6;
			if ( final_timer > 100 ) {
				var size_ = 64;
				
				var vv_ = abs( sin( final_timer / 34 ) ) * size_;
				var va_pos = max( 0, 90-(final_timer-100)*2 );
				switch( winner.char_index ) {
					case e_char_index.fern:
						draw_sprite( sfernwinsprite, 0, -va_pos*6, GH );
					break;
					case e_char_index.maya:
						draw_sprite( smaya_victory,  0, -va_pos*6, GH );
					break;
					case e_char_index.ameli:
						draw_sprite( sameli_victory,  0, -va_pos*6, GH );
					break;
				}
				
				
				draw_sprite_stretched_ext( winner.player_avatar_sprite, 0, xxl_-( vv_/2 ), GH*0.4-(size_/2)-va_pos*4 + 8, vv_, size_, c_black, 0.8 ); 
				
				draw_sprite_stretched( winner.player_avatar_sprite, 0, xxl_-( vv_/2 ), GH*0.4-(size_/2)-va_pos*4, vv_, size_ ); 
				draw_set_halign( fa_center );
				var c = c_black;
				draw_text_transformed_colour( xxl_, GH*0.7+va_pos*4+2, ( instance_exists(winner) ? winner.display_name : "" ) + " Wins!!", 3, 3, 0, c, c, c, c, 0.9 );
				c = ( instance_exists(winner) ? merge_colour( c_white, winner.player_colour, 0.5 ) : c_white );
				draw_text_transformed_colour( xxl_, GH*0.7+va_pos*4, ( instance_exists(winner) ? winner.display_name : "" ) + " Wins!!", 3, 3, 0, c, c, c, c, 1 );
				draw_set_halign( fa_left );
			} else {
				draw_sprite_ext( sgame, 0, GW * 0.5, GH * 0.5, 2, 2, 0, c_white, 1 );
			}
			
		break;
		
		#endregion
		
	}
	
	
	#region display stats mid-round
	if ( show_hp_timer > 0 && (meta_state == e_meta_state.main || meta_state == e_meta_state.respawn || meta_state == e_meta_state.dying ) ) {
		var yy = GH*0.5;
		
		if ( show_hp_timer > 90 ) {
			DSA( max(0.7, 1- ( show_hp_timer-90 ) / 10 ) );
		} else {
			DSA( min(0.7,show_hp_timer/30) );
		}
		var pl_alt = instance_number(oplayer) < 3;
		draw_set_halign(fa_center);
		var lc_;
		if ( show_hp_timer > 10 && show_hp_timer < 90 && pl_alt ) {
			DSC(c_black);
			draw_rectangle(-1,yy-16,GW+1,yy+16,false);
			DSA(1);
					
			#region 1v1
			var i = 0; with ( oplayer ) {
				c = merge_colour(c_ltgray,  player_colour, 0.5 );
				
				if    ( meta_state != e_meta_state.main && show_hp_timer < 35 ) c = merge_color( c, c_ltgray, round( (show_hp_timer/8) mod 1 ) );
				lc_ = ( meta_state != e_meta_state.main && show_hp_timer < 35 ) ? lives_left+1 : lives_left;
				
				
				if ( lc_ > 1 ) {
					DSC(c_black);
					draw_text_transformed( GW*0.44 + ( i*(GW*0.1)), yy-29,  lc_, 4, 4, 0 );
					DSC( c );
					draw_text_transformed( GW*0.44 + ( i*(GW*0.1)), yy-29,  lc_, 4, 4, 0 );
					
					if ( i == 0 ) {
						ii = 0; repeat(lc_) {
							draw_sprite_ext(shp_icon,0, ( GW*0.36 + ( i*(GW*0.33)) )-(ii++*18)+8, yy, 1, 1, 0, c, 1  );
						}
					}else {
						ii = 0; repeat(lc_) {
							draw_sprite_ext(shp_icon,0, ( GW*0.26 + ( i*(GW*0.33)) )+(ii++*18)+8, yy, 1, 1, 0, c, 1  );
						}
					}
					i++;
				} else {
					if ( lives_left > 0 ) {
					c = merge_colour(c_ltgray, player_colour, ( show_hp_timer/5 ) mod 1  );
						
						DSC(c_black);
						draw_text_transformed( GW*0.44 + ( i*(GW*0.1)), yy-29,  lc_, 4, 4, 0 );
						DSC( c );
						draw_text_transformed( GW*0.44 + ( i*(GW*0.1)), yy-29,  lc_, 4, 4, 0 );
					
						if ( i == 0 ) {
							draw_sprite_ext(shp_icon,0, ( GW*0.36 + ( i*(GW*0.33)) )+8, yy, 2, 2, 0, c, 1  );
						} else {
							draw_sprite_ext(shp_icon,0, ( GW*0.26 + ( i*(GW*0.33)) )+8, yy, 2, 2, 0, c, 1  );	
						}
					}
					i++;
				}
			}
			#endregion
		}
				
		DSA(1);
		draw_set_halign(fa_left);
		DSC(c_white);
	}
	
	#endregion
			
			
	
	
	var mx_ = device_mouse_x_to_gui( 0 );
	var my_ = device_mouse_y_to_gui( 0 );
	if ( RELOAD[ current_weapon ] >  0 ) {
		var pw = RELOAD[ current_weapon ] * 0.15;
		var xoffset_ = -2;
		var yoffset_ = 2;
		var CAMX = 0;
		var CAMY = 0;
		switch(current_weapon) {
			case e_gun.shotgun:
			case e_gun.rail:
				draw_text( mx_-22-CAMX-xoffset_, my_+7-CAMY-yoffset_, CLIP[ current_weapon ] );
			break;
		}
		 
		if ( CLIP[ current_weapon ] != 99 ) {
			DSA( choose_fixed( 0.7, 0.8, 0.9 ) );
			
			var col = c_dkgray;
			draw_line_width_color(mx_-10-CAMX-xoffset_-1,my_+12-CAMY-yoffset_+1,mx_-10+pw-CAMX-xoffset_-1,my_+12-CAMY-yoffset_+1,5, col, col );
			var col = c_white;
			draw_line_width_color(mx_-10-CAMX-xoffset_,my_+12-CAMY-yoffset_,mx_-10+pw-CAMX-xoffset_,my_+12-CAMY-yoffset_,5, col, col );
		} else {
			var col = c_dkgray;
			draw_line_width_color(mx_-pw-CAMX-xoffset_-1,my_+12-CAMY-yoffset_+1,mx_+pw-CAMX-xoffset_-1,my_+12-CAMY-yoffset_+1,4, col, col );
			var col = c_white;
			draw_line_width_color(mx_-pw-CAMX-xoffset_,my_+12-CAMY-yoffset_,mx_+pw-CAMX-xoffset_,my_+12-CAMY-yoffset_,4, col, col );
		}
		DSA( 1 );
	}

	//var cursor_col = c_white;
	//if ( can_parry_cooldown ) {
	//	cursor_col = merge_color( c_dkgray, c_aqua, 0.4 );
	//}
	draw_sprite_ext( scursor, 0, mx_,  my_, 1, 1, 0, ( !can_dash || can_dodge_cooldown || state == e_player.parry ) ? merge_color( c_dkgray, c_aqua, 0.4 ) : c_white, 1  );
	
	//cursor_col = c_white;
	//if () {
	//	cursor_col = merge_color( c_dkgray, c_orange, 0.5 );
	//}
	draw_sprite_ext( scursor, 1, mx_,  my_, 1, 1, 0,  can_hook_delay || hook_air_cancel ?  merge_color( c_dkgray, c_orange, 0.5 ) : c_white, 1 );
}



