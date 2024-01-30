if ( !duration-- ) IDD();
y += up_spd;
if ( type == 0 ) {
	draw_text( x, y, str );
	//scribble( str ).transform( xscale, yscale, draw_angle ).align(1,1).blend( back_col, duration/20 ).draw( x, y+1 );
	//scribble( str ).transform( xscale, yscale, draw_angle ).align(1,1).blend( base_col, duration/20 ).draw( x,   y );
} else {
	var xx = x, yy = y, cc = merge_color( c_orange, c_gray, 0.2 );
	var cc2  = merge_color( c_red, c_gray, 0.2 ); 
	var calt = c_darkest;
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	//draw_set_font(fnt_number_big);
		
	draw_text_color(xx,yy, str, cc2, cc2, cc2, cc2, duration/10 );
	
	//draw_set_font(fnt_text_old);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
}
#macro c_darkest $322E1E