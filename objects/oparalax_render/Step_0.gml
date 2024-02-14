/*
if ( visible ) {
	if ( parent != undefined && instance_exists(parent) ) {
		var lx_ = parent.camera_x;
		var ly_ = parent.camera_y;
		
		paralax_timer += 0.2;
		if paralax_timer > 128 paralax_timer = 0;
		
		background_cloud_x = ceil( lx_*0.95 );
		background_cloud_y = ceil( ly_*0.95 );
		
		background_max_x = ceil(  lx_*0.85 );
		background_max_y = ceil(  ly_*0.85 );
		
		background_mid_x = ceil(  lx_*0.8 );
		background_mid_y = ceil(  ly_*0.8 );
	}
}



//x_off = RR(-1,1);
//y_off = RR(-1,1);




