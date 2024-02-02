

if ( jump_charge_buffer > 0 ) {
	var cl = choose_fixed(c_orange,c_yellow);
	var llh = jump_charge_buffer/10;
	draw_line_width_color( x-18*draw_xscale, y-llh-16, x-18*draw_xscale, y+llh-16, 3, cl, cl );
}



