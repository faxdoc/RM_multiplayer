/*
switch(type) {
	case 0:
		draw_sprite_ext( scloud_bg,0,background_cloud_x-paralax_timer,room_height-450+background_cloud_y,(room_width/128)+1, 3, 0, c_white, 0.2 );
		
		draw_sprite( sbg_forest_new_extra,0,background_max_x,    room_height-430+background_max_y);
		draw_sprite( sbg_forest_new_extra,0,background_max_x+666,room_height-430+background_max_y);
		
		draw_sprite_ext( sbg_front,0,background_mid_x,room_height-250+background_mid_y,room_width/128, 2, 0, c_white, 1 );
	break;
	case 2:
		draw_sprite_ext( scloud_bg,0,background_cloud_x-paralax_timer,room_height-450+background_cloud_y,(room_width/128)+1, 3, 0, c_white, 0.2 );
		
		var sp_ = 0.2;
		draw_sprite_tiled_ext(srain_fx,0,-paralax_timer * 2.5*sp_+x_off-32,paralax_timer * 60 * sp_+y_off-32, 0.4, 0.8*4, c_gray, 0.15 );
		draw_sprite( sbg_forest_new_extra,0,background_max_x,    room_height-430+background_max_y);
		draw_sprite( sbg_forest_new_extra,0,background_max_x+666,room_height-430+background_max_y);
		
		draw_sprite_ext( sbg_front,0,background_mid_x,room_height-250+background_mid_y,room_width/128, 2, 0, c_white, 1 );
		
		
	break;
	case 4:
		draw_sprite_ext( scloud_bg,0,background_cloud_x-paralax_timer,room_height-450+background_cloud_y-378,(room_width/128), 3, 0, c_white, 0.5 );
		
		draw_sprite_ext( sbg_forest_new,0,background_max_x,    room_height-430+background_max_y-328, 1, 1, 0, c_ltgray, 0.5 );
		draw_sprite_ext( sbg_forest_new,0,background_max_x+666,room_height-430+background_max_y-328, 1, 1, 0, c_ltgray, 0.5 );
		
		draw_sprite_ext( sbg_front,0,background_mid_x,room_height-250+background_mid_y-328,room_width/128, 2, 0, c_white, 1 );
		
	break;
	case 3:
		draw_sprite_ext( scloud_bg,0,background_cloud_x-paralax_timer,room_height-450+background_cloud_y-128,(room_width/128), 3, 0, c_dkgray, 0.3 );
		
		draw_sprite_ext( sbg_forest_new_extra,0,background_max_x,    room_height-430+background_max_y-128, 1, 1, 0, c_dkgray, 0.1 );
		draw_sprite_ext( sbg_forest_new_extra,0,background_max_x+666,room_height-430+background_max_y-128, 1, 1, 0, c_dkgray, 0.1 );
		
		draw_sprite_ext( sbg_front,0,background_mid_x,room_height-250+background_mid_y,room_width/128-128, 2, 0, c_white, 1 );
		
		//se 3:
		//var sp_ = 0.05;
		//blend_add
		//draw_sprite_tiled_ext(sfog_texture_old,0,-paralax_timer * 38*sp_+x_off-( parent.camera_x*.2),-paralax_timer * 10 * sp_+y_off-( parent.camera_y*.2), 0.6, 1.1, c_gray, 0.08 );
		//draw_sprite_tiled_ext(sfog_texture_old,0, paralax_timer * 39*sp_+x_off-( parent.camera_x*.1),paralax_timer * 15 * sp_+y_off-( parent.camera_y*.1),  1.6, 2.1,  c_gray, 0.02 );
		
	break;
	case 1:
		draw_sprite_ext( scloud_bg,0,background_cloud_x-paralax_timer,room_height-450+background_cloud_y,(room_width/128)+1, 3, 0, c_white, 0.3 );
		
		draw_sprite_ext( sbg_forest_new_extra,0,background_max_x,    room_height-430+background_max_y, 1, 1, 0, c_fuchsia, 0.07 );
		draw_sprite_ext( sbg_forest_new_extra,0,background_max_x+666,room_height-430+background_max_y, 1, 1, 0, c_fuchsia, 0.07 );
		
		//draw_sprite_ext( sbg_front,0,background_mid_x,room_height-250+background_mid_y,room_width/128, 2, 0, c_white, 1 );
	break;
}
//draw_sprite( sbg_front,0,background_max_x+444,background_max_y);








