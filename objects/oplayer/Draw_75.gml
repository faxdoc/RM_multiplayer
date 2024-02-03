if ( player_local ) {
	var xoffset_ = 0;
	var yoffset_ = 0;
	
	
	shader_set(shd_max_a);
	draw_surface_part(application_surface,frac(camera_x),frac(camera_y),GW*2,GH*2,round(screen_shake_x)-xoffset_, round(screen_shake_y)-yoffset_);
	shader_reset();
	var ii = 0,c = -1;
	var yl_ = GH*0.92;
	var i = 0; with ( oplayer ) {
		c = merge_colour(c_ltgray, player_colour, 0.5 );
		DSC( c_dkgray );
		draw_text( GW*0.15 + ( i*(GW*0.2)), 1+ yl_,  display_name );
		DSC( c );
		
		draw_text( GW*0.15 + ( i*(GW*0.2)), yl_,   display_name );
		ii = 0; repeat(lives_left) {
			draw_sprite_ext(shp_icon,0, ( GW*0.15 + ( i*(GW*0.2)) )+(ii++*18)+8, yl_-8, 1, 1, 0, c, 1  );
		}
		i++;
		
		DSC(c_white);
	}
	
	var bx = GW*0.5;
	var by = floor( GH*0.7 );
	var mds_ = 16;
	var rl_ = 0;
	var ex_ = 0;
	var wep_list  = [ 0, 5, 1, 4, 3, 2 ];
	var rls			= [ 96, 320, 120,  135, 135,  900 ];
	var cl_col = merge_color( c_dkgray, c_red, 0.5 );
	//var gun_sprites = [ splayer_gun_pistol_silhouette, splayer_gun_small_silhouette, splayer_gun_shotgun_silhouette, splayer_gun_grenade_silhoutte, splayer_gun_sniper_silhouette, splayer_gun_rail_silhouette ];
	var i = -3; repeat( 6 ) {
		
		//var ex_ = current_weapon == wep_list[i] ? -4 : -28;
		//draw_sprite_ext( gun_sprites[i], 0, ex_+bx-2, by+i*mds_,   1.5, 1.5,  0, c_dkgray, 1 );
		//draw_sprite_ext( gun_sprites[i], 0, ex_+bx+2, by+i*mds_,   1.5, 1.5,  0, c_dkgray, 1 );
		//draw_sprite_ext( gun_sprites[i], 0, ex_+bx,   by+i*mds_-2, 1.5, 1.5,  0, c_dkgray, 1 );
		//draw_sprite_ext( gun_sprites[i], 0, ex_+bx,   by+i*mds_+2, 1.5, 1.5,  0, c_dkgray, 1 );
		
		
		draw_sprite_ext( scooldown_box, 0, ex_+bx+i*mds_, by, 1, 1, 0, c_white, 1 );		
		draw_sprite_ext( sgun_icon,		i, ex_+bx+i*mds_, by, 1, 1, 0, c_white, 1 );
		
		if ( current_weapon == wep_list[i+3] ) {
			
		}
		rl_ = RELOAD[wep_list[i+3]];
		if ( rl_ > 0 ) {
			draw_sprite_ext( scooldown, ( rl_/rls[i+3] )*15, ex_+bx+i*mds_, by, 1, 1, 0, c_black, 0.9 );
		}
		
		//rl_ = RELOAD[wep_list[i]];
		//if ( rl_ > 5 ) {
		//	if  current_weapon == wep_list[i] {
		//		draw_sprite_part_ext( gun_sprites[i], 0, 0, 0, 38 -(rl_/rls[i] )*44, 12, bx-4, by+i*mds_, 1.5, 1.5, cl_col, 1 );
		//	} else {
		//		draw_sprite_part_ext( gun_sprites[i], 0, 0, 0, 38 -(rl_/rls[i] )*44, 12, bx-28, by+i*mds_, 1.5, 1.5, cl_col, 1 );
		//	}
		//} else {
		//	if current_weapon == wep_list[i] {
		//		draw_sprite_part_ext( gun_sprites[i], 0, 0, 0, 44-( rl_/rls[i] )*44, 12, bx-4, by+i*mds_, 1.5, 1.5, c_ltgray, 1 );
		//	} else {
		//		draw_sprite_part_ext( gun_sprites[i], 0, 0, 0, 44-( rl_/rls[i] )*44, 12, bx-28, by+i*mds_, 1.5, 1.5, c_gray, 1 );	
		//	}
		//}
		i++;
	}
	
	if ( flash_alpha > 0 ) {
		DSC( screen_flash_col	 );
		DSA( flash_alpha	* 0.6);
		draw_rectangle(0,0,room_width,room_height,false);
		DSC(c_white);
		DSA(1);
		
	}
	switch( meta_state ) {
		#region level select
		case e_meta_state.level_select:
			DSC(c_darkest);
			DSA( 0.9 );
			draw_rectangle(0,0,room_width,room_height,false);
			DSC(c_white);
			DSA(1);
			
			if ( first_looser != undefined && first_looser.priority_select_timer > 0 ) {
				with ( first_looser ) {
					var _c_ = player_colour;
					draw_set_halign(fa_center);
					draw_text_transformed_color( GW*0.5, floor(GH*0.28), display_name + " is choosing stage", 2, 2, 0, _c_, _c_, _c_, _c_, 1 );
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
				draw_text_transformed_color( GW*0.5, floor(GH*0.28), "Anyone can choose stage", 2, 2, 0, _c_, _c_, _c_, _c_, 1 );
				draw_set_halign(fa_left);
			}
			
			if ( global.display_room_name != "" ) {
				var xx_ = floor( GW * 0.5  );
				var yy_ = floor( GH * 0.75 );
				draw_set_halign(fa_center);
				var c = merge_colour(c_white,c_black,0.9);
				draw_text_transformed_color( xx_, yy_+1, global.display_room_name, 3, 3, 0, c,c,c,c, 1 );
				var c = merge_colour(c_white,c_ltgray,0.1);
				draw_text_transformed_color( xx_, yy_, global.display_room_name, 3, 3, 0, c,c,c,c, 1 );
				draw_set_halign(fa_left);
				
				
			}
			
			if ( instance_exists(obutton_levels) ) {
				with ( obutton_levels ) draw_self();
			}
			
		break;
		case e_meta_state.round_start:
			draw_sprite_ext(sstart,0,GW/2,GH/2, 2, 2, 0, merge_color( c_gray, c_orange, 0.5 + ( intro_timer / 240 ) ), 1 );
			var vll_ = (120-intro_timer)/60;
			
			vll_ = vll_ * vll_ * vll_;
			var xx = GW*0.5;
			var yy = GH*0.7;
			
			
			DSC(  merge_color( c_gray, c_red, 0.3 + ( intro_timer / 240 ) ) );
			draw_rectangle( xx-vll_*42, yy, xx+vll_*42, yy+16, false );
			DSC( c_white );
			
			DSC(  merge_color( c_gray, c_orange, 0.5 + ( intro_timer / 240 ) ) );
			draw_rectangle( xx-vll_*32, yy, xx+vll_*32, yy+16, false );
			DSC( c_white );
			
			DSC(c_darkest);
			DSA( 0.9- (intro_timer/30) );
			draw_rectangle(0,0,room_width,room_height,false);
			DSC(c_white);
			DSA(1);
			
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
			
			DSC(c_darkest);
			DSA( min( 0.9, ( final_timer/10 ) - 9 ) );
			draw_rectangle(0,0,room_width,room_height,false);
			DSC(c_white);
			DSA(1);
			if ( final_timer == 125 ) {
				audio_play_sound_pitch( snd_victory, 0.8, 1, 0 );
			}
			if ( final_timer > 100 ) {
				var size_ = 128;
				
				var vv_ = abs( sin( final_timer / 24 ) ) * size_;
				var va_pos = max( 0, 90-(final_timer-100)*2 );
				
				draw_sprite_stretched_ext( winner.player_avatar_sprite, 0, GW*0.5-( vv_/2 ), GH*0.4-(size_/2)-va_pos*4 + 8, vv_, size_, c_black, 0.8 ); 
				
				draw_sprite_stretched( winner.player_avatar_sprite, 0, GW*0.5-( vv_/2 ), GH*0.4-(size_/2)-va_pos*4, vv_, size_ ); 
				draw_set_halign( fa_center );
				var c = c_black;
				draw_text_transformed_colour( GW*0.5, GH*0.75+va_pos*4+2, ( instance_exists(winner) ? winner.display_name : "" ) + " Wins!!", 3, 3, 0, c, c, c, c, 0.9 );
				c = ( instance_exists(winner) ? merge_colour( c_white, winner.player_colour, 0.5 ) : c_white );
				draw_text_transformed_colour( GW*0.5, GH*0.75+va_pos*4, ( instance_exists(winner) ? winner.display_name : "" ) + " Wins!!", 3, 3, 0, c, c, c, c, 1 );
				draw_set_halign( fa_left );
			} else {
				draw_sprite_ext(sgame,0,GW*0.5,GH*0.5, 2, 2, 0, c_white, 1 );
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
			
			
	
	
	var mx_ = device_mouse_x_to_gui(0);
	var my_ = device_mouse_y_to_gui(0);
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



