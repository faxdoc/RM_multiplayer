function draw_stats() {
	
	var xx = floor(x)-14, yy = floor(bbox_top)-8;// merge_color( c_orange, c_gray, .2 );
	var cc, cc2;
	var calt = c_darkest;
	
	
	if ( hit_freeze ) {
		cc = merge_colour(c_white, player_colour, 0.4 );
		if ( air_combo ) {
			cc2 = merge_color( c_red, c_white, 0.4 ); 
		} else {
			cc2 = merge_color( c_fuchsia, c_white, 0.35 ); 
		}
	} else {
		cc = merge_colour(c_ltgray, player_colour, 0.5 );
		if ( air_combo ) {
			cc2 = merge_color( c_red, c_gray, 0.1 );
		} else {
			cc2 = merge_color( c_fuchsia, c_gray, 0.1 );
		}
	}
	// yy -= 2;
	draw_set_font(global.fnt_number_big);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
		
	draw_text_color(xx,yy-4+1,add0_float(ceil(hp),3),								 calt,calt,calt,calt, 0.7 );//.blend(cc,1).align(1,1).draw(xx,yy);
	if ( damage_taken ) {
		draw_sprite_ext(sminus, 0, xx-4+4, yy-22+1, 1, 1, 0, calt, (hit_timer/15)*0.7 );
		draw_text_color(xx+6+4,yy-16+1,add0_float(floor(damage_taken),2),calt,calt,calt,calt, (hit_timer/15)*0.7  );
	}
	
	draw_text_color(xx,yy-4, add0_float( ceil( hp ),3 ) ,cc, cc, cc, cc, 1 );
	if ( damage_taken ) {
		draw_sprite_ext(sminus,0, xx-4+4, yy-22, 1, 1, 0, cc2, hit_timer/15 );
		draw_text_color(xx+6+4,yy-16, add0_float(floor(damage_taken),2),cc2,cc2,cc2,cc2, hit_timer/15 );
	}
	draw_set_font(fnt_default);
	draw_set_valign(fa_top);
	
	xx += 14;
	yy -= 6;
	DSA(0.7);
	draw_line_width_color(xx-16,yy+4,xx+12,yy+4,2,calt,calt);
	DSA( 1);
	draw_line_width_color(xx-16,yy+3,xx+12,yy+3,2,cc,cc);
	
}


function scr_add0(_t, numb) {
	var len = numb - string_length(_t); repeat(len) _t = "0"+_t;
	return _t;
}

function add0_float( _t, numb ) {
	_t = string(_t);
	var len = numb - string_length(_t); repeat(len) _t = "0"+_t;
	return _t;
}



