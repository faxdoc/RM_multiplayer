if ( live_call() ) return live_result;

if ( instance_number( oplayer_maya_star ) > 1 ) {
	x -= 999;
	var tl_ = instance_nearest( x + 999, y, oplayer_maya_star );
	x += 999;
	var ds_ = point_distance( x, y, tl_.x, tl_.y );
	if ( ds_ < 32 ) {
		var dr_ = point_direction( x, y, tl_.x, tl_.y );
		hsp -= LDX(  1, dr_ );
		vsp -= LDY(  1, dr_ );
	}
}
x += hsp;
y += vsp;
hsp *= frc;
vsp *= frc;

var ex_dmg = 1;
var do_col = false;

// if( PLC(x,y,par_enemy) ){
// 	do_col = true;

image_xscale = 7;
image_yscale = 7;
if ( PLC( x, y, oplayer ) ) {
	var tll_ = instance_place(x,y,oplayer);
	if ( parent == tll_ ) {
		do_col = true;
	}
}
image_xscale = 2;
image_yscale = 2;
if( PLC(x,y,par_hitbox) ){
	do_col = true;
	ex_dmg *= 1.2;
}
image_xscale = 7;
image_yscale = 7;


if ( do_col ) {
	var dmg_mult = 1;
	dmg_mult *= ex_dmg;
	shoot_press_buffer = 0;
	gun_charge = 30;

	var t = ICD( x, y, -1, ogrenade );
	t.bounce = 0;
	t.hsp  = 0;
	t.vsp  = 0;
	t.grav = 0;
	t.explode_on_ground = true;
	t.explotion_size	= 3*ex_dmg;
	t.explode_on_contact = true;
	t.push_player		 = true;
	t.duration			 = 12*ex_dmg;
	t.do_explotion_sound = false;
	
	t.explode_damage = 34*dmg_mult*lerp( 0.8, 1.3, charge_level )*dmg;
	t.sprite_index	 = srocket_alt;
	t.spin			 = 0;
	t.draw_angle	 = image_angle;
	t.duration		 = 3;
	t.parent = parent;
	
	with ( create_fx(t.x,t.y,splayer_maya_cut_cross, 1/ex_dmg, 0, -5 ) ) {
		blendtype = e_blendtype.add;
		image_xscale = 1.25*ex_dmg;
		image_yscale = 1.25*ex_dmg;
	}
	//audio_play_sound_pitch( snd_railgun_shooting, 0.15, (0.85 + random( 0.1 ))*ex_dmg, 1 );
	//audio_play_sound_pitch( snd_maya_explode_star, 0.9, (0.96 + random( 0.1 )), 1 );
	//audio_play_sound_pitch( snd_shoot_1,		  0.15, (0.75 + random( 0.1 ))*ex_dmg, 1 );
	
	//effect_general( 3, 12, 6 );
	duration = 0;
}

image_angle += angle_spin;

if ( !duration-- || instance_number( oplayer_maya_star ) > 3 ) {
	ex_dmg *= 0.7;
	var dmg_mult = 1;
	dmg_mult *= ex_dmg;
	shoot_press_buffer = 0;
	gun_charge = 30;

	var t = ICD( x, y, -1, ogrenade );
	t.bounce = 0;
	t.hsp  = 0;
	t.vsp  = 0;
	t.grav = 0;
	t.explode_on_ground  = true;
	t.explotion_size	 = 3*ex_dmg;
	t.explode_on_contact = true;
	t.push_player		 = true;
	t.duration			 = 12*ex_dmg;
	t.do_explotion_sound = false;
	t.explode_damage	 = 34*dmg_mult*lerp( 0.8, 1.3, charge_level )*dmg;
	t.sprite_index		 = srocket_alt;
	t.spin				 = 0;
	t.draw_angle		 = image_angle;
	t.duration			 = 3;
	t.parent = parent;
	
	with ( create_fx( t.x, t.y, splayer_maya_cut_cross, 1/ex_dmg, 0, -5 ) ) {
		blendtype = e_blendtype.add;
		image_xscale = 1.25*ex_dmg;
		image_yscale = 1.25*ex_dmg;
	}
	
	//audio_play_sound_pitch_falloff( snd_railgun_shooting, 0.2, (0.85 + random( 0.1 ))*ex_dmg, 1 );
	//audio_play_sound_pitch_falloff( snd_maya_explode_star, 0.8, (0.96 + random( 0.1 )), 1 );
	//audio_play_sound_pitch_falloff( snd_shoot_1,		 0.15, (0.75 + random( 0.1 ))*ex_dmg, 1 );
	with ( oplayer ) {
		SHAKE++;
	}
	
	IDD();
}
