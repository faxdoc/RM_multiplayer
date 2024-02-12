
if  ( do_draw ) {
	var xx_ = 0;
	var yy_ = 6;

	if ( place_meeting(x,y,oplayer) ) {
		draw_rectangle_ca(  xx_+GW*0.05, yy_+8, xx_+GW*0.95,  yy_+36, c_black, 0.9 );
		draw_set_halign( fa_center );
		draw_text( xx_ + GW*0.5, yy_+14, text[ index ] );
		draw_set_halign( fa_left );
	}

}
