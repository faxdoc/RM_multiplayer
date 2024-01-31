event_inherited();
enemy_bullet		= false;
duration			= 90;
bounce				= .8;
do_smoke			= true;
explode_on_contact	= false;
explotion_size		= 2;
spin				= random_range_fixed(-6,6);
explode_on_ground	= false;
push_player			= false;
explode_damage		= 2;
do_explotion_sound = true;

piercing	= false;
dir 		= 0;
dmg 		= 2;
mp_mult 	= 1;
spd 		= 0;
SHAKE = 0;
parent = -1;

layer_col = layer_get_id("Tiles_1");
gen_col = tplace_meeting_walls_general;


destroy_function = function() {
	SHAKE += 3;
	var n = 3+irandom_fixed(2);
	var r = 20;
	repeat(n) {
		var xx = x+random_range_fixed( -r, r );
		var yy = y+random_range_fixed( -r, r );
		var f = create_fx(xx,yy,sexplotion,(.9+random_fixed(1.7))*.7,0,-10);
		f.image_alpha = .5+random_fixed(1);
	}

	var n = 8+irandom_fixed(5);
	repeat(n) {
		var xx = x+random_range_fixed( -r, r );
		var yy = y+random_range_fixed( -r, r );
		ICD(xx,yy,0,osmoke_fx);
	}

	var n = 8+irandom_fixed(5);
	repeat(n) {
		var xx = x+random_range_fixed( -r, r );
		var yy = y+random_range_fixed( -r, r );
		ICD(xx,yy,0,osmoke);
	}
	repeat(5) ICD(x,y,0,ospark_alt);

	
	var t = ICD( x, y+6, 0, par_hitbox );
	scr_set_size( t, explotion_size*3 );
	t.ghost = true;
	t.duration = 4;
	t.knockback *= 3;
	t.dmg = explode_damage;
	t.dir = 90;
	t.do_init_check = false;
	t.mp_mult *= mp_mult;
	t.visible = false;
	t.do_draw = false;
	t.parent = parent;
	t.stun_mult = 0.4;
	t.damage_mult = 0.85;

	if ( parent && instance_exists(parent) ) {
		if ( instance_exists(parent) && push_player && point_distance( x, y, parent.x , parent.y-22 ) < 82 ) {
			var dr = point_direction( x, y, parent.x , parent.y-22 );
			//var pwr_ = 2.75;
			//if ( TRINK[e_trinket.heavy_ammo] ) {
			var pwr_ = 3.1;	
			//} else {
				//pwr_ = 2.75;
			//}
	
			parent.hsp += LDX( pwr_, dr );//3.1 | 2.95
			var upval	= LDY( pwr_, dr );//3.1 | 2.95
			if ( upval > 0 ) {
				parent.vsp += upval;
			} else {
				parent.space_buffer = true;
				parent.vsp = min( upval, parent.vsp + upval );
			}
		}
	}
	//if ( do_explotion_sound ) {
		audio_play_sound_pitch_falloff( snd_explotion_1, 0.6, RR( 1.7, 2 ), 0 );
	//}
}

