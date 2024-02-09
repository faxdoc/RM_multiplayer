hsp = 0;
vsp = 0;

frc = 0.85;
grav = WORLD_GRAV;
state = e_ameli_orb_state.idle;
attack_state = e_ameli_orb_attack_state.idle;
attack_alt_cooldown = 0;

attack_timer = 0;
init_timer = 0;
parent = undefined;
idle_timer = 0;
attack_cooldown = 0;
image_index = 0;
image_speed = 0;
depth = -120;
last_knockbox = -1;
hitfreeze = 0;
laser_dir = 0;
own_hitbox = -1;
intro_timer = 0;
saw_dir = 0;
sticky_target = undefined;
saw_spd = 1.5;

enum e_ameli_orb_state {
	idle,
	init,
	
	time_bomb,
	trap,
	bomb,
	anti_air,
	beam,
	strike,
	
	trap_triggered,
	anti_air_triggered,
}

enum e_ameli_orb_attack_state {
	idle,
	active,
	passive,
}

triggered_timer = 0;
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
trap_max_timer_cap = 120;
trap_max_timer = 0;
start_moving_x = x;
start_moving_y = y;
MX = 0;
MY = 0;
gun_len = 0;
gun_height = 0;
crouching = false;
char_index = e_char_index.ameli;

timed_explotion_radius = 116;
timer_explotion_duration = 70;

spike_trap_size = 68;
trail_cooldown = 0;
spike_init_speed = 1.5;
