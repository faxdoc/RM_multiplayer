event_inherited();
hsp  =  0;
vsp  =  0;
grav = 0.17*WORLD_GRAV;
frc  = .8;
draw_xscale = 1;
draw_angle = 0;
windable = true;


gen_col			= tplace_meeting_walls_general;
layer_col		= layer_get_id("Tiles_1");
collision_code	= scr_collision;

alarm[9] = 1;
