pull_input = false;
layer_col  = layer_get_id("Tiles_1");
layer_type = layer_get_id("Tiles_1");
trail_cooldown = 0;
gen_col = PLA;
gen_col_index = tplace_meeting_index;
dlc_mode = false;
maya_mode = false;
can_del = true;
hold_input = false;
hook_mult = 0;

//live_reload
pulled = false;
wire = instance_create_depth( x, y, 1, overlet_object );
wire.core_parent = id;
parent = undefined;


wire.ynum = 9;
wire.line_len = 900;
wire.universal_frc = 0.97;
wire.stretch = 1.3;
wire.grav = 0.03;
wire.draw_index = 2;
wire.end_col = merge_color( c_dkgray, c_black, 0.4 );
wire.start_col = c_orange;
with( wire ) event_perform( ev_step, 0 );
rep_number = 2;

image_speed = 0;
image_index = 3;
state = 0;
dir   = 0;

cycles =10;
timer = 41;//
spd =  3.5;////
if ( maya_mode ) {
	cycles = 8;
	timer  = 45;
}
image_xscale = .5;
image_yscale = .5;	
blend = merge_color( c_dkgray, c_black, 0.4 );
hooking_type = 0;
hook_object = -1;//
rail_dir = 0;////

function update_wire_pos() {
	
		var vl = wire.vertex;
		var mm = wire.number;
		var m2 = mm+1;
		var i = 0; repeat(mm) {
			var vert = vl[i];
			
			vert.xx =   lerp(x,parent.x,i/m2);
			vert.yy =   lerp(y,parent.y-24,i/m2);
			
			vert.oldx = lerp(x,parent.x,i/m2);
			vert.oldy = lerp(y,parent.y-24,i/m2);
			
			i++;
		}
		var mx = mm-1;
		var vert = vl[mx];
		var dx = vert.xx-parent.x;
		var dy = vert.yy-parent.y-24;
		var len = wire.line_len;//ll.len;
		var len_2 = sqrt((dx*dx)+(dy*dy));
		var diff = len_2 - len;
		if (diff > 0) {
			percent = (diff / len_2) / wire.stretch;
			var offx = dx * percent;
			var offy = dy * percent;
			vert.xx -= offx;
			vert.yy -= offy;
		}
	
}

function general_wall_col() {
	update_wire_pos();
	x += LDX(3,dir);
	y += LDY(3,dir);
	image_xscale = .1;
	image_yscale = .1;	
	var il = 0;
	while (gen_col(x,y) && il++ < 300 ){
		x -= LDX(.1,dir);
		y -= LDY(.1,dir);
	}
	
	state = 1;
	var vl = wire.vertex;
	var n = wire.number-1;
	var v1 = vl[0];
	var v2 = vl[n];
	wire.line_len = ( point_distance(x,y,parent.x,parent.y-24) / (1+n) )*0.77;//.8
		
	v2.oldx -= parent.hsp;
	v2.oldy -= parent.vsp;
	hooking_type = 0;
	//audio_play_sound_pitch_falloff( snd_blob_hit_wall, 0.6, 0.2 + random_fixed( 0.05 ), 0 );
	with (parent) {
		if (hook_sound != -1) {
			audio_stop_sound(hook_sound);
			hook_sound = -1;
		}
	}
	image_xscale = 1;
	image_yscale = 1;
}

core_col = c_orange;
wire.end_col = merge_color( c_dkgray, c_black, 0.4 );
wire.start_col = c_orange;
hooking_enemy = false;

//if( player_exists ) {
//	var do_del = false;
//	var i = 0; repeat(10) {
//		var xx_ = lerp(x,oplayer.x,i/10);
//		var yy_ = lerp(y,player_mid_y,i/10);
//		if ( gen_col( xx_, yy_ ) ) {
//			do_del = tile_sort_genre( gen_col_index(xx_,yy_,layer_type) ) == 1 ? false : true;
//		}
//		i++;
//	}
//	if ( do_del ) {
//		timer = -1;
//		x = oplayer.x;
//		y = player_mid_y;
//		repeat(5) {
//			ICD(x,y,0,ospark_alt).col = c_orange;
//		}
//		audio_play_sound_pitch_falloff(snd_blob_hit_wall, .6, .1+random_fixed(.05), 0 );
//	}	
//}


//function detach_sound() {
	//audio_play_sound_pitch_falloff( snd_detach_hook, .4, RR( .95, 1.05 ), 0 );
//}

