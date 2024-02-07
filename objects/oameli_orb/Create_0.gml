hsp = 0;
vsp = 0;

frc = 0.85;
grav = WORLD_GRAV;
state = e_ameli_orb_state.idle;
attack_timer = 0;
init_timer = 0;
parent = undefined;
idle_timer = 0;
attack_cooldown = 0;
image_index = 0;
image_speed = 0;

enum e_ameli_orb_state {
	idle,
	init,
	
	time_bomb,
	trap,
	bomb,
	anti_air,
	beam,
	strike,
	
}
target_x = 0;
target_y = 0;
init = true;

main_blend = c_white;
secondary_blend = c_gray;

layer_col  = layer_get_id("Tiles_1");
layer_type = layer_get_id("Tiles_1");
collision_function = scr_collision;

gen_col 			   = PLA;
gen_col_sort		   = tile_sort_collision;
move_timer = 0;

target_state = e_ameli_orb_state.time_bomb;

start_moving_x = x;
start_moving_y = y;