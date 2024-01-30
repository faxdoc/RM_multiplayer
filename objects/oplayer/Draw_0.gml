var hh = ( can_input ) ? KRIGHT-KLEFT : 0;
var vv = ( can_input ) ? KDOWN-KUP : 0;

var bwave, bmax =-1, bmin = 0, bdur = 4;
if ( hit_freeze ) {
	draw_sprite_ext(
		sprite_index,
		image_index,
		x+(hit_freeze mod 3),
		y+((hit_freeze+2) mod 3),
		draw_xscale,
		image_yscale,
		draw_angle,
		image_blend+hit_freeze/3,
		image_alpha
	);
	exit;
}
if ( state == e_player.hit ) {
	if ( hh != 0 || vv != 0 ) {
		var di_dir = point_direction(0,0,hh,vv);
		draw_sprite_ext(sdi_indicator,player_id,x,y-22,1,1,di_dir,c_white, 1 ); 
	}
}
if ( !self_draw ) {
	exit;
}


//#macro blend_add	gpu_set_blendmode(bm_add)
//#macro blend_normal gpu_set_blendmode(bm_normal)
//#macro DSA			draw_set_alpha
//#macro RR			random_range_fixed
//draw_rectangle( x-8, y-32, x+8, y, false );



//var var_dir = aim_dir;

#region hit flash etc

if ( flash ) gpu_set_fog( true, flash_col, -1, 0 );

#endregion


draw_set_halign(fa_center);
var intcol_ =  merge_colour(c_ltgray, player_colour, 0.5 );
var fx_ = floor(x);
var fy_ = floor(y);

draw_text_color(fx_-4,fy_-59, ceil(hp), c_black, c_black, c_black, c_black, 1  );
draw_text_color(fx_-4,fy_-60, ceil(hp), intcol_, intcol_, intcol_, intcol_, 1  );
draw_set_halign(fa_left);
if (!grenade_cooldown && knife_state == 0 ) {
	draw_sprite_ext( splayer_grenade_silhouete, 0, fx_+10, fy_-51, 1, 1, 0, intcol_, 1 );
}
//draw_circle_colour(x-draw_xscale*2,y-30, 9, intcol_,intcol_, true );
//draw_circle_colour(x-draw_xscale*2,y-30, 9.5, intcol_,intcol_, true );
//draw_circle_colour(x-draw_xscale*2,y-30, 10, intcol_,intcol_, true );


var intcol_ =  merge_colour(c_ltgray, player_colour, 0.5 );
draw_circle_colour(x-draw_xscale*2,y-30, 7, intcol_,intcol_, false );
draw_circle_colour(x-draw_xscale*2,y-30, 9, intcol_,intcol_, true );
draw_circle_colour(x-draw_xscale*2,y-30, 9.5, intcol_,intcol_, true );
draw_circle_colour(x-draw_xscale*2,y-30, 10, intcol_,intcol_, true );
#region Fern Mode
switch( draw_type ) {
	#region hook visual
	case e_draw_type.starting_hook:
		//var adr = point_direction( x, y-24, MX, MY );
		//DSA(choose_fixed( 0.5, 0.55, 0.6 )*wave( 1, 1.4, 3, 0 ) );
		//draw_line_color(	x+LDX(  40, adr ), y - 24 + LDY( 40,  adr ),x+LDX(125,adr),y-24+LDY(125,adr),c_dkgray,c_orange);
		//draw_circle_color(	x+LDX( 140, adr ), y - 24 + LDY( 140, adr ),7,c_orange,c_orange,true);
		//DSA(1);
	#endregion
	
	#region main
	case e_draw_type.hook:
	case e_draw_type.aiming:
		
		var bly_ = floor(body_y-land_y);
		var yl_ = y-bly_+1;
		//y -= bly_;
		bwave = round(wave(bmax,bmin,bdur,.89));
		var y_off = var_dir > 0 ? var_dir / 37 : var_dir / 137;
		var xoff = draw_xscale*-2;
		//x -= xoff;
		var recoil_x = LDX( recoil, var_dir ) * draw_xscale * 0.6;
		var recoil_y = LDY( recoil, var_dir ) * 0.6;
		
		if ( knife_state == 0 ) {
			scr_player_draw_guns_inner( var_dir, recoil_x, bwave, y_off-bly_, recoil_y );
		} else {
			//player_throw_grenade();
			draw_sprite_ext( splayer_hand_inner_knife, knife_timer < 21 ? min(11,knife_timer/1):12,x-1*draw_xscale-recoil_x,yl_-24+bwave+y_off-recoil_y+1, draw_xscale, 1, 0, image_blend, draw_alpha );
		}
		

		bwave = round( wave( bmax, bmin, bdur, 0.87 ) );
		var xx = var_dir > 0 ? var_dir / 25 : -var_dir / 80;
		draw_sprite_ext( splayer_jacket_back, 0, x+1*draw_xscale-xx*draw_xscale,yl_-8+y_off*.4+bwave,draw_xscale,1,0,image_blend,draw_alpha);
		//legs
		
		//switch(legs) {
			//case splayer_legs:
			if ( on_ground ) {
				if ( round(hsp) == 0 ) {
					draw_sprite_ext( splayer_legs, legs_index,  x, yl_+bly_,draw_xscale,1,0,image_blend,draw_alpha);
				} else {
					draw_sprite_ext( splayer_legs_run, legs_running_index*draw_xscale,  x, yl_+bly_,draw_xscale,1,0,image_blend,draw_alpha);
				}
			} else {
				draw_sprite_ext( splayer_legs_jump, legs_index,  x, yl_+bly_,draw_xscale,1,0,image_blend,draw_alpha);
			}
			//break;
			//case splayer_legs_crouching:
			//	draw_sprite_ext( splayer_legs_crouching, legs_index,  x, y+bly_,draw_xscale,1,0,image_blend,draw_alpha);
			//break;
			//case splayer_legs_jump:
			//	draw_sprite_ext( splayer_legs_jump, legs_index,  x, y+bly_,draw_xscale,1,0,image_blend,draw_alpha);
			//break;
			//case splayer_legs_run:
			//	draw_sprite_ext( splayer_legs_run, legs_index,  x, y+bly_,draw_xscale,1,0,image_blend,draw_alpha);
			//break;
			//case splayer_legs_start_run:
			//	draw_sprite_ext( splayer_legs_start_run, legs_index,  x, y+bly_,draw_xscale,1,0,image_blend,draw_alpha);
			//break;
			//case splayer_legs_stop:
			//	draw_sprite_ext( splayer_legs_stop, legs_index,  x, y+bly_,draw_xscale,1,0,image_blend,draw_alpha);
			//break;
		//}
		

		//body
		bwave = round(wave(bmax,bmin,bdur,.88));
		var ind = var_dir >= 0 ? var_dir/90 * 13.9 : 0;
		var ex = (var_dir < -30) ? -var_dir/80 * draw_xscale : 0;
		draw_sprite_ext( splayer_body, ind,x+ex,yl_-10+y_off*.5+bwave,draw_xscale,1,0,image_blend,draw_alpha);
		
		var xx = var_dir > 0 ? var_dir/40 : var_dir/80;
		draw_sprite_ext( splayer_hoodie,0,x-8*draw_xscale-xx*1.5*draw_xscale,yl_-22+y_off*1.4+bwave,draw_xscale,1,0,image_blend,draw_alpha);
		draw_sprite_ext( splayer_jacket_front, 0,x+1*draw_xscale-xx*draw_xscale,yl_-8+y_off+bwave,draw_xscale,1,0,image_blend,draw_alpha);
		
		//head
		bwave = round(wave(bmax,bmin,bdur,.92));
		var xx = var_dir > 0 ? var_dir/10 : var_dir/50;
		var head_x = x-1*draw_xscale-xx*draw_xscale+hh;
		var head_y = yl_-25+y_off+bwave + (crouching ? 1 : 0);
		var hair_x = head_x;
		var hair_y = head_y;
		
		if ( shoot_delay ) {
			draw_sprite_ext( splayer_head,var_dir > -40 ? (var_dir < 25 ? 1 : ( var_dir < 55 ? 2 : 3 )  ) : 0,			round(head_x), round(head_y), draw_xscale, 1, 0, image_blend, draw_alpha );
			var eyes = var_dir > -40 ? (var_dir < 25 ? splayer_eyes_mid : ( var_dir < 55 ? splayer_eyes_mid_up : splayer_eyes_up )  ) : splayer_eyes_down;
			draw_sprite_ext( eyes, blink_state, round(head_x), round(head_y), draw_xscale, 1, 0, image_blend, draw_alpha );

			head_y -= 10;
			head_x -= 7 * draw_xscale + 1; 
			var hair_dir = var_dir > -40 ? (var_dir < 25 ? 1 : ( var_dir < 55 ? 2 : 3 )  ) : 0;
			switch(hair_dir) {
				case 0:
					hair_x = lerp( hair_x, head_x+hsp,   0.6 );
					hair_y = lerp( hair_y, head_y+vsp-2, 0.6 );
				break;
				case 1:
					hair_x = lerp( hair_x, head_x+hsp, 0.6 );
					hair_y = lerp( hair_y, head_y+vsp, 0.6);
				break;
				case 2:
					hair_x = lerp( hair_x, head_x + hsp + 2*draw_xscale, 0.6 );
					hair_y = lerp( hair_y, head_y + vsp + 2,			 0.6 );
				break;
				case 3:
					hair_x = lerp( hair_x, head_x + hsp + 7*draw_xscale, 0.6 );
					hair_y = lerp( hair_y, head_y + vsp + 5,			 0.6 );
				break;
			}
		} else {
			draw_sprite_ext( splayer_head,     1,			round(head_x), round(head_y), draw_xscale, 1, 0, image_blend, draw_alpha );
			draw_sprite_ext( splayer_eyes_mid, blink_state,	round(head_x), round(head_y), draw_xscale, 1, 0, image_blend, draw_alpha );

			head_y -= 10;
			head_x -= 7 * draw_xscale + 1; 
			hair_x = head_x +	hsp * 0.1;
			hair_y = head_y +	vsp * 0.1;
		}
		if ( switching_weapon ) {
			
			//shader_reset();
			//shader_set(shader);
			//shader_set_uniform_f_array(shader_pointer,col_to_array(gun_col,1));
			//switch( switch_timer div 3 ) {
			//	default: break;
			//	case 2:
			//		var wep = WEP_DATA[ current_weapon ];
			//		shader_set(shd_switch_white);
			//		draw_sprite_ext(wep.sprite,  0,x-4*draw_xscale,y-24+y_off, draw_xscale, 1, -45*draw_xscale, image_blend, draw_alpha );
			//		shader_reset();
			//	break;
			//	case 3:
			//		var wep = WEP_DATA[ current_weapon ];
			//		shader_set(shd_switch_white);
			//		draw_sprite_ext(wep.sprite,  0,x-4*draw_xscale,y-24+y_off, draw_xscale, 1, -5*draw_xscale, image_blend, draw_alpha );
			//		shader_reset();
			//	break;
			//}
			//shader_reset();
			//start_palette();
			
			draw_sprite_ext( splayer_hand_switch_wep, switch_timer/3,x-5*draw_xscale, yl_-24+bwave+y_off, draw_xscale, 1, 0, image_blend, draw_alpha );
			
		} else {
			scr_player_draw_guns(var_dir,bdur,bmax,bmin,y_off-body_y);
			
		}
		shader_reset();
		//x += xoff;
		//y += bly_;
		
		if ( current_weapon == e_gun.sniper && gun_charge > 0 && state != e_player.cutscene ) {
			// var sx_ = x+LDX(gun_len,aim_dir);
			// var sy_ = y+LDY(gun_len,aim_dir)-gun_height;
			//var md_ = mask_index;
			var pre_x = x;
			var pre_y = y;
			var drr = point_direction(x,y-gun_height,MX,MY);
			var sx_ = x+			LDX( 42, drr );
			var sy_ = yl_-gun_height+ LDY( 42, drr )+( crouching ? 4 : 0 )-1;
			
			//mask_index = sdot_black;
			//x = sx_;
			//y = sy_;
			//loop
			//blend_add;
			var xx_ = sx_;
			var yy_ = sy_;
			var blend_ = gun_fully_charged;
			var i = 112; while(i-- && !gen_col(x,y)) {
				if( blend_ ){
					DSA( 0.3 );
				} else {
					DSA( 0.2 );
				}
				
				var draw_len_ = 7 + ( gun_charge mod 9 );//irandom_range_fixed( 7, 16 );//// RR( .5, blend_ ? 3.1 : 2.1 )
				draw_line_width_color(xx_,yy_,xx_+LDX(draw_len_,drr),yy_+LDY(draw_len_,drr),2.1, blend_ ? merge_color(c_white,c_aqua,.9) : c_red, blend_ ? c_aqua : c_orange );
				xx_ += LDX( 7, drr );
				yy_ += LDY( 7, drr );
			}
			DSA(1);
			//blend_normal;
			
			//reset
			//mask_index = md_;
			//x = pre_x;
			//y = pre_y;
			
		}
		
		hair_x = lerp( hair_x, head_x, 0.6 );
		hair_y = lerp( hair_y, head_y, 0.6 );
		
	break;
	#endregion
	#region animation
	case e_draw_type.animation:
		switch(sprite_index) {
			default:
				var head_x = x-1*draw_xscale;
				var head_y = y-25;
			break; 
			case splayer_wallhug:
			case splayer_wallhug_still:
				head_x = x-7*draw_xscale-1;
				if ( sprite_index == splayer_wallhug ) {
					switch(floor(image_index)) {
						case 0:  var head_y = y-28; break;
						case 1:  var head_y = y-27; break;
						case 2:  var head_y = y-30; break;
						case 3:  var head_y = y-31; break;
						default: var head_y = y-32; break;
					}
				} else {
					var head_y = y-32;
				}
				
			break;
		}
		
		var hair_x = head_x;//lerp( hair_x, head_x, 0.6 );
		var hair_y = head_y;//lerp( hair_y, head_y, 0.6 );
		//hair_code();
		//image_xscale = draw_xscale;
		//draw_self();
		draw_sprite_ext(
			sprite_index,
			image_index,
			x,
			y,
			draw_xscale,
			image_yscale,
			draw_angle,
			image_blend,
			image_alpha
		);


		
		//shader_reset(); 
		
		//image_xscale = 1;
	break;
	#endregion
	
}
#endregion

