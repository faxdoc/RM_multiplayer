var do_hit = false;
var xl = image_xscale, yl = image_yscale;
image_xscale = 0.5;
image_yscale = 0.5;
if ( !ghost && !bounces && gen_col( x, y ) ) {
	do_hit = true;
}

if (bounces && move_type = e_movetype.hvsp) {
	if ( gen_col(x,y+vsp*1.1) ) {
		vsp = -vsp*.4;
		hsp *= .5;
		y += vsp;
		duration--;
		angle_spin += random_range_fixed(-2,2);
		repeat(3) ICD(x,y,0,ospark_alt);
		if (play_sound_cooldown <= 0) {
			audio_play_sound_pitch_falloff( choose_fixed(snd_grenade_bounce,snd_grenade_bounce_alt), RR( .7, .9 )*.6, RR(.95,1.05), 0 );
			play_sound_cooldown = 15;
		}
		
		if ( bounces_left > 0 ) {
			//if ( sprite_index == sbaseball_test ) {
				audio_play_sound_pitch_falloff( snd_metal_hit_1, 0.3, RR(1.5,1.7)*1.5, -10 );
			//}
			if ( !--bounces_left ) {
				bounces = false;
			}
		}
	}
	if (gen_col(x+hsp*1.1,y)) {
		hsp = -hsp*.5;
		vsp *= .7;
		x += hsp;
		duration -= 1;
		angle_spin += random_range_fixed(-2,2);
		repeat(3) ICD(x,y,0,ospark_alt);
		if (play_sound_cooldown <= 0) {
			audio_play_sound_pitch_falloff( choose_fixed(snd_grenade_bounce,snd_grenade_bounce_alt), RR( .7, .9 )*.6, RR(.95,1.05), 0 );
			play_sound_cooldown = 15;
		}
		if ( bounces_left > 0 ) {
			//if ( sprite_index == sbaseball_test ) {
			//	audio_play_sound_pitch_falloff( snd_metal_hit_1, 0.3, RR(1.5,1.7)*1.5, -10 );
			//}
			if !--bounces_left {
				bounces = false;
			}
		}
	}
	//if (play_sound_cooldown) play_sound_cooldown--;
}

if( bounces && move_type = e_movetype.vector ) {
	if( gen_col( x + LDX( spd, dir ), y ) ) {
		var pre_pos_x = x-xprevious;
		var pre_pos_y = y-yprevious;
		dir = point_direction(0,0,-pre_pos_x,pre_pos_y);
		duration -= 1;
		x = xprevious;
		y = yprevious;
	}
		
	if ( gen_col( x, y + LDY( spd, dir ) ) ) {
		var pre_pos_x = x-xprevious;
		var pre_pos_y = y-yprevious;
		dir = point_direction(0,0,pre_pos_x,-pre_pos_y);
		duration -= 1;
		x = xprevious;
		y = yprevious;
	}
}
	
image_xscale = xl;
image_yscale = yl;
if( do_hit ){
	if ( !delete_on_wall_col ) {
		if ( !hit_wall ) {
			hit_fx = -1;
			duration += 420;
			dmg *= .8;
			shake_add *= .6;
			lag_add *= .6;
			hit_wall = true;
			spd = 0;
			knockback *= .5;
				
			trail_fx = -1;
			var i = 0;
			if ( sprite_index == sbullet_bolt ) {
				image_xscale *= 0.7;
				image_yscale *= 0.7;
			} else {
				image_xscale *= 0.9;
				image_yscale *= 0.9;
			}
			sprite_index = sbullet_bolt_white_wave;
				
			while ( i++ < 32 && gen_col(x,y) ) {
				x -= LDX(1,dir);
				y -= LDY(1,dir);
			}
			//dir += 180;
			dir = lerp(dir,90,0.9);
			move_type = e_movetype.hvsp;
			hsp = 0;
			vsp = 0;
			grav = 0;
			depth = -90;
			image_angle += 180;
				
			image_index = random_fixed(8);
			if ( instance_exists( parent ) ) {
				image_blend = parent.player_colour;
			}
				
			audio_play_sound_pitch_falloff(snd_shoot_bullet_alt,.5+random_fixed(.1),.9+random_fixed(.1),-10);
		}
			
	} else {
		hit_wall = true;
		destroy_function();
		IDD();
		step_number = 0;
		audio_play_sound_pitch_falloff(snd_shoot_bullet_alt,.5+random_fixed(.1),.9+random_fixed(.1),0);
	}
}









