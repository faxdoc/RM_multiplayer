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
	
	if ( flash_alpha > 0 ) {
		DSC( screen_flash_col	 );
		DSA( flash_alpha	* 0.6);
		draw_rectangle(0,0,room_width,room_height,false);
		DSC(c_white);
		DSA(1);
		
	}
	switch( meta_state ) {
		case 6:
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
					var ww_ = priority_select_timer;
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
				
				var xx_ = floor(GW*0.5);
				var yy_ = floor(GH*0.75);
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
		case -1:
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
		case 1:
			if ( intro_timer > 0 ) {
				var sz_ = max(2,( (intro_timer*intro_timer)/140));
				draw_sprite_ext(sstart,1,GW/2,GH/2,sz_,sz_,0, c_orange, 1 );
			}
			
			
		break;
		
		case 5:
			DSC(c_darkest);
			DSA( min(0.8, ( final_timer/100 ) - 0.7 ) );
			draw_rectangle(0,0,room_width,room_height,false);
			DSC(c_white);
			DSA(1);
			if ( final_timer > 120 ) {
				draw_set_halign(fa_center);
				draw_text_transformed(GW/2,GH/2,lives_left <= 0 ? "Opponent win" : "You win", 3, 3, 0 );
				draw_set_halign(fa_left);
			}
		break;
	}
	
	if ( show_hp_timer > 0 && (meta_state == 0 || meta_state == 1 || meta_state == 2 ) ) {
		var yy = GH*0.5;
		
		if ( show_hp_timer > 90 ) {
			DSA( max(0.7, 1- ( show_hp_timer-90 ) / 10 ) );
		} else {
			DSA( min(0.7,show_hp_timer/30) );
		}
		var pl_alt = instance_number(oplayer) < 3;
		if ( pl_alt ) {
			DSC(c_black);
			draw_rectangle(-1,yy-16,GW+1,yy+16,false);
			DSA(1);
		} else {
			yy -= 32;
			DSC(c_black);
			draw_rectangle(-1,yy-16,GW+1,yy+16,false);
			yy += 64;
			draw_rectangle(-1,yy-16,GW+1,yy+16,false);
			DSA(1);
			yy -= 64;
		}
		
		
		draw_set_halign(fa_center);
		var lc_;
		if ( show_hp_timer > 10 && show_hp_timer < 90 ) {
			if ( pl_alt ) {
				#region 1v1
				//if ( show_hp_timer > 90 ) {
				//	DSA( max(0.7, 1- ( show_hp_timer-90 ) / 10 ) );
				//} else {
				//	DSA( min(0.7,show_hp_timer/30) );
				//}
		
				var i = 0; with ( oplayer ) {
					c = merge_colour(c_ltgray,  player_colour, 0.5 );
				
					if    ( meta_state != 1 && show_hp_timer < 35 ) c = merge_color( c, c_ltgray, round( (show_hp_timer/8) mod 1 ) );
					lc_ = ( meta_state != 1 && show_hp_timer < 35 ) ? lives_left+1 : lives_left;
				
				
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
			} else {
				#region 3-4 players
				
				
				//var i = 0, nll = 0; with ( oplayer ) {
				//	if ( nll == 2 ) yy += 64;
				//	c = merge_colour(c_ltgray,  player_colour, 0.5 );
				
				//	if    ( meta_state != 1 && show_hp_timer < 35 ) c = merge_color( c, c_ltgray, round( (show_hp_timer/8) mod 1 ) );
				//	lc_ = ( meta_state != 1 && show_hp_timer < 35 ) ? lives_left+1 : lives_left;
					
				
				//	if ( lc_ > 1 ) {
				//		DSC(c_black);
				//		draw_text_transformed( GW*0.44 + ( i*(GW*0.1)), yy-29,  lc_, 4, 4, 0 );
				//		DSC( c );
				//		draw_text_transformed( GW*0.44 + ( i*(GW*0.1)), yy-29,  lc_, 4, 4, 0 );
					
				//		if ( i == 0 ) {
				//			ii = 0; repeat(lc_) {
				//				draw_sprite_ext(shp_icon,0, ( GW*0.36 + ( i*(GW*0.33)) )-(ii++*18)+8, yy, 1, 1, 0, c, 1  );
				//			}
				//		}else {
				//			ii = 0; repeat(lc_) {
				//				draw_sprite_ext(shp_icon,0, ( GW*0.26 + ( i*(GW*0.33)) )+(ii++*18)+8, yy, 1, 1, 0, c, 1  );
				//			}
				//		}
				//		i++;
				//		i = i mod 2;
						
				//	} else {
						
				//		if ( lives_left > 0 ) {
				//			c = merge_colour(c_ltgray, player_colour, ( show_hp_timer/5 ) mod 1  );
					
				//			DSC(c_black);
				//			draw_text_transformed( GW*0.44 + ( i*(GW*0.1)), yy-29,  lc_, 4, 4, 0 );
				//			DSC( c );
				//			draw_text_transformed( GW*0.44 + ( i*(GW*0.1)), yy-29,  lc_, 4, 4, 0 );
					
				//			if ( i == 0 ) {
				//				draw_sprite_ext(shp_icon,0, ( GW*0.36 + ( i*(GW*0.33)) )+8, yy, 2, 2, 0, c, 1  );
				//			} else {
				//				draw_sprite_ext(shp_icon,0, ( GW*0.26 + ( i*(GW*0.33)) )+8, yy, 2, 2, 0, c, 1  );	
				//			}
				//		}
				//		i++;
				//		i = i mod 2;
						
				//	}
				//	nll++;
				//}
				#endregion
			}
			
			
			
		}
		DSA(1);
		draw_set_halign(fa_left);
		DSC(c_white);
	}
			
	var cursor_col = c_white;
	if (  ( can_hook_delay || hook_air_cancel ) ) {
		cursor_col = merge_color( c_dkgray, c_orange, 0.5 );
	}
	draw_sprite_ext( scursor, 1, device_mouse_x_to_gui(0),  device_mouse_y_to_gui(0), 1, 1, 0, cursor_col, 1 );
	draw_sprite_ext( scursor, 0, device_mouse_x_to_gui(0),  device_mouse_y_to_gui(0), 1, 1, 0, cursor_col, 1 );
}



