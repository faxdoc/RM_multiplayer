event_inherited();
CINT;
falling = false;

state		= 0;
grav		= 0.3;
collision   = true;
time_delete = true;
image_speed = 0;

ind = irandom_fixed(99);
duration = 600 - random_fixed(320);

red = true;
spin = random_range_fixed(-25,25);
xscale = 1;
yscale = 1;
falling_timer = 0;
alpha = 1;
angle = 0;

image_blend = choose_fixed( c_dkgray,	c_gray, c_ltgray );
hsp = random_range_fixed(-2.5,2.5);
vsp = -2-random_fixed(5);
alarm[ 0 ] = 1;
function draw_red() {
	 var sz = ( min( 1, duration/200 ) );
	 draw_sprite_ext( sprite_index, image_index, x, y, sz*xscale, sz*yscale,angle, image_blend, alpha );
}
layer_col = layer_get_id("Tiles_1");
gen_col = tplace_meeting_walls_general;
collision_code = scr_collision;

#macro CINT collision_init()

