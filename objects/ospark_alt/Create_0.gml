falling = false;
//event_inherited();
start = 30 + random_fixed(95);
duration = start;

//col = merge_color(choose_fixed(c_orange,c_red,c_yellow,c_white ),c_white,.5);
col = choose_fixed(c_orange,c_orange,merge_color(c_orange,c_red,0.2),merge_color(c_orange,c_red,0.4));
col = merge_color(col,c_black,.8);
image_alpha = 1;
hsp = random_range_fixed(3,-3);
vsp = -4-random_fixed(2);

grav = 0.3;
draw_angle = 0;
draw_xscale = 1;
layer_col = layer_get_id("Tiles_1");

