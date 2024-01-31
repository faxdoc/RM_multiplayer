#region general


switch( meta_state ) {
	default:
		if ( first_looser == undefined && lives_left <= 0 ) {
			var ld_ = id;
			with ( oplayer ) {
				first_looser = ld_;
			}
		}
		var st_ = 0;
		with ( oplayer ) {
			if ( lives_left > 0 ) {
				st_++;
			}
		}
		if ( st_ <= 1 ) {// && meta_state < 5 
			meta_state = e_meta_state.round_end;
		}
	break;
	case e_meta_state.level_select:
	case e_meta_state.round_end:
	
	break;
}

#endregion

switch(meta_state) {
	case e_meta_state.level_select:
		if ( !instance_exists(obutton_levels) ) {
			var d_ = 1/10;
			var i = 0;
			ICD( GW*(d_+(d_*i++)),GH*0.55,0,obutton_levels).image_index = 0;
			ICD( GW*(d_+(d_*i++)),GH*0.55,0,obutton_levels).image_index = 1;
			ICD( GW*(d_+(d_*i++)),GH*0.55,0,obutton_levels).image_index = 2;
			ICD( GW*(d_+(d_*i++)),GH*0.55,0,obutton_levels).image_index = 3;
			ICD( GW*(d_+(d_*i++)),GH*0.55,0,obutton_levels).image_index = 4;
			ICD( GW*(d_+(d_*i++)),GH*0.55,0,obutton_levels).image_index = 5;
			ICD( GW*(d_+(d_*i++)),GH*0.55,0,obutton_levels).image_index = 6;
			ICD( GW*(d_+(d_*i++)),GH*0.55,0,obutton_levels).image_index = 7;
			ICD( GW*(d_+(d_*i++)),GH*0.55,0,obutton_levels).image_index = 8;
			
		}
	break;
	case e_meta_state.round_end:
		if ( final_timer++ > 300 ) {
			meta_state = e_meta_state.level_select;
			final_timer = 0;
			global.display_room_name = "";
			//event_perform( ev_create, 0 );
		}
		if instance_exists(overlet_object) {
			IDD(overlet_object);
		}
		if instance_exists(par_hitbox) {
			IDD(par_hitbox);
		}
		if instance_exists(ohook) {
			IDD(ohook);
		}
	break;
	case e_meta_state.round_start:
		hp = hp_max;
		INVIS = 30; 
		intro_timer += 0.75;
		if ( intro_timer > 105 ) {
			intro_timer = 20;
			spawn_timer = 0;
			meta_state = e_meta_state.main;
			state = e_player.normal;
			INVIS = 60;
		}
	break;
	case e_meta_state.respawn:
		hp = hp_max;
		INVIS = 30; 
		if ( spawn_timer++ > 30 ) {
			spawn_timer = 0;
			meta_state = e_meta_state.main;
			state = e_player.normal;
			INVIS = 60;
		}
		damage_taken = 0;
		pre_hp = hp;
		draw_alpha = 1;
	break;
	#region main
	case e_meta_state.main:
		player_main_behaviour();
	break;
	#endregion
	
	#region respawn
	case e_meta_state.dying:
		if ( spawn_timer == 0 ) {
			if ( instance_exists(orespawn_box) ) {
				x = orespawn_box.x;
				y = orespawn_box.y;
			} else {
				x = room_width  / 2;
				y = room_height / 2;
			}
			var i = 0; repeat(weapon_number) {
				if (RELOAD[i] > 0 )RELOAD[i] = 0;
				i++;
			}
			gun_charge = 0;
			gun_charging = false;
			grenade_cooldown = 0;
			aim_dir = 0;
			draw_xscale =1;
			var_dir = 0;
			shoot_delay = =;
			
		}
		INVIS = 60;
		if ( spawn_timer++ > 90 ) {
			hsp = 0;
			vsp = 0;
			spawn_timer = 0;
			meta_state = e_meta_state.respawn;
			
			INVIS = 60; 
			self_draw = true;
		}
		
	break;
	#endregion
	
}


if ( meta_state != e_meta_state.main ) {
	var lddd_ = id;
	if ( instance_exists( ohook ) ) {
		with ( ohook ) {
			if ( parent == lddd_ ) {
				state = 2;
			}	
		}
	}
}

if ( SHAKE > 0.05 ) {
	SHAKE *= 0.85;
	screen_shake_x = random_range_fixed(-SHAKE,SHAKE)*2.0;
	screen_shake_y = random_range_fixed(-SHAKE,SHAKE)*2.0;
} else {
	screen_shake_x = 0;
	screen_shake_y = 0;
	SHAKE = 0;
}
if ( show_hp_timer > 0 ) {
	show_hp_timer += 1.2;
	if ( show_hp_timer >= 100 ) {
		show_hp_timer = 0;
	}
}

	