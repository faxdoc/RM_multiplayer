switch(type) {
	case 0:
		draw_sprite_ext( scloud_bg,0,background_cloud_x-paralax_timer,room_height-450+background_cloud_y,(room_width/128)+1, 3, 0, c_white, 0.2 );
		
		draw_sprite( sbg_forest_new_extra,0,background_max_x,    room_height-430+background_max_y);
		draw_sprite( sbg_forest_new_extra,0,background_max_x+666,room_height-430+background_max_y);
		
		draw_sprite_ext( sbg_front,0,background_mid_x,room_height-250+background_mid_y,room_width/128, 2, 0, c_white, 1 );
	break;
	case 1:
		draw_sprite_ext( scloud_bg,0,background_cloud_x-paralax_timer,room_height-450+background_cloud_y,(room_width/128)+1, 3, 0, c_white, 0.3 );
		
		draw_sprite_ext( sbg_forest_new_extra,0,background_max_x,    room_height-430+background_max_y, 1, 1, 0, c_fuchsia, 0.05 );
		draw_sprite_ext( sbg_forest_new_extra,0,background_max_x+666,room_height-430+background_max_y, 1, 1, 0, c_fuchsia, 0.05 );
		
		//draw_sprite_ext( sbg_front,0,background_mid_x,room_height-250+background_mid_y,room_width/128, 2, 0, c_white, 1 );
	break;
}
//draw_sprite( sbg_front,0,background_max_x+444,background_max_y);








