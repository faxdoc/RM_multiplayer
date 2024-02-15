

if ( jump_charge_buffer > 0 ) {
	var cl = choose_fixed(c_orange,c_yellow);
	var llh = jump_charge_buffer/10;
	draw_line_width_color( x-18*draw_xscale, y-llh-16, x-18*draw_xscale, y+llh-16, 3, cl, cl );
}

switch(emote_state) {
	case 0:
	
	break;
	case 1:
		if ( player_local ) {
			var xx = x, yy = bbox_top - 22, ds = 18;
			var i = 0; repeat(6) {
				draw_sprite_ext( stext_icons, 1, xx + ds * ( i - 2.5 ), yy, 0.5, 0.5, 0, c_gray, 1 );
				draw_sprite_ext( stext_icons, 2+i, xx + ds * ( i - 2.5 ), yy, 0.5, 0.5, 0, c_orange, 1 );
				
				draw_sprite( snumbers, i, xx + ds * ( i - 2.5 ), yy );
				
				i++;
			}
		}
		
	break;
	
	default:
		var xx = x, yy = bbox_top - 25, ds = 20;
		if ( emote_timer > 75 ) {
			var sz_ = max(0,(80-emote_timer)/5);
		} else {
			var sz_ = min(1,emote_timer/10);
		}
		draw_sprite_ext( stext_icons, 0,						xx, yy, sz_, sz_, 0, c_white, 1 );
		draw_sprite_ext( stext_icons, emote_state, xx-1, yy+1,sz_ , sz_, 0, c_darkest, 0.1  );
		draw_sprite_ext( stext_icons, emote_state, xx, yy,        sz_,  sz_, 0, c_darkest, 1 );
	break;
}

