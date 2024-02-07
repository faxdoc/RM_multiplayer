hsp = 0;
vsp = 0;

frc = 0.85;

state = e_ameli_orb_state.idle;
attack_timer = 0;
init_timer = 0;

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
