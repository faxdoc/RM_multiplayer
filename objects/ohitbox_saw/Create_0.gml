event_inherited();
do_movement_general = false;
move_state = 0;
start_delay = 2;
bounces_left = 1;
grav = .06;
base_xscale = 1;
base_yscale = 1;
base_blend = image_blend;
base_dmg = 1;
duration = 1800;
spin_dir = 0;
init = false;
spin_flip = 1;
can_push_cooldown = 0;
hit_freeze = 0;
enflamed = false;
alt_movement = false;
alt_init = false;
player_exists = true;
//can_hitfreeze_cooldown = 0;

alt_init_2 = false;

collision_init();
gen_col = PLA;
//switch(current_biome) {
//	case e_biome.climb_intermission:
//	case e_biome.library:
//	case e_biome.climb_action_0:	
//	case e_biome.climb_platforming_0:
//	case e_biome.climb_action_1:	
//	case e_biome.climb_platforming_1:
//	case e_biome.climb_action_2:	
//	case e_biome.climb_platforming_2:
//	case e_biome.climb_action_3:	
//	case e_biome.climb_platforming_3:
//	case e_biome.dlc_swamp:
//	case e_biome.boss_rush:
//		layer_col	= global.collision_layer;
//		gen_col		= tplace_meeting_walls_precise;
//	break;
//	default:
//		layer_col = layer_get_id("Tiles_1");
//		gen_col = PLA;
//	break;
//}
//hitmap = ds_map_create();
#macro PLC place_meeting

base_xscale = image_xscale;
base_yscale = image_yscale;
base_blend = image_blend;
base_dmg = dmg*1.5;

damage_mult = 2;

multihits_left = 5;
multihit = true;
multihit_cooldown_amount = 12;

