#region going
if (state == 0) {
	if instance_exists(wire) && instance_exists( parent ) && parent.char_index = e_char_index.maya {
		wire.draw_index = 1;
	}
	
	if ( parent != undefined ) {
		wire.parent = parent;
	}
	var cycs = cycles;
	while(cycs--) && ( state == 0 ) {
	
	#region general
	if ( !timer-- ) {
		IDD(wire);
		state = 2;
		exit;
	} 
	update_wire_pos();
	
	//if ( random_fixed(1) > 0.8 ) {
		//var edir = random_fixed(360);create_fx( x + LDX(6,edir), y + LDY(1,edir), sdot_wave, 1.4+random_fixed(2.3), 0, 1 ).image_blend = blend;
	//}
	
	x += LDX(spd,dir);
	y += LDY(spd,dir);
	image_angle = dir;
	
	//var alt_spin = false;
	#endregion
	
	#region collision tiles
	var tl = tile_sort_genre( gen_col_index( x, y, layer_type ) );
	if ( tl == 1 && gen_col( x, y ) ) {
		general_wall_col();
	} else if ( gen_col( x, y ) ) {
		
		var dl = true;
		while( gen_col( x, y ) ) {
			x -= LDX(1,dir);
			y -= LDY(1,dir);
			var tl = tile_sort_genre(gen_col_index(x,y,layer_type));
			if tl == 1 dl = false;
		}
		if ( dl ) {
			state = 2;
			IDD( wire );
			spd = -spd;
			dir = 0;//random_range_fixed( -45, 45 );
			//repeat(5) {
			//	ICD(xprevious,yprevious,0,ospark_alt).col = c_orange;
			//}
			audio_play_sound_pitch_falloff(snd_blob_hit_wall, .6, .1+random_fixed(.05), 0 );
		} else {
			general_wall_col();
		}
		
	}
	
	#endregion
	
	#region enemy collision
	
	image_xscale = 4.5;
	image_yscale = 4.5;
	
	if ( place_meeting(x,y,oplayer) ) {
		
		var t = instance_place(x,y,oplayer);
		if ( !t.INVIS && t != parent ) {
			audio_play_sound_pitch_falloff(snd_blob_hit_wall, .6, .2+random_fixed(.05), 0 );
			update_wire_pos();
			state = 1;
			hooking_type = 1;
			hook_object = t;
			var vl = wire.vertex;
			var n = wire.number-1;
			//var v1 = vl[0];
			var v2 = vl[n];
			wire.line_len = ( point_distance(x,y,parent.x,parent.y-24) / (1+n) )*0.9;//8
			hooking_enemy = true;
			x = lerp( hook_object.bbox_left,   hook_object.bbox_right, 0.5 );
			y = lerp( hook_object.bbox_bottom, hook_object.bbox_top,   0.5 );
			hook_mult = 1;
			v2.oldx -= parent.hsp;
			v2.oldy -= parent.vsp;
			if ( t.state == e_player.hit ) {
				t.hit_timer += 18;
				t.air_combo = true;
			} else if ( t.state == e_player.ledge ) {
				t.state = e_player.normal;
			}
		}
	} else if place_meeting(x,y,ohitbox_saw) {
		var t = instance_place(x,y,ohitbox_saw);
		update_wire_pos();
		state = 1;
		hooking_type = 1;
		hook_object = t;
		var vl = wire.vertex;
		var n = wire.number-1;
		//var v1 = vl[0];
		var v2 = vl[n];
		wire.line_len = ( point_distance(x,y,parent.x,parent.y-24) / (1+n) )*.75;//8
		hooking_enemy = true;
		x = lerp(hook_object.bbox_left,hook_object.bbox_right,0.5);
		y = lerp(hook_object.bbox_bottom,hook_object.bbox_top,0.5);
		hook_mult = 0;
		v2.oldx -= parent.hsp;
		v2.oldy -= parent.vsp;
		
	}
		//	
		//	with oplayer {
		//		if hook_sound != -1 {
		//			audio_stop_sound(hook_sound);
		//			hook_sound = -1;
		//		}
		//	}
		//}
	//}
	
	image_xscale = 1;
	image_yscale = 1;
	
	#endregion
	
	
	#region hook dragger
	if ( state == 0 && place_meeting(x,y,ohook_dragger_still) ) {
		var t = instance_nearest(x,y,ohook_dragger_still);
		update_wire_pos();
		state = 1;
		hooking_type = 3;
		hook_object = t;
		t.state = 1;
		var vl = wire.vertex;
		var n = wire.number-1;
		var v1 = vl[0];
		var v2 = vl[n];
		wire.line_len = ( point_distance(x,y,parent.x,parent.y-24) / (1+n) )*.75;//.8
		
		v2.oldx -= parent.hsp;
		v2.oldy -= parent.vsp;
		audio_play_sound_pitch_falloff(snd_blob_hit_wall, .6, .2+random_fixed(.05), 0 );
		with ( parent ) {
			if hook_sound != -1 {
				audio_stop_sound(hook_sound);
				hook_sound = -1;
			}
		}
		
	}
	#endregion
		
	}
	
#endregion
#region stuck	
} else if( state == 1 ) {
	if ( parent != undefined ) {
		pull_input = parent.KDOWN;		//( ( KDOWN && !DOWN_PULL_OFF ) || input_check( "pull" ) );
		hold_input = !parent.K2P;
	} else {
		pull_input = false;
		hold_input = false;
		
	}
	//pull_input = true;
	
	#region hook object
	if ( hooking_type == 1 ) {
		if( !instance_exists( hook_object ) ) {
			detach_sound();
			if ( instance_exists( wire ) ) {
				IDD(wire);
			}
			IDD();
			

			state = 2;
			spd = 0;
			
			exit;
		} else {
			x = lerp(hook_object.bbox_left,hook_object.bbox_right,0.5);//hook_object.x;
			y = lerp(hook_object.bbox_bottom,hook_object.bbox_top,0.5);//hook_object.y;
			//if ( hooking_enemy ) {
			//	hook_object.bounce_cooldown = 30;
			//}
			
			switch(parent.char_index) {
				case e_char_index.maya:
					if ( pull_input ) {
						var _dr = point_direction( parent.x, parent.y-22, x, y );
						parent.hsp = lerp( parent.hsp, LDX( 8, _dr ), 0.3 );
						parent.vsp = lerp( parent.vsp, LDY( 8, _dr ), 0.3 );
						if (!trail_cooldown--) {
							//with ( oplayer ) {
							//	scr_player_maya_trail();
							//}
							trail_cooldown = 1;
						}
						if ( point_distance( parent.x, parent.y-22, x, y ) <= 22 ) {
							audio_play_sound_pitch( snd_shoot_1,		0.35, 0.95 + random( 0.1 ), 1 );
							audio_play_sound_pitch(snd_railgun_shooting, 0.7, 1.05 + random( 0.1 ), 1 );
							audio_play_sound_pitch( snd_maya_swing_2,	0.40, 1.05 + random( 0.1 ), 1 );
							with ( parent ) {
								repeat(2) {
									var b = bullet_general(  6, 0.1, splayer_maya_slash, 0, , 0.5 );
									// b.y;
									//b.knockback *=  2;
									b.duration  = 10;
									b.piercing  = true;
									b.image_xscale *= 1.45;
									b.image_yscale *= 1.1;
									b.image_speed = 3.4;
									b.depth = depth-1;
									b.ghost = true;
									b.alt_knockback = true;
									b.dir = _dr;
								}
								INVIS = max(INVIS,3);
								hsp *= 0.75;
								vsp = min( -5.5, vsp-1 );
							}
						
						
							detach_sound();
							
							state = 2;
							spd = 0;
							exit;
						}
					}
					
					var vl = wire.vertex;
					var vert = vl[0];
			
					var dx = vert.xx- lerp(hook_object.bbox_left,hook_object.bbox_right,0.5);
					var dy = vert.yy- lerp(hook_object.bbox_bottom,hook_object.bbox_top,0.5);
					var len = wire.line_len;
					var len_2 = sqrt((dx*dx)+(dy*dy));
					var diff = len_2 - len;
					
					percent = (diff / len_2) / wire.stretch;
					var offx = dx * percent;
					var offy = dy * percent;
					vert.xx -= offx;
					vert.yy -= offy;
					var dr_ = point_direction(parent.x,parent.y,hook_object.x, hook_object.y );
					var ds_ = ( max(0,point_distance( parent.x,parent.y,hook_object.x, hook_object.y )-10) / (pulled ? 50 : 90) ) / 16;
					hook_object.hsp -= LDX(ds_,dr_);
					hook_object.vsp -= LDY(ds_,dr_);
					hook_object.bounce_cooldown = 30;
					
				break;
				default:
					var vl = wire.vertex;
					var vert = vl[0];
			
					var dx = vert.xx- lerp(hook_object.bbox_left,hook_object.bbox_right,0.5);
					var dy = vert.yy- lerp(hook_object.bbox_bottom,hook_object.bbox_top,0.5);
					var len = wire.line_len;
					var len_2 = sqrt((dx*dx)+(dy*dy));
					var diff = len_2 - len;
					//if ( hook_mult > 0.1 ) {
					//if ( diff > 0 ) {
					percent = (diff / len_2) / wire.stretch;
					var offx = dx * percent;
					var offy = dy * percent;
					vert.xx -= offx;
					vert.yy -= offy;
					var dr_ = point_direction(parent.x,parent.y,hook_object.x, hook_object.y );
					var ds_ = ( max(0,point_distance( parent.x,parent.y,hook_object.x, hook_object.y )-10) / (pulled ? 50 : 90) ) / 1.3;
					hook_object.hsp -= LDX(ds_,dr_);
					hook_object.vsp -= LDY(ds_,dr_);
					hook_object.bounce_cooldown = 30;
					//}
				break;
			}
			
				
			
				//parent.hsp += LDX(ds_,dr_);
				//parent.vsp += LDY(ds_,dr_);
				
				//if ( ds_ < 0.7 ) {
				//	state = 2;
				//}
				//hook_object.vsp = -60;
				
				//hook_object.base_walk_spd = 0.01;
			//}
			
			
			
		}
	}
	#endregion
	
	#region upward
	//if ( hooking_type == 2 ) {
	//	if( gen_col( x, y ) ){
	//		//IDD();
	//		//state = 2;
	//		//spd = 0;
	//		//exit;//
	//	} else {
	//		x -= LDX( 0.9, rail_dir );
	//		y -= LDY( 0.9, rail_dir );

	//		var vl = wire.vertex;
	//		var vert = vl[0];
			
	//	}
	//}
	#endregion
	
	#region hook object static
	if ( hooking_type == 3 ) {
		if( instance_exists( hook_object ) && !gen_col( x, y ) ) {
			x = hook_object.x;
			y = hook_object.y;
			
			var vl = wire.vertex;
			var vert = vl[0];
			
			vert.xx = hook_object.x;
			vert.yy = hook_object.y;
		} else {
			detach_sound();
			if ( instance_exists( wire ) ) {
				IDD(wire);
			}

			IDD();
			
			state = 2;
			spd = 0;
			exit;
		}
	}
	#endregion
	
	#region general alt
	spd = 0;
	//if( .05 > random_fixed(1) ){
	//	var edir = random_fixed(360);
	//	ICD( x + LDX(5,edir), y + LDY(5,edir), 1, odrop );
	//}
	
	//if( g.hook_type__ < 2 ) {
	//	if ( K2P ) {
	//		detach_sound();
	//		IDD();
	//		state = 2;
	//		spd = 0;
	//		exit;
	//	}
	//} else {
	
	//if ( parent != undefined ) {
	//	pull_inputed = true;//sssparent.K2;//( ( KDOWN && !DOWN_PULL_OFF ) || input_check( "pull" ) );
	//} else {
	//	pull_inputed = false;
	//}
	
	if ( !hold_input ) {
		//detach_sound();
		
		if ( instance_exists( wire ) ) {
			IDD(wire);
		}
		IDD();
		state = 2;
		spd = 0;
		exit;
	}
	//}
	if ( instance_exists( parent ) ) {
		parent.y -= 24;
	}
	var vl = wire.vertex;
	var vert = vl[0];
	vert.xx = x;
	vert.yy = y;

	var n = wire.number-1;
	var vert = vl[n];
	if ( instance_exists( parent ) ) {
		var dx = vert.xx-parent.x;
		var dy = vert.yy-parent.y;
	}
	
	var len = wire.line_len;
	var len_2 = sqrt((dx*dx)+(dy*dy));
	var diff = len_2 - len;
	if ( diff > 0 ) {
		percent = (diff / len_2) / wire.stretch;
		var offx = dx * percent;
		var offy = dy * percent;
		vert.xx -= offx;
		vert.yy -= offy;
		if ( instance_exists(parent) ) {
			parent.hsp += offx*0.02;
			var eff = offy*0.04;
			with ( parent ) {
				if ( !gen_col( x, y + 24.7 + vsp + eff ) ) {//+ 25.3
					vsp += eff;
				}
			}
		}
	}
	
	if ( instance_exists( parent ) ) {
		parent.hsp *= 0.995;
		parent.y   += 24;
	}
	
	if ( pull_input ) {
		var pw_  = 0.45;
		//var mcol = merge_color( c_aqua, c_dkgray, 0.1 );
		if ( instance_exists(parent) ) {
			var dr   = point_direction( x, y, parent.x, parent.y );
		}
		if ( !pulled && pull_input ) {
			pulled = true;
			audio_play_sound_pitch( snd_hook_upgrade_activate, RR(.9,1.05)*0.2, RR(0.94,1.12), 0 );
			//repeat(8) {
			//	var fx = create_fx( oplayer.x, player_mid_y, sdot_wave, .5+random_fixed(.4), 0, 10 );
			//	fx.image_blend = choose_fixed(c_dkgray, mcol, mcol, );
			//	fx.hsp = LDX(RR(1,9),dr+RR(-50,50));
			//	fx.vsp = LDY(RR(1,9),dr+RR(-50,50));
			//	fx.frc = .8;
			//}
			if ( instance_exists( parent ) ) {
				var dr = point_direction(x,y,parent.x,parent.y);
				parent.hsp -= LDX(1.2*pw_,dr);
				parent.vsp -= LDY(2.5*pw_,dr);
			}
			wire.line_len -= (pull_input)*(45.5/n)*pw_;
			wire.start_col = merge_color(c_orange,merge_color( c_white, c_aqua, 0.7 ),0.6);
		}
	}
	
	
	#endregion
	
#endregion
} else {
	if ( instance_exists( wire ) ) {
		IDD(wire);
	}
	IDD();
	
}



