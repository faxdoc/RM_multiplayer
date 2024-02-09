collision_init();
gen_col = PLA;
alt_knockback = false;
can_be_knocked = false;
can_bounce_player = false;
can_bounce_delay = 0;
pre_bounce_blend = undefined;
base_xscale = 1;
base_yscale = 1;
do_hitscan_check = false;
has_been_knocked = false;
draw_x_offset = 0;
draw_y_offset = 0;
damage_mult = 1;
bonus_vsp = 0;
deal_damage = true;
anti_knockable = true;
delete_other_bullets = false;
delete_on_wall_col = true;
move_type = e_movetype.vector;
is_bullet = true;
player_freeze_duration = 0;


can_switch_cooldown = 1;
do_stun = true;
piercing_cancel = false;

//hvsp
hsp = 0;
vsp = 0;
grav = .1;
//vector
spd = 0;
dir = 0;
//melee
parent = -1;
xdis = 0;
ydis = 0;
invis_set = true;
knockback_dir = 0;
draw_delay = 1;
//structures
//hit_list = ds_map_create();
hit_wall = false;
do_init_check = true;
extra_sprite = undefined;
//stats
dmg			= 2;
knockback	= 1.5;
stun		= 4;
duration	= 30;
mp_mult		= 0.11;//.15
spark_col   = -1;
poison_add  = 0;
fully_charged = false;
reflected = false;

//effects
piercing	= false;
ghost		= false;
hit_duration = 1;
//visual extras
trail_fx = sbullet_trail;
trail_interval = 8;
trail_timer = 0;
size_mult = 1;

//juice
lag_add 	=  15;//15
shake_add	= 0.8;//.7

hit_fx = sgun_blink;
angle_spin = 0;
draw_angle = 0;

destroy_index = 0;
bounces = false;
bounces_left = 0;
floor_z = 0;
frc = 1;
self_push =false;
custom_user = -1;
do_draw = false;

alarm[0] = 1;

silhouette_draw  = 0;
silhouette_timer = 1+irandom_fixed( 5 );
silhouette_blend = merge_color( c_white, c_aqua, 0.5 );//
play_sound_cooldown = 0;
step_number = 1;

dir_angle_spin = 0;
multihit_cooldown = 0;
multihit = false;
multihits_left = 15;
multihit_cooldown_amount = 10;

sound_emitter = undefined;
sound = undefined;
local_sound = undefined;
local_sound_start_falloff = 60;
local_sound_end_falloff = 125;
local_sound_volume = 1;
local_sound_falloff_rate = 1;
local_sound_pitch = 1;
stun_mult = 1;
do_movement_general = true;

//hit
do_hitfreeze = false;
hitfreeze = 0;
hitfreeze_col = c_white;
SHAKE = 0;
parent = undefined;
alt_init = true;

destroy_function = function() {
	switch(destroy_index) {
		case 0:
		
			if ( hit_wall ) {
				image_xscale = .1;
				image_yscale = .1;
				if( gen_col(x,y) ){
					var i = 16; while( i-- && gen_col(x,y) ) {
						x -= LDX(1,dir);
						y -= LDY(1,dir);
					}
					//LOG(i);
				}
			}
		
			if ( duration > 0 ) {
				var num = 1+irandom_fixed(2);
				repeat(num) {//
					var t = ICD(x-LDX(4,dir),y-LDY(4,dir),0,ospark_alt);
					var ddr = dir-180+random_range_fixed(-70,70);
					t.hsp = ( LDX( spd*random_range_fixed(.3,1)*.4, ddr ) 			 )*( 0.55+random_fixed(0.4) );
					t.vsp = ( LDY( spd*random_range_fixed(.6,1)*.2, ddr ) -1-random_fixed(6) )*0.9;
					if( spark_col != -1 )t.col = spark_col;
				}
			} 
		
			if ( hit_fx != -1 ) {
				//if( hit_wall ){
					var fx = create_fx(x,y,sgun_blink,1,dir,0);	 
				//} else {
					//var fx = create_fx(x+LDX(spd,dir),y+LDY(spd,dir),hit_fx,1,dir,0);
				
					//var ww = sprite_get_width(sprite_index)*0.55;
				
					//var fx = create_fx(x+LDX(ww,dir),y+LDY(ww,dir),hit_fx,1,dir,0);
				//}
			}
		
		break;
		case 1: //Grenade
			var num = 1+irandom_fixed(2);
			repeat(num) {
				var t = ICD(x-LDX(4,dir),y-LDY(4,dir),0,ospark_alt);
				var ddr = dir-180+random_range_fixed(-70,70);
				t.hsp = ( LDX( spd*random_range_fixed(.3,1)*.4, ddr ) 			 )*( 0.55+random_fixed(0.4) );
				t.vsp = ( LDY( spd*random_range_fixed(.6,1)*.2, ddr ) -1-random_fixed(6) )*.9;
				if( spark_col != -1 )t.col = spark_col;
			}
			
			if ( instance_exists( parent ) ) {
				if ( point_distance(x,y,parent.x,parent.y-22) < 30 ) {
					if ( parent.state != e_player.hit ) {
						effect_create_depth(  -40, ef_ring, t.x, t.y-22, 0, merge_colour(c_red,c_ltgray,0.6) );
						parent.hit_freeze = floor(max(8,dmg/5 ) );
				
						parent.screen_flash_col	= c_gray;
						parent.flash_alpha		= 0.07;
				
					} else {
						parent.hit_freeze = floor( max(4,dmg/6) );
					}
				
					parent.state = e_player.hit;
					parent.hp -= dmg;
					parent.hit_timer = floor(dmg*8*stun_mult);
					parent.hit_freeze = max(4,dmg/3);
					parent.bounce_cooldown = 30;
				
					parent.can_hook_delay = false;
					var tt_ = parent;
					with ( ohook ) {
						if ( parent == tt_ || hook_object == tt_ ) {
							state = 2;
							if (instance_exists(wire) ) {
								IDD(wire);
							}
						}
					}
					parent.hsp *= 0.25;
					parent.vsp *= 0.25;
					parent.vsp = -4;
				}
			}
			audio_play_sound_pitch_falloff(choose_fixed(snd_explotion_1,snd_explotion_2),.4,.6+random_fixed(.25),4);
			audio_play_sound_pitch_falloff(choose_fixed(snd_explotion_1,snd_explotion_2),.4,.5+random_fixed(.15),4);
		
			var n = 4+irandom_fixed(3);
			var r = 20;
		
			repeat(n) {
				var xx = x+random_range_fixed( -r, r );
				var yy = y+random_range_fixed( -r, r );
				var f = create_fx(xx,yy,sexplotion,(.9+random_fixed(1.7))*.7,0,-10);
				f.image_alpha = .5+random_fixed(1);
			}
			repeat(n) {
				var xx = x+random_range_fixed( -r, r );
				var yy = y+random_range_fixed( -r, r );
				ICD(xx,yy,0,osmoke);
			}
		
			var sp = 1+irandom_fixed(2);
			repeat(sp) {
				var s = ICD(x,y,-1,ospark_alt);
				s.dir = point_direction(0,0,hsp,vsp) + random_range_fixed(-40,40);
			}
		
		
			//if ( TRINK[e_trinket.fragile_metals] ) {
			//	var bcl = TRINK[13] ? c_olive : c_gray;
			//	if ( INVIS <= 0 ) {
			//		if ( ( point_distance(x,y,oplayer.x,player_mid_y) < 40 ) && oplayer.state != e_player.cutscene ) {
			//			scr_player_take_damage(2,1,0,false);
			//			INVIS = 15;
			//		}
			//	}
			//	var num = 20+irandom_fixed(10);
			//	repeat(num) {
			//		var t = ICD( x+RR( -32, 32 ), y+RR( -32, 32 )-16, 1, osmoke_fx );
			//		t.spd *= 1.8;
			//		t.image_blend   = merge_color( bcl, c_white, RR( 0.8, 1 ) );
			//		t.sprite_index  = sdandelion;
			//		t.do_size		= false;
			//		t.duration= 100+random_fixed(160);
			//	}
		
			//SHAKE+=4;
		
			audio_play_sound_pitch_falloff(snd_explotion_0,0.6,0.6+random_fixed(0.25),4);
			//} else {
			//	//var bcl = TRINK[13] ? c_olive : c_white;
			//	var do_blend =  TRINK[13];
			//	if ( INVIS <= 0 && oplayer.state != e_player.cutscene ) {
			//		if ( duration <= 1 ) {//in case of enemy hit
			//			if ( point_distance(x,y,oplayer.x,player_mid_y) < 45 )  {
			//				scr_player_take_damage(1,1,0,false);
			//				INVIS = 10;
			//			}
			//		} else {
			//			if ( point_distance(x,y,oplayer.x,player_mid_y) < 25 ) {
			//				scr_player_take_damage(1,1,0,false);
			//				INVIS = 10;
			//			}
			//		}
			//	}
			//	var num = 20+irandom_fixed(10);
			//	repeat(num) {
			//		var t_ = ICD( x, y, 1, osmoke_fx );
			//		t_.spd *= 1.5;
			//		if ( do_blend ) t_.image_blend = merge_color(c_olive,t_.image_blend,RR(1,.4));
			//	}
			//SHAKE += 3;
			//}
			//image_xscale = TRINK[e_trinket.fragile_metals] ? 4.5 : 2.7;
			//image_yscale = TRINK[e_trinket.fragile_metals] ? 4.5 : 2.7;
			//var t = instance_place(x,y,par_enemy);
			//image_xscale = 1;
			//image_yscale = 1;
		
			//if ( t && ( ( !PLC(x,y,par_bulletshield ) || instance_place(x,y,par_bulletshield).active = false  )  || ghost ) ) {
			//	//check
			//	//affect
			//	if( ds_map_exists(hit_list,t) )exit;
			//	hit_list[? t] = 1;
			//	if ( t.invis ) exit;
			//	t.hp -= dmg;
			//	t.stun += stun;
			//	if poison_add > 0 t.poison_timer = poison_add;
			//	MP += dmg*mp_mult*t.give_mp_mult;
			
			
		
			//	//knockback
			//	if ( t.knockable ) {
			//		var knock_dir = move_type == e_movetype.melee ? knockback_dir : dir;
			//		t.hsp += LDX(knockback,knock_dir);
			//		t.vsp += LDY(knockback,knock_dir);
			//	}
	
			//	with t event_perform(ev_other,ev_user0);
	
			//	if ( move_type == e_movetype.melee ) {
			//		var num = 1+irandom_fixed(2);
			//		repeat(num) {
			//			var t = ICD(x-LDX(4,dir),y-LDY(4,dir),0,ospark_alt);
			//			var ddr = dir-180+random_range_fixed(-70,70);
			//			t.hsp = ( LDX( spd*random_range_fixed(.3,1)*.4, ddr ) 			 )*( .55+random_fixed(.4) );
			//			t.vsp = ( LDY( spd*random_range_fixed(.6,1)*.2, ddr ) -1-random_fixed(6) )*.9;
			//			if spark_col != -1 t.col = spark_col;
			//		}
			//		if hit_fx != -1 {
			//			create_fx(x,y,hit_fx,1,dir,1);
			//		}
			//	}
	
			//	//juice
		
			//SHAKE += shake_add;
		
			//	alarm[1] = 2;
	
			//	//bullet
			//	if ( !piercing && !multihit ) {
			//		hit_wall = true;
			//		IDD();
			//		step_number = 0;
			//	}
			//}
		break;
		//ds_map_destroy(hit_list);
		
		
	}


}

 
