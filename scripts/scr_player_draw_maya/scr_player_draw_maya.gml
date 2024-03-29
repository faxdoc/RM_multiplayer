function scr_player_draw_maya(){
	
	var show_swing = maya_animation_swing_timer > 0;
	
	if ( maya_sword_swing_charge > 19 ) {
		blend_add;
		DSC(c_aqua);DSA(0.5);
		draw_circle( x, y-23, ((60-maya_sword_swing_charge)*0.9)-0, true );
		draw_circle( x, y-23, ((60-maya_sword_swing_charge)*0.9)-1, true );
		draw_circle( x, y-23, ((60-maya_sword_swing_charge)*0.9)-2, true );
		DSC(c_white);DSA(1);
		blend_normal;
	}
	var yl_ = 0;
	var new_hand_y = -2-2;
	var new_head_y = -1-1;
	
	switch( draw_type ) {
		#region maya main
		case e_draw_type.starting_hook:
		case e_draw_type.hook:
		case e_draw_type.aiming:
		var hh = ( can_input && ( state == e_player.normal || state == e_player.hook ) ) ? KRIGHT-KLEFT : 0;
			var bmax = 0, bmin = 0, bdur = 0;
			var bly_ = floor( body_y - land_y );
			var extra_leg_y = ( hh != 0 && on_ground ) ? 4 : 2;
			var xx_ = x;
			var yy_ = y-extra_leg_y+2;
			//draw_sprite( splayer_maya_bow, 0, head_x+( draw_xscale * 6 )+1+hsp, head_y+10 );
			#region general calculate 
			
			
			var body_bonus_x = 0;
			
			var hhp_ = maya_body_tilt;// hh;
			var nhh  = maya_body_tilt;
			var going_back = false;
			if( hh != 0 && hh == draw_xscale ){
				if ( gen_col( x, y+1 ) ) {
					hhp_ *= 1.1;
				}else {
					hhp_ *= 0.5;
				}
				new_hand_y += abs(hhp_)*1;
			}
			if ( hh != draw_xscale && hh != 0 ) {
				hhp_ *= 0.8;
				going_back = true;
				new_hand_y += abs(hhp_)*1;
			}
			var new_arm_x = hhp_*6;
			body_bonus_x += hhp_*3;
			
			#endregion
			
			#region x-y offset
			yy_ -= body_y;
			var bwave = round( wave( bmax, bmin, bdur, 0.89 ) );
			var y_off = var_dir > 0 ? var_dir / 37 : var_dir / 137;
			var xoff = draw_xscale*-2+body_bonus_x;
			xx_ -= xoff;
			
			#endregion
			
			
			#region arm inner
			var recoil_x = LDX( recoil, var_dir )*draw_xscale*0.6;
			var recoil_y = LDY( recoil, var_dir )*0.6;
			shader_set( shd_palette );
			if ( knife_state == 0 || maya_grenade_state == 0 ) {
				
				var inner_arm_x 	= xx_ - 4 * draw_xscale - recoil_x + new_arm_x;
				var inner_arm_y 	= yy_ - 24 + new_hand_y + bwave + y_off - recoil_y - body_y_previous;
				var inner_arm_angle = var_dir * draw_xscale * 0.2 + vsp * 0.5 + ( min( abs( hsp ), 2 ) * 10 * draw_xscale );
				draw_sprite_ext( splayer_maya_hand_inner, 0, inner_arm_x, inner_arm_y, draw_xscale, 1, inner_arm_angle, image_blend, draw_alpha );
				// draw_sprite_ext( splayer_items,	  current_weapon, inner_arm_x+LDX(14,inner_arm_angle-90)+8*draw_xscale, inner_arm_y+LDY(12,inner_arm_angle*draw_xscale)+12, draw_xscale, 1, inner_arm_angle+15*draw_xscale, image_blend, draw_alpha );	
			} else {
				draw_sprite_ext( splayer_maya_hand_inner_knife, knife_timer < 21 ? min(11,knife_timer/1):12,xx_-1*draw_xscale-recoil_x+new_arm_x,yy_+new_hand_y-24+bwave+y_off-recoil_y+1, draw_xscale, 1, 0, image_blend, draw_alpha );
			}
			shader_reset();
			#endregion
			
			#region swing inside
			if ( show_swing && !maya_show_outside_swing ) {
				var aidir = ( var_dir div 2 ) * 2;
				
				var recoil_x = LDX( recoil, var_dir )*draw_xscale;
				var recoil_y = LDY( recoil, var_dir );
				recoil_x *= 0.9;
				recoil_y *= 0.9;
				var ex_ = (var_dir > 0 ? var_dir/10 : var_dir/50);
				new_arm_x -= ex_*draw_xscale*.5;
				new_hand_y -= abs(hh)*.5;
			
				var arm_dir_ = ( var_dir * 0.6 ) - ( min( abs( hsp ), 3 ) * 8 );
			
				bwave = round( wave( bmax, bmin, bdur, 0.88 ) );
				var vl_ = 5;
				switch( floor( shoot_delay ) ) {
					case 29: vl_ = -3; break;
					case 28: vl_ = -4; break;
					case 27: vl_ = -5; break;
					case 26: vl_ = -6; break;
					case 25:
					case 24: 
					case 23: vl_ = 2; break;
				}
				vl_ = (-vl_+2)*draw_xscale;
				
				
				switch(current_weapon) {
					case 0:
						draw_sprite_ext( splayer_maya_sword,  1,
							xx_-1*draw_xscale+new_arm_x-lengthdir_y(2,aidir*draw_xscale )+LDX(vl_,aidir),
							yy_-25+new_hand_y+y_off+bwave-(recoil_y*0.25)+lengthdir_y( 5,aidir )+LDY(vl_,aidir), 
							draw_xscale*0.8, 1, 
						  aidir * draw_xscale, c_white, draw_alpha );
					break;
					case 5:
						draw_sprite_ext( splayer_maya_sword_saw,  1,
							xx_-1*draw_xscale+new_arm_x-lengthdir_y(2,aidir*draw_xscale )+LDX(vl_,aidir),
							yy_-25+new_hand_y+y_off+bwave-(recoil_y*0.25)+lengthdir_y( 5,aidir )+LDY(vl_,aidir), 
							draw_xscale*0.8, 1, 
						  aidir * draw_xscale, c_white, draw_alpha );
					break;
					case 1:
						draw_sprite_ext( splayer_maya_sword_dash,  1,
							xx_-1*draw_xscale+new_arm_x-lengthdir_y(2,aidir*draw_xscale )+LDX(vl_,aidir),
							yy_-25+new_hand_y+y_off+bwave-(recoil_y*0.25)+lengthdir_y( 5,aidir )+LDY(vl_,aidir), 
							draw_xscale*0.8, 1, 
						  aidir * draw_xscale, c_white, draw_alpha );
					break;
					case 4:
						draw_sprite_ext( splayer_maya_sword_star,  1,
							xx_-1*draw_xscale+new_arm_x-lengthdir_y(2,aidir*draw_xscale )+LDX(vl_,aidir),
							yy_-25+new_hand_y+y_off+bwave-(recoil_y*0.25)+lengthdir_y( 5,aidir )+LDY(vl_,aidir), 
							draw_xscale*0.8, 1, 
						  aidir * draw_xscale, c_white, draw_alpha );
					break;
					case 3:
						draw_sprite_ext( splayer_maya_sword_long,  1,
							xx_-1*draw_xscale+new_arm_x-lengthdir_y(2,aidir*draw_xscale )+LDX(vl_,aidir),
							yy_-25+new_hand_y+y_off+bwave-(recoil_y*0.25)+lengthdir_y( 5,aidir )+LDY(vl_,aidir), 
							draw_xscale*0.8, 1, 
						  aidir * draw_xscale, c_white, draw_alpha );
					break;
					case 2:
						draw_sprite_ext( splayer_maya_sword_big,  1,
							xx_-1*draw_xscale+new_arm_x-lengthdir_y(2,aidir*draw_xscale )+LDX(vl_,aidir),
							yy_-25+new_hand_y+y_off+bwave-(recoil_y*0.25)+lengthdir_y( 5,aidir )+LDY(vl_,aidir), 
							draw_xscale*0.8, 1, 
						  aidir * draw_xscale, c_white, draw_alpha );
					break;
				}
			
			
				
				
				draw_sprite_ext( splayer_maya_sword,  2,
					xx_-1*draw_xscale+new_arm_x-lengthdir_y(2,aidir*draw_xscale )+LDX(vl_,aidir),
					yy_-25+new_hand_y+y_off+bwave-(recoil_y*0.25)+lengthdir_y( 5,aidir )+LDY(vl_,aidir), 
					draw_xscale*0.8, 1, 
				  aidir * draw_xscale, maya_sword_blink_colour, ( maya_sword_blink_alpha / 120 ) * 1 );
				
				
			}
			#endregion
			
			//head
			bwave = round( wave( bmax, bmin, bdur, 0.92 ) );
			var xx = var_dir > 0 ? var_dir/10 : var_dir/30;
			var head_x = xx_ - ( 4 * draw_xscale ) - ( xx * draw_xscale * 0.5 ) + ( hhp_ * 6 );
			var head_y = yy_ - 25 + new_head_y + ( y_off * 0.5 ) + bwave + ( crouching ? 1 : 0 ) - 1;
			
			shader_set( shd_palette );
			if ( going_back  ) head_y += abs( maya_body_tilt );
			if ( shoot_delay ) {
				draw_sprite_ext( splayer_maya_head, var_dir > -40 ? (var_dir < 25 ? 1 : ( var_dir < 55 ? 2 : 3 )  ) : 0, round( head_x ), round( head_y ), draw_xscale, 1, 0, image_blend, draw_alpha );
				var eyes = var_dir > -40 ? (var_dir < 25 ? splayer_maya_eyes_mid : ( var_dir < 55 ? splayer_maya_eyes_mid_up : splayer_maya_eyes_up )  ) : splayer_maya_eyes_down;
				draw_sprite_ext(eyes, blink_state,	round( head_x ), round( head_y ), draw_xscale, 1, 0, image_blend, draw_alpha );
				
			} else {
				draw_sprite_ext( splayer_maya_head,     1,			 round(head_x), round(head_y), draw_xscale, 1, 0, image_blend, draw_alpha );
				draw_sprite_ext( splayer_maya_eyes_mid, blink_state, round(head_x), round(head_y), draw_xscale, 1, 0, image_blend, draw_alpha );
				
			}
			
			
			bwave = round(wave(bmax,bmin,bdur,.87));
			var xx = var_dir > 0 ? var_dir/25 : -var_dir/80;
			
			
			#region legs
			if ( on_ground ) {
				if ( round(hsp) == 0 || crouching ) {
					draw_sprite_ext( splayer_maya_legs, legs_index,  x, yy_+extra_leg_y+body_y,draw_xscale,1,0,image_blend,draw_alpha);
				} else {
					draw_sprite_ext( splayer_maya_legs_run, legs_running_index * ( draw_xscale == sign(hsp) ? 1 : -1 ),  x, yy_+extra_leg_y+body_y,draw_xscale,1,0,image_blend,draw_alpha);
				}
			} else {
				draw_sprite_ext( splayer_maya_legs_jump, legs_index,  x, yy_+extra_leg_y+body_y,draw_xscale,1,0,image_blend,draw_alpha);
			}
			
			#endregion
			
			#region body
			bwave = round(wave(bmax,bmin,bdur,0.88));
			var ind = ( var_dir >= 0 ? var_dir/90 * 13.9 : 0 ) div 2;
			var ex = (var_dir < -30) ? -var_dir/80 * draw_xscale : 0;
			
			if( hh == 0 || hh != draw_xscale ) {
				draw_sprite_ext( splayer_maya_body_upper, ind,xx_+ex+nhh,yy_-10+y_off*0.5+bwave-1,draw_xscale,1,-nhh*18, image_blend, draw_alpha );
				if ( hh == 0 || !on_ground || crouching  || abs(hsp) < 1 ) {
					draw_sprite_ext( splayer_maya_body, ind,xx_+ex+nhh,yy_-10+y_off*0.5+bwave-1,draw_xscale,1,-nhh*18, image_blend, draw_alpha );
				}
			} else {
				draw_sprite_ext( splayer_maya_body_upper, ind,xx_+ex+hhp_,yy_-10+y_off*0.5+bwave-1,draw_xscale,1,-hhp_*20, image_blend, draw_alpha );
				if ( hh == 0 || !on_ground || crouching || abs(hsp) < 1 ) {
					draw_sprite_ext( splayer_maya_body, ind,xx_+ex+hhp_,yy_-10+y_off*0.5+bwave-1,draw_xscale,1,-hhp_*20, image_blend, draw_alpha );
				}
			}
			shader_reset();
			#endregion
			
			// shader_set(shader);
			// shader_set_uniform_f_array( shader_pointer, col_to_array( gun_col, 1 ) );
			
			#region outer swing
			var xx = var_dir > 0 ? var_dir/40 : var_dir/80;
			var aidir = var_dir div 2 * 2;

			var recoil_x = LDX( recoil, var_dir )*draw_xscale;
			var recoil_y = LDY( recoil, var_dir );
			recoil_x *= 0.9;
			recoil_y *= 0.9;
			var ex_ = ( var_dir > 0 ? var_dir/10 : var_dir/50 );
			
			var arm_dir_ = ( var_dir * 0.6 ) - ( min( abs( hsp ), 3 ) * 8 );
			
			bwave = round( wave( bmax, bmin, bdur, 0.88 ) );
			
			if ( !show_swing ) {
				switch(current_weapon) {
					case 0:
						draw_sprite_ext( splayer_maya_sword,  1,
							xx_-4*draw_xscale+new_arm_x+LDX(14,arm_dir_*draw_xscale + -90 ),
							yy_-22+						new_hand_y+y_off+bwave-(recoil_y*0.25)+LDY(14,arm_dir_*draw_xscale + -90 ), 
							draw_xscale, 1, 
						(  arm_dir_ * draw_xscale * ( arm_dir_ > 0 ? 1 : 0.4 ) ) - ( 60 * draw_xscale )+( min(hsp*.1,5)* 10 ), c_gray, draw_alpha );
					break;
					case 5:
						draw_sprite_ext( splayer_maya_sword_saw,  1,
							xx_-4*draw_xscale+new_arm_x+LDX(14,arm_dir_*draw_xscale + -90 ),
							yy_-22+						new_hand_y+y_off+bwave-(recoil_y*0.25)+LDY(14,arm_dir_*draw_xscale + -90 ), 
							draw_xscale, 1, 
						(  arm_dir_ * draw_xscale * ( arm_dir_ > 0 ? 1 : 0.4 ) ) - ( 60 * draw_xscale )+( min(hsp*.1,5)* 10 ), c_gray, draw_alpha );
					break;
					case 1:
						draw_sprite_ext( splayer_maya_sword_dash,  1,
							xx_-4*draw_xscale+new_arm_x+LDX(14,arm_dir_*draw_xscale + -90 ),
							yy_-22+						new_hand_y+y_off+bwave-(recoil_y*0.25)+LDY(14,arm_dir_*draw_xscale + -90 ), 
							draw_xscale, 1, 
						(  arm_dir_ * draw_xscale * ( arm_dir_ > 0 ? 1 : 0.4 ) ) - ( 60 * draw_xscale )+( min(hsp*.1,5)* 10 ), c_gray, draw_alpha );
					break;
					case 4:
						draw_sprite_ext( splayer_maya_sword_star,  1,
							xx_-4*draw_xscale+new_arm_x+LDX(14,arm_dir_*draw_xscale + -90 ),
							yy_-22+						new_hand_y+y_off+bwave-(recoil_y*0.25)+LDY(14,arm_dir_*draw_xscale + -90 ), 
							draw_xscale, 1, 
						(  arm_dir_ * draw_xscale * ( arm_dir_ > 0 ? 1 : 0.4 ) ) - ( 60 * draw_xscale )+( min(hsp*.1,5)* 10 ), c_gray, draw_alpha );
					break;
					case 3:
						draw_sprite_ext( splayer_maya_sword_long,  1,
							xx_-4*draw_xscale+new_arm_x+LDX(14,arm_dir_*draw_xscale + -90 ),
							yy_-22+						new_hand_y+y_off+bwave-(recoil_y*0.25)+LDY(14,arm_dir_*draw_xscale + -90 ), 
							draw_xscale, 1, 
						(  arm_dir_ * draw_xscale * ( arm_dir_ > 0 ? 1 : 0.4 ) ) - ( 60 * draw_xscale )+( min(hsp*.1,5)* 10 ), c_gray, draw_alpha );
					break;
					case 2:
						draw_sprite_ext( splayer_maya_sword_big,  1,
							xx_-4*draw_xscale+new_arm_x+LDX(14,arm_dir_*draw_xscale + -90 ),
							yy_-22+						new_hand_y+y_off+bwave-(recoil_y*0.25)+LDY(14,arm_dir_*draw_xscale + -90 ), 
							draw_xscale, 1, 
						(  arm_dir_ * draw_xscale * ( arm_dir_ > 0 ? 1 : 0.4 ) ) - ( 60 * draw_xscale )+( min(hsp*.1,5)* 10 ), c_gray, draw_alpha );
					break;
					
				}
				
				draw_sprite_ext( splayer_maya_sword,  2,
					xx_-4*draw_xscale+new_arm_x+LDX(14,arm_dir_*draw_xscale + -90 ),
					yy_-22+new_hand_y+y_off+bwave-(recoil_y*0.25)+LDY(14,arm_dir_*draw_xscale + -90 ), 
					draw_xscale, 1, 
				(  arm_dir_ * draw_xscale * ( arm_dir_ > 0 ? 1 : 0.4 ) ) - ( 60 * draw_xscale )+( min(hsp*.1,5)* 10 ), 
					maya_sword_blink_colour, ( maya_sword_blink_alpha / 120 ) * 1 );
			
			
			
			
				// shader_reset();
				// start_palette();
				shader_set( shd_palette );
				bwave = round( wave( bmax, bmin, bdur, 0.9 ) );
				draw_sprite_ext( splayer_maya_hand_outer, 0, xx_-4*draw_xscale+new_arm_x,yy_-23+new_hand_y+y_off+bwave-recoil_y*.25, draw_xscale, 1,   arm_dir_*draw_xscale, image_blend, draw_alpha );
			
				shader_reset();
			} else {
				bwave = round( wave( bmax, bmin, bdur, 0.9 ) );
				if ( maya_show_outside_swing ) {
					
					switch(current_weapon) {
						case 0:
							draw_sprite_ext( splayer_maya_sword,  1,
							xx_ -  4 * draw_xscale+new_arm_x+LDX( 14, arm_dir_ * draw_xscale + -90 ),
							yy_ - 22 + new_hand_y+y_off+bwave-(recoil_y*0.25)+LDY(14,arm_dir_*draw_xscale + -90 ), 
							draw_xscale, 1, 
						(  arm_dir_ * draw_xscale * ( arm_dir_ > 0 ? 1 : 0.4 ) ) - ( 60 * draw_xscale )+( min(hsp*.1,5)* 10 ), c_gray, draw_alpha );
						break;
						case 5:
							draw_sprite_ext( splayer_maya_sword_saw,  1,
							xx_ -  4 * draw_xscale+new_arm_x+LDX( 14, arm_dir_ * draw_xscale + -90 ),
							yy_ - 22 + new_hand_y+y_off+bwave-(recoil_y*0.25)+LDY(14,arm_dir_*draw_xscale + -90 ), 
							draw_xscale, 1, 
						(  arm_dir_ * draw_xscale * ( arm_dir_ > 0 ? 1 : 0.4 ) ) - ( 60 * draw_xscale )+( min(hsp*.1,5)* 10 ), c_gray, draw_alpha );
						break;
						case 1:
							draw_sprite_ext( splayer_maya_sword_dash,  1,
							xx_ -  4 * draw_xscale+new_arm_x+LDX( 14, arm_dir_ * draw_xscale + -90 ),
							yy_ - 22 + new_hand_y+y_off+bwave-(recoil_y*0.25)+LDY(14,arm_dir_*draw_xscale + -90 ), 
							draw_xscale, 1, 
						(  arm_dir_ * draw_xscale * ( arm_dir_ > 0 ? 1 : 0.4 ) ) - ( 60 * draw_xscale )+( min(hsp*.1,5)* 10 ), c_gray, draw_alpha );
						break;
						case 4:
							draw_sprite_ext( splayer_maya_sword_star,  1,
							xx_ -  4 * draw_xscale+new_arm_x+LDX( 14, arm_dir_ * draw_xscale + -90 ),
							yy_ - 22 + new_hand_y+y_off+bwave-(recoil_y*0.25)+LDY(14,arm_dir_*draw_xscale + -90 ), 
							draw_xscale, 1, 
						(  arm_dir_ * draw_xscale * ( arm_dir_ > 0 ? 1 : 0.4 ) ) - ( 60 * draw_xscale )+( min(hsp*.1,5)* 10 ), c_gray, draw_alpha );
						break;
						case 3:
							draw_sprite_ext( splayer_maya_sword_long,  1,
							xx_ -  4 * draw_xscale+new_arm_x+LDX( 14, arm_dir_ * draw_xscale + -90 ),
							yy_ - 22 + new_hand_y+y_off+bwave-(recoil_y*0.25)+LDY(14,arm_dir_*draw_xscale + -90 ), 
							draw_xscale, 1, 
						(  arm_dir_ * draw_xscale * ( arm_dir_ > 0 ? 1 : 0.4 ) ) - ( 60 * draw_xscale )+( min(hsp*.1,5)* 10 ), c_gray, draw_alpha );
						break;
						case 2:
							draw_sprite_ext( splayer_maya_sword_big,  1,
							xx_ -  4 * draw_xscale+new_arm_x+LDX( 14, arm_dir_ * draw_xscale + -90 ),
							yy_ - 22 + new_hand_y+y_off+bwave-(recoil_y*0.25)+LDY(14,arm_dir_*draw_xscale + -90 ), 
							draw_xscale, 1, 
						(  arm_dir_ * draw_xscale * ( arm_dir_ > 0 ? 1 : 0.4 ) ) - ( 60 * draw_xscale )+( min(hsp*.1,5)* 10 ), c_gray, draw_alpha );
						break;
						
					}
					
					draw_sprite_ext( splayer_maya_sword,  2,
						xx_-4*draw_xscale+new_arm_x+LDX(14,arm_dir_*draw_xscale + -90 ),
						yy_-22+						new_hand_y+y_off+bwave-(recoil_y*0.25)+LDY(14,arm_dir_*draw_xscale + -90 ), 
						draw_xscale, 1, 
					(  arm_dir_ * draw_xscale * ( arm_dir_ > 0 ? 1 : 0.4 ) ) - ( 60 * draw_xscale )+( min(hsp*.1,5)* 10 ), 
						maya_sword_blink_colour, ( maya_sword_blink_alpha / 120 ) * 1 );
						
					shader_set( shd_palette );
					draw_sprite_ext( splayer_maya_hand_outer_swing_animation_alt, min( ( 30 - shoot_delay ) / 2, 5 ), xx_-4*draw_xscale+new_arm_x,yy_-23+new_hand_y+y_off+bwave-recoil_y*0.25, draw_xscale, 1,   aidir*draw_xscale, image_blend, draw_alpha );
					shader_reset();
				} else {
					shader_set( shd_palette );
					draw_sprite_ext( splayer_maya_hand_outer_swing_animation, min( ( 30 - shoot_delay ) / 2, 5 ), xx_-4*draw_xscale+new_arm_x,yy_-23+new_hand_y+y_off+bwave-recoil_y*0.25, draw_xscale, 1,   aidir*draw_xscale, image_blend, draw_alpha );
					shader_reset();
				}
			}
			#endregion
			
			
			
			if ( current_weapon == e_gun.sniper && knife_state > 0 ) {
				var drr = point_direction(xx_,yy_-gun_height,MX,MY);
				var sx_ = xx_+			LDX( 42, drr );
				var sy_ = yy_-gun_height+ LDY( 42, drr )+( crouching ? 4 : 0 )-1;
				
				var xx_ = sx_;
				var yy_ = sy_;
				var blend_ = true;
				var i = 27; while(i-- && !gen_col(xx_,yy_)) {
					if( blend_ ){
						DSA( 0.4 );
					} else {
						DSA( 0.2 );
					}
					
					var draw_len_ = 8;// + ( gun_charge mod 9 );
					draw_line_width_color(xx_,yy_,xx_+LDX(draw_len_,drr),yy_+LDY(draw_len_,drr),8.1, blend_ ? merge_color(c_white,c_aqua,.9) : c_red, blend_ ? c_aqua : c_orange );
					xx_ += LDX( 7, drr );
					yy_ += LDY( 7, drr );
				}
				DSA(1);
			}
		
		break;
		#endregion
		
		#region maya animation
		case e_draw_type.animation:
			shader_set( shd_palette );
			if ( sprite_index == smaya_parry ) {
				
				draw_sprite_ext(
					sprite_index,
					on_ground ? 0 : 1,
					x,
					y,
					draw_xscale,
					image_yscale,
					draw_angle,
					image_blend,
					draw_alpha
				);
			} else {
				draw_sprite_ext(
					sprite_index,
					image_index,
					x,
					y,
					draw_xscale,
					image_yscale,
					draw_angle,
					image_blend,
					draw_alpha
				);
			}
			
			
			shader_reset();
		break;
		#endregion
		
		
	}
	
}