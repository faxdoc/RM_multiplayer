switch(type) {
	case 0:
		var c = c_darkest;
		draw_text_colour( x, y+1, str, c, c, c, c, 1 );
		draw_text( x, y, str );
	break;
	default:
		var xx = x, yy = y, cc = merge_color( c_orange, c_gray, 0.2 );
		var cc2  = merge_color( c_red, c_gray, 0.1 ); 
		var calt = c_darkest;
	
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_font(global.fnt_number_big);
	
		draw_text_color(xx,yy+1, str, calt, calt, calt, calt, duration/10 );
		draw_text_color(xx,yy, str, cc2, cc2, cc2, cc2, duration/10 );
	
		draw_set_font(fnt_default);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_sprite_ext( sminus, 0, xx-10, yy-5, 1, 1, 0, calt, 1 );
		draw_sprite_ext( sminus, 0, xx-10, yy-6, 1, 1, 0, cc2, 1 );
	break;
	case 9:
		var xx = x, yy = y, cc = merge_color( c_orange, c_gray, 0.2 );
		var cc2  = merge_color( c_white, c_gray, 0.1 ); 
		var calt = c_darkest;
		
		draw_sprite_ext( splayer_grenade_silhouete, 0, xx-10, yy-5, 1.5, 1.5, 0, calt, 0.5*min(1,duration/6 ) );
		draw_sprite_ext( splayer_grenade_silhouete, 0, xx-10, yy-6, 1.5, 1.5, 0, blend,  0.7*min(1,duration/6 ) );
		
	break;
	case 11:
		var xx = x, yy = y, cc = merge_color( c_orange, c_gray, 0.2 );
		
		draw_sprite_ext( srocket_denied, 0, xx-10, yy-6, 1, 1, 0, c_white, 1.0 * min( 1, duration / 6 ) );
	break;
}
//if ( type == 0 ) {
	
	//scribble( str ).transform( xscale, yscale, draw_angle ).align(1,1).blend( back_col, duration/20 ).draw( x, y+1 );
	//scribble( str ).transform( xscale, yscale, draw_angle ).align(1,1).blend( base_col, duration/20 ).draw( x,   y );
//} else {
	
	
//}

#macro c_darkest $322E1E