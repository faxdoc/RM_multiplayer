if ( alt_init ) {
	spd *= 0.8;
	duration *= 1.25;
	alt_init = false;
}
#region hitfreeze
if ( do_hitfreeze ) {
	if ( hitfreeze > 0 ) {
		hitfreeze -= 1;
		var htfr_ = max( 0, hitfreeze * 0.5 );
		draw_x_offset = RR( -htfr_, htfr_ );
		draw_y_offset = RR( -htfr_, htfr_ );
		exit;
	}
}

#endregion

repeat(step_number) {
	//universal
	if ( !duration-- ) {
		destroy_function();
		IDD();
		step_number = 0;
	}
	
	if ( trail_fx != -1 ) {
		if ( trail_timer++ >= trail_interval ) {
			trail_timer = 0;
			//create_fx(x,y,trail_fx,1,dir,1);
		}
	}
	
	if ( custom_user != -1 ) event_perform( ev_other, ev_user0 );
	
	
	//movement
	if ( do_movement_general ) {
		
		switch( move_type ) {
			case e_movetype.hvsp:
				x += hsp;
				y += vsp;
				vsp += grav;
				draw_angle += angle_spin;
				event_perform( ev_other, ev_user1 );
			break;
			case e_movetype.vector:
				spd *= frc;
				x += LDX(spd,dir);
				y += LDY(spd,dir);
				angle_spin += dir_angle_spin;
				draw_angle = dir + angle_spin;
				event_perform( ev_other, ev_user1 );
			break;
			case e_movetype.melee:
				if ( invis_set ) {
					//hit_fx = -1;
					trail_fx = -1;
					self_push = true;
					piercing = true;
					destroy_index = -1;
				}
				if ( instance_exists( parent ) ) {
					x = parent.x+ xdis*parent.draw_xscale;
					y = parent.y+ ydis;
					knockback_dir = parent.draw_xscale == 1 ? 180 : 0;
				} else {
					destroy_function();
					IDD();
					step_number = 0;
					exit;
				}
			break;
		}
	}
	
	//hit
	if ( size_mult != 1 ) {
		var sx = image_xscale;
		var sy = image_yscale;
		image_xscale = sx*size_mult;
		image_yscale = sy*size_mult;
		//var t = instance_place(x,y,par_enemy);
		image_xscale = sx;
		image_yscale = sy;
	} else {
		//var t = instance_place(x,y,par_enemy);
	}
	
	if ( multihit && multihit_cooldown ) multihit_cooldown--;
	
	
	var t = undefined;
	var t_ = id;
	with ( oplayer ) {
		if ( PLC(x,y,t_) && id != t_.parent && !INVIS ) {
			t = id;
		}
	}
	//var t = instance_place( x, y, oplayer );
	#region Hit enemy
	if ( t && parent != undefined && t != parent && !t.INVIS ) {
		
		if ( t.state != e_player.hit ) {
			effect_create_depth(  -40, ef_ring, t.x, t.y-22, 0, merge_colour(c_red,c_ltgray,0.6) );
			t.hit_freeze = floor(max(8,dmg/5 ) );
			
			t.screen_flash_col	= c_gray;
			t.flash_alpha		= 0.07;
			
			parent.screen_flash_col	= c_gray;
			parent.flash_alpha		= 0.07;
		
		} else {
			t.hit_freeze = floor( max(4,dmg/6) );
		}
		
		t.state = e_player.hit;
		t.hp -= dmg;
		t.hit_timer = floor(dmg*8*stun_mult);
		t.hit_freeze = max(4,dmg/3);
		t.bounce_cooldown = 30;
		
		t.can_hook_delay = false;
		t.hook_air_cancel = false;
		
		
		
		parent.can_hook_delay = false;
		parent.hook_air_cancel = false;
		
		
		with ( ohook ) {
			if ( parent == t || hook_object == t ) {
				state = 2;
				if (instance_exists(wire) ) {
					IDD(wire);
				}
			}
		}
		knockback *= 1.1;
		t.hsp *= 0.05;
		t.vsp *= 0.05;
		
		if ( abs(LDX(1,dir) ) < 0.5 ) {
			t.hsp += LDX( knockback*0.6, point_direction( 0, 0, -sign( parent.x - x )*10, 0 ) );
		} else {
			t.hsp += LDX( knockback*1.4, dir );
		}
		
		t.vsp += LDY( knockback*1.6, dir );
		
		t.vsp = lerp( t.vsp, min(-knockback*1.4,t.vsp), 0.5-LDY(0.5,dir) );
		
		with ( t ) {
			while gen_col(x,y+vsp+1) && !gen_col(x,y-1) {
				y--;
			}
		}
		
		//t.vsp -= 2;
		t.SHAKE += shake_add * 0.5;
		parent.SHAKE += shake_add;
		destroy_function();
		IDD();
	}
	
	
	
	
	//if t && ( ( !PLC(x,y,par_bulletshield ) || instance_place(x,y,par_bulletshield).active = false  )  || ghost ) && (!do_hitscan_check || scr_check_hitscan_collision( oplayer.x, player_mid_y, t ) ) {
	//	//check
	//	if ( !multihit ) {
	//		if ds_map_exists(hit_list,t) exit;
	//		hit_list[? t] = 1;
	//		if t.invis exit;
	//	} else {
	//		if t.invis exit;
	//		if multihit_cooldown exit;
	//		multihit_cooldown = multihit_cooldown_amount;
	//		multihits_left--;
	//		if ( multihits_left <= 0 ) {
	//			IDD();
	//			step_number = 0;
	//		}
	//	}
	//	//affect
	//	t.hp -= dmg;
	//	t.stun += stun;
	//	if poison_add > 0 t.poison_timer = poison_add;
	//	MP += dmg*mp_mult*t.give_mp_mult;
		
	//	//knockback
	//	if ( t.knockable ) {
	//		var knock_dir = move_type == e_movetype.melee ? knockback_dir : dir;
	//		if ( !alt_knockback ) {
	//			t.hsp += LDX( knockback*t.knockback_mult, knock_dir );
	//		} else {
	//			t.hsp += sign( LDX( knockback*t.knockback_mult, knock_dir ) )*max( ( knockback*t.knockback_mult*0.35 ), LDX( knockback*t.knockback_mult, knock_dir ) );
	//		}
	//		t.vsp += LDY(knockback*t.knockback_mult,knock_dir);
	//	}
		
	//	if ( self_push ) {
	//		var flr = false;
	//		with ( parent ) {
	//			if tplace_meeting_walls_general(x,y+1) flr = true;
	//		}
	//		var knock_dir = move_type == e_movetype.melee ? knockback_dir : dir;
	//		if( !flr ){
	//			parent.hsp -= LDX(-knockback/2.5,knock_dir);
	//			parent.vsp -= LDY(-knockback/2.5,knock_dir);
	//		} else {
	//			parent.hsp -= LDX(-knockback*1.5,knock_dir);
	//			parent.vsp -= LDY(-knockback*1.5,knock_dir);
	//		}
	//	}
	//	with t event_perform( ev_other, ev_user0 );
		
	//	//juice
	//	SHAKE += shake_add;
	//	alarm[1] = 2;
		
	//	//bullet
	//	if ( !piercing && !multihit ) {
	//		hit_wall = true;
	//		IDD();
	//		step_number = 0;
	//	}
	//}
	#endregion
	
	
}

if ( local_sound != undefined ) {
	location_sound_step( local_sound,  local_sound_volume, x, y,  local_sound_start_falloff, local_sound_end_falloff, local_sound_falloff_rate  );
}
image_angle = draw_angle;

