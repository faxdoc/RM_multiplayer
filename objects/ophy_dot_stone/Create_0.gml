hsp = random_range_fixed( -2, 2 ) * 0.5;
vsp = ( -2 - random_fixed( 5 ) ) * 0.4;
grav = 0.2;
image_blend = merge_color( dark_col, c_gray, random_fixed( 0.5 ) );//choose_fixed(c_dkgray,c_gray,merge_color(c_dkgray,c_gray,.5),c_olive);
duration = 40;
layer_col = layer_get_id("Tiles_1");

depth = random_range_fixed( -2, 2 );
var size = choose_fixed( 1, 1, 2 );
image_xscale = size;
image_yscale = size;

