//general
grav			= 0.125;
ground_frc		= 0.8;
universal_frc	= 0.91;
bounce			= 0.87;
//draw data
xnum = 5;
ynum = 9;
line_len = 2;
circle_size = 3;
stretch = 3;
rep_number = 3;
//parent connection
parent = -1;
x_off = 0;
y_off = 0;
z_off = 0;
#region meta
number = 14;
line_number = 6;
vertex = -1;
lines = -1;

do_collision = true;

ex_init = true;
index = 0;
#endregion

start_col = $191F43;
end_col = merge_color( $322E1E, $191F43, 0.65 );
visible = true;

mask_index = shair_mask;
draw_index = 0;

color_mult = 1;

layer_col = layer_get_id("Tiles_1");
gen_col = PLA;
parent = undefined;
core_parent = undefined;

