function scr_player_draw_ameli(){
var bwave, bmax =-1, bmin = 0, bdur = 4;
var hh =  KRIGHT-KLEFT;
var vv =  KDOWN-KUP;

#region Fern Mode
switch( draw_type ) {
	#region hook visual
	case e_draw_type.starting_hook:
	#endregion
	
	#region main
	case e_draw_type.hook:
	case e_draw_type.aiming:
		
		
		var bly_ = floor(body_y-land_y);
		var yl_ = y-bly_+1;
		bwave = round(wave(bmax,bmin,bdur,.89));
		var y_off = var_dir > 0 ? var_dir / 37 : var_dir / 137;
		var xoff = draw_xscale*-2;
		var recoil_x = LDX( recoil, var_dir ) * draw_xscale * 0.6;
		var recoil_y = LDY( recoil, var_dir ) * 0.6;
		var xx = var_dir > 0 ? var_dir/40 : var_dir/80;
		
		switch(ameli_arm_inner_state) {
			case e_ameli_arm_inner_state.idle:
				draw_sprite_ext( sameli_arm_inner, knife_timer < 21 ? min(11,knife_timer/1):12,x-0*draw_xscale-recoil_x-(xx*draw_xscale*2),yl_-24+bwave+y_off-recoil_y+1-5, -draw_xscale, 1, 0, image_blend, draw_alpha );
			break;
			case e_ameli_arm_inner_state.casting:
				draw_sprite_ext( sameli_arm_inner_cast, (ameli_arm_inner_timer/10)*2.7,x-0*draw_xscale-recoil_x-(xx*draw_xscale*2),yl_-24+bwave+y_off-recoil_y+1-5, -draw_xscale, 1, 0, image_blend, draw_alpha );
			break;
			case e_ameli_arm_inner_state.snap:
				draw_sprite_ext( sameli_arm_inner_explotion, (ameli_arm_inner_timer/10)*3.7,x-0*draw_xscale-recoil_x-(xx*draw_xscale*2),yl_-24+bwave+y_off-recoil_y+1-5, -draw_xscale, 1, 0, image_blend, draw_alpha );
			break;
		}
		
		//legs
		if ( on_ground ) {
			if ( round(hsp) == 0 ) {
				draw_sprite_ext( sameli_legs_idle,  legs_index,			x, yl_+bly_, -draw_xscale,1,0,image_blend,draw_alpha);
			} else {
				draw_sprite_ext( sameli_legs_run,  legs_running_index, x, yl_+bly_, -draw_xscale,1,0,image_blend,draw_alpha);
			}
		} else {
			draw_sprite_ext( sameli_legs_jump,		legs_index,			x, yl_+bly_, -draw_xscale,1,0,image_blend,draw_alpha);
		}
		
		
		yl_ -= 3;
		//head
		bwave = round( wave( bmax, bmin, bdur, 0.92 ) );
		var xx = var_dir > 0 ? var_dir/10 : var_dir/50;
		var head_x = x-2*draw_xscale-(xx*draw_xscale*0.33)+hh;
		var head_y = yl_-25+y_off+bwave + (crouching ? 1 : 0);
		var hair_x = head_x;
		var hair_y = head_y;
		
		if ( shoot_delay ) {
			draw_sprite_ext( sameli_head, var_dir > -40 ? (var_dir < 25 ? 1 : ( var_dir < 55 ? 2 : 3 )  ) : 0,	round(head_x), round(head_y)-4, -draw_xscale, 1, 0, image_blend, draw_alpha );
		} else {
			draw_sprite_ext( sameli_head,     1,			round(head_x), round(head_y)-4, -draw_xscale, 1, 0, image_blend, draw_alpha );
		}
		
		var xx = var_dir > 0 ? var_dir/40 : var_dir/80;
		var ind = var_dir >= 0 ? var_dir/90 * 4.9 : 0;
		var ex = (var_dir < -30) ? -var_dir/80 * draw_xscale : 0;
		
		
		
		draw_sprite_ext( sameli_body, ind,x+ex,yl_-10+y_off*0.5+bwave-22,-draw_xscale,1,0,image_blend,draw_alpha);
		
		
		//draw_sprite_ext( sameli_body, 0,x + 0*draw_xscale-xx*draw_xscale,		yl_-8+y_off+bwave		-22,-draw_xscale,1,0,image_blend,draw_alpha);
		
		draw_sprite_ext( sameli_hoodie,   0,    x -1*draw_xscale-xx*1.5*draw_xscale,  yl_-8+y_off*1.4+bwave-19,-draw_xscale,1,0,image_blend,draw_alpha);
		
		//draw_sprite_ext( splayer_hoodie,0,x-8*draw_xscale-xx*1.5*draw_xscale,yl_-22+y_off*1.4+bwave,draw_xscale,1,0,image_blend,draw_alpha);
		//draw_sprite_ext( splayer_jacket_front, 0,x+1*draw_xscale-xx*draw_xscale,yl_-8+y_off+bwave,draw_xscale,1,0,image_blend,draw_alpha);
		
		switch(ameli_arm_outer_state) {
			case e_ameli_arm_outer_state.idle: 
				draw_sprite_ext( sameli_arm_outer, 0, x-1*draw_xscale-(xx*draw_xscale*2), yl_-26+bwave+y_off*0.9, -draw_xscale, 1, 0, image_blend, draw_alpha );
				draw_sprite_ext( sameli_arm_outer, 1, x-1*draw_xscale-(xx*draw_xscale*2), yl_-26+bwave+y_off*0.9, -draw_xscale, 1, 0, image_blend, draw_alpha );
				draw_sprite_ext( sameli_arm_outer, 2, x-1*draw_xscale-(xx*draw_xscale*2), yl_-26+bwave+y_off*0.9, -draw_xscale, 1, 0, image_blend, draw_alpha );
			break;
			case e_ameli_arm_outer_state.holding_up: 
				draw_sprite_ext( sameli_arm_outer_throw, ( ameli_arm_outer_timer/ 10 )*3.7, x-1*draw_xscale-(xx*draw_xscale*2), yl_-26+bwave+y_off*0.9, -draw_xscale, 1, 0, image_blend, draw_alpha );
				
			break;
			case e_ameli_arm_outer_state.casting: 
				draw_sprite_ext( sameli_arm_outer_beam, ( ameli_arm_outer_timer/ 10 )*2.7, x-1*draw_xscale-(xx*draw_xscale*2), yl_-26+bwave+y_off*0.9, -draw_xscale, 1, 0, image_blend, draw_alpha );
			break;
			case e_ameli_arm_outer_state.explode: 
				draw_sprite_ext( sameli_arm_outer_ball, ( ameli_arm_outer_timer/ 10 )*2.7, x-1*draw_xscale-(xx*draw_xscale*2), yl_-26+bwave+y_off*0.9, -draw_xscale, 1, 0, image_blend, draw_alpha );
			break;
		}
	
		//if ( switching_weapon ) {
			// draw_sprite_ext( sameli_arm_outer, switch_timer/3,x-0*draw_xscale, yl_-26+bwave+y_off, -draw_xscale, 1, 0, image_blend, draw_alpha );
		//} else {
		
		//}
		
		shader_reset();
		
		// if ( knife_state == 0 && grenade_cooldown <= 0 ) {
		// if ( ameli_ranged_mode ) {
			draw_sprite_ext(sameli_book_range,0,ameli_book_x,ameli_book_y, -draw_xscale, 1, 0, c_white, 1 );
		// } else {
		// 	draw_sprite_ext(sameli_book,0,ameli_book_x,ameli_book_y, -draw_xscale, 1, 0, c_white, 1 );
			
		// }
		// }
		
		//if ( current_weapon == e_gun.sniper && gun_charge > 0 && state != e_player.cutscene ) {
		//	var drr = point_direction(x,y-gun_height,MX,MY);
		//	var sx_ = x+			LDX( 42, drr );
		//	var sy_ = yl_-gun_height+ LDY( 42, drr )+( crouching ? 4 : 0 )-1;
			
		//	var xx_ = sx_;
		//	var yy_ = sy_;
		//	var blend_ = gun_fully_charged;
		//	var i = 112; while(i-- && !gen_col(x,y)) {
		//		if( blend_ ){
		//			DSA( 0.3 );
		//		} else {
		//			DSA( 0.2 );
		//		}
				
		//		var draw_len_ = 7 + ( gun_charge mod 9 );
		//		draw_line_width_color(xx_,yy_,xx_+LDX(draw_len_,drr),yy_+LDY(draw_len_,drr),2.1, blend_ ? merge_color(c_white,c_aqua,.9) : c_red, blend_ ? c_aqua : c_orange );
		//		xx_ += LDX( 7, drr );
		//		yy_ += LDY( 7, drr );
		//	}
		//	DSA(1);
		//}
		
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
		
		var hair_x = head_x;
		var hair_y = head_y;
		shader_set( shd_palette );
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
		shader_reset();
		
	break;
	#endregion
	
}
#endregion

}

