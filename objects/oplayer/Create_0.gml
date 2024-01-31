event_inherited();
can_input			= true;
#macro WORLD_GRAV 1
on_ground = false;
jump_charge = 0;
spawn_timer = 0;

show_hp_timer = 0;
gun_charging = false;
SHOOT_BUFFER = 0;
doing_active = false;
FALL_MAX = 0;
current_weapon = 0;
effect_timer = 0;
body_y_previous  = 0;
wep_dir = 0;
grenade_input_buffer = 0;
shoot_hold_buffer		= 0;
input_skip = 0;
INVIS = 0;
intro_timer = 0;

move_alt_blink	= 0;
skip_redo		= true;
pre_hook_state	= e_player.normal;
move_hooked 	= false;
mask_index		= splayer_mask;
//alarm[0]		= 4;

TAP_JUMP = false;
jump_buffer = 0;
gun_charge = 0;  
space_buffer = 0;
land_y = 0;
INVIS = 0;

screen_flash_col = 0;
flash_alpha = 0;


//basic vars / variable dump
endless_hook		= false;
hit_timer			= 0;
state				= e_player.normal;
crouching			= false;
can_input			= true;
spawn_x 			= x;
spawn_y 			= y;
can_hook_delay		= 0;
hook_air_cancel 	= false;
hook_press_buffer	= 4;
shoot_press_buffer	= 0;
flying				= false;
wave_done			= false;

substate			= 0;
hook_sound			= -1;
charge_sound		= -1;
hook_charges		= 0;
hook_fx 			= 0;
circle_juice		= [ 0, 0, 0, 0, 0, 0 ];
touching_platform	= false;
boost_respawn		= false;
final_timer = 0;
#region movement variables

//Backup
base_walk_spd	= 0.385;
base_jump_pwr	= 4.68;
walk_spd		= base_walk_spd;
jump_pwr		= base_jump_pwr;
//grav			*= 1.2;
grav = 0.17*1.2;

jump_delay		= 0;

jump_charge_spd = 1;
jump_charge_max = 9;
can_parry_cooldown = 0;
legs_running_index = 0;

#endregion

#region drawing vars

draw_type = e_draw_type.aiming;
blink_timer = 0;
blink_state = 0;
timer		= 0;

head_x		= 0;
head_y		= 0;
hair_x		= 0;
hair_y		= 0;
body_y		= 0;

recoil		= 0;
flash		= 0;

flash_col	= c_white;
draw_xscale =  1;
hair		= -1;
legs		= splayer_legs;
legs_index	= 0;
blend		= c_white;
blend_timer = 0;
draw_alpha	= 1;
blink_state = 0;
skip_draw	= false;

#endregion


#region guns/weapon switch

wep_select = false;
switching_weapon = false;
switch_timer = 0;
wep_select_x = 0;
wep_select_y = 0;
push_timer = 0;
weapon_number = e_gun.height;

pistol_charge = 0;

//shooting vars
shoot_delay 	=  0;
aim_dir			=  0;
gun_height		= 25;
gun_len 		= 35;
gun_col 		= c_black;
shader			= shd_switch_white;
shader_pointer	= shader_get_uniform( shader, "new_col" );

//grenade
knife_state = 0;
knife_timer = 0;


#endregion

ledge_detect_cooldown = 0;
do_wings = false;


#region sound variables
track_sound_cooldown = 0;
wind_sound_gain = 0;
wind_sound = -1;

close_bullet_sound_played = false;
close_bullet_sound_played_cooldown = 0;


//walking
walk_sound_played = false;
floor_type = 0;
walk_sounds = [
	snd_walk_stone,
	snd_walk_dirt,
	snd_walk_stone,
	snd_walk_wood,
	snd_walk_metal,
];

#endregion

hair_start_col = c_gray;
hair_end_col   = c_dkgray;
hair_number    = 8;
hair_size = 3.2;
hair_alt_number = 0;
under_swinging = false;

//body
sprite_body_front	= splayer_jacket_front;
sprite_body_center	= splayer_body;
sprite_body_back	= splayer_jacket_back;
sprite_body_hoodie	= splayer_hoodie;
		
		
//arm
sprite_arm_outer		= splayer_hand_outer;
sprite_arm_outer_pistol	= splayer_hand_outer_pistol;
sprite_arm_inner		= splayer_hand_inner;
sprite_arm_weapon_swap	= splayer_hand_switch_wep;
sprite_arm_grenade		= splayer_hand_inner_knife;
		
//legs
sprite_legs_idle		= splayer_legs;
sprite_legs_run			= splayer_legs_run;
sprite_legs_jump		= splayer_legs_jump;
sprite_legs_crouching	= splayer_legs_crouching;
legs_sprite_start_run	= splayer_legs_start_run;
		
//head
sprite_eyes_down	= splayer_eyes_down;
sprite_eyes_mid		= splayer_eyes_mid;
sprite_eyes_mid_up	= splayer_eyes_mid_up;
sprite_eyes_up		= splayer_eyes_up;
sprite_head			= splayer_head;

grenade_cooldown = 0;
bullet_spread_index = 0;

//still
sprite_wallhug		= splayer_wallhug;
sprite_wallhug_still= splayer_wallhug_still;
sprite_dead			= splayer_dead;
sprite_hit			= splayer_hit;
turnaround_sprite   = splayer_turnaround;
sprite_legs_stop	= splayer_legs_stop;
dash_dir = 0;
KKDASH = 0;
can_dash = true;

layer_col  = layer_get_id("Tiles_1");
layer_type = layer_get_id("Tiles_1");
collision_function = scr_collision;

gen_col 			   = PLA;
gen_col_sort		   = tile_sort_collision;
collision_function_sea = scr_collision_sea;
dlc_mode			   = false;

hook_cooldown = 0;
hook_type__ = 2;

KUP		= 0;
KDOWN	= 0;
KLEFT	= 0;
KRIGHT	= 0;
K1		= 0;
K2		= 0;
K3		= 0;
K4		= 0;
K5		= 0;
K6		= 0;
K7		= 0;
K8		= 0;
KPAUSE	= 0;
KBACK	= 0;

KPUP	= 0;
KPDOWN	= 0;
KPLEFT	= 0;
KPRIGHT	= 0;
K1P		= 0;
K2P		= 0;
K3P		= 0;
K4P		= 0;
K5P		= 0;
K6P		= 0;
K7P		= 0;
K8P		= 0;
KPPAUSE	= 0;
KPBACK  = 0;

KRUP	= 0;
KRDOWN	= 0;
KRLEFT	= 0;
KRRIGHT	= 0;
K1R		= 0;
K2R		= 0;
K3R		= 0;
K4R		= 0;
K5R		= 0;
K6R		= 0;
K7R		= 0;
K8R		= 0;
KRPAUSE	= 0;
KRBACK	= 0;

KQ0 = false;
KQ1 = false;
KQ2 = false;
KQ3 = false;
KQ4 = false;
KQ5 = false;

var_dir = 0;

function weapon_create(spr_,name_,desc_,found_) {
	var struct = {
		sprite : spr_,
		name : name_,
		desc : desc_,
		found : found_,
	}
	return struct;
}


WEP_DATA = [
	weapon_create( splayer_gun_pistol,		"",	"",	true  ),
	weapon_create( splayer_gun_shotgun,		"",	"",	true  ),
	weapon_create( splayer_gun_rail,		"",	"",	true  ),
		
	weapon_create( splayer_gun_sniper,		"",	"",	true  ),
	weapon_create( splayer_gun_grenade,		"",	"",	true  ),
	weapon_create( splayer_gun_small,		"",	"",	true  ),
];
RELOAD = [ 0,0,0, 0,0,0 ];
CLIP = [ 0, 0, 0, 0, 0, 0 ];
jump_charge_buffer = 0;
SHAKE = 0;
gun_fully_charged = false;
previous_weapon = 0;
look_around_start_timer = 0;

nail_gun_spin = 0;
nail_gun_pos  = 0;

screen_shake_x = 0;
screen_shake_y = 0;
self_draw = true;
hit_freeze = 0;
bounce_cooldown = 0;
do_collision = true;
hit_timer = 0;

player_colour = c_aqua;
player_palette = spalette_player_1;

 //x = floor( lerp( ospawn_box.bbox_left,ospawn_box.bbox_right,   0) ); 
 //y = floor( lerp( ospawn_box.bbox_top,ospawn_box.bbox_bottom, 0.5) );
 

//player_colour = c_aqua;  player_palette = spalette_player_1; x = floor( lerp(ospawn_box.bbox_left,ospawn_box.bbox_right,   0) ); y = floor( lerp(ospawn_box.bbox_top,ospawn_box.bbox_bottom,0.5) ); // break;


if ( player_local ) {
	view_enabled = true;
	view_set_visible(0,true);
	camera_set_view_pos(  view_camera[ 0 ], floor( x-GW ), floor( y-GH ) );
	camera_set_view_size( view_camera[ 0 ], GW, GH );
}
palette_init = 3;
camera_x = x;
camera_y = y;
camera_spd = 0.053;
camera_clamp_pos = true;

if ( !global.inital_select ) {
	meta_state = 6;
} else {
	meta_state = -1;
}
hp = 150;
hp_max = 150;
lives_left = 4;

#region shader

main_shader = shd_palette;
main_shader_col_num_pointer   = shader_get_uniform(shd_palette,       "col_num"     );
main_shader_pal_num_pointer   = shader_get_uniform(shd_palette,       "pal_num"     );
main_shader_pal_index_pointer = shader_get_uniform(shd_palette,       "pal_index"   );
main_shader_palette_pointer	  = shader_get_sampler_index(shd_palette, "palette"     );
main_shader_uvs_pointer		  = shader_get_uniform(shd_palette,       "palette_uvs" );

shader_set(shd_palette);
	var palette_sprite = player_palette;
	palette_texture = sprite_get_texture(palette_sprite,0);
	var uvs = sprite_get_uvs(palette_sprite,0);
	shader_set_uniform_f(	    main_shader_col_num_pointer,   sprite_get_height(palette_sprite)  );
	shader_set_uniform_f(	    main_shader_pal_num_pointer,   sprite_get_width(palette_sprite) );
	shader_set_uniform_f(	    main_shader_pal_index_pointer, 1 );
	shader_set_uniform_f_array( main_shader_uvs_pointer,	   [uvs[0],uvs[1],uvs[2]-uvs[0],uvs[3]-uvs[1]]  );
	
	texture_set_stage( main_shader_palette_pointer, palette_texture );
shader_reset();
		
		
function start_palette() {
	shader_set(shd_palette);
	texture_set_stage( main_shader_palette_pointer, palette_texture );
}


first_looser = undefined;
random_inited = false;

#endregion

switch(player_id) {
	default: 
		player_colour = c_aqua;   
		x = floor( lerp(ospawn_box.bbox_left,ospawn_box.bbox_right,   0) ); 
		y = floor( lerp(ospawn_box.bbox_top,ospawn_box.bbox_bottom, 0.5) );  
	break;
	case 1:  
		player_colour = c_red;    
		x = floor( lerp(ospawn_box.bbox_left,ospawn_box.bbox_right,   1) ); 
		y = floor( lerp(ospawn_box.bbox_top,ospawn_box.bbox_bottom,0.5) );  
	break;
	case 2:  
		player_colour = c_lime;   
		x = floor( lerp( ospawn_box.bbox_left,ospawn_box.bbox_right,0.33 ) ); 
		y = floor( lerp( ospawn_box.bbox_top, ospawn_box.bbox_bottom,0.5 ) );  
	break;
	case 3:
		player_colour = c_white;  
		x = floor( lerp(ospawn_box.bbox_left,ospawn_box.bbox_right,0.66) );
		y = floor( lerp(ospawn_box.bbox_top,ospawn_box.bbox_bottom, 0.5) );  
	break;
}
priority_select_timer = 300;
pre_hp = hp;
damage_taken = 0;
