if ( visible ) {
	if ( parent != undefined && instance_exists(parent) ) {
		var lx_ = parent.camera_x;
		var ly_ = parent.camera_y;
		
		background_max_x = lx_*0.13;
		background_max_y = ly_*0.13;
		
		background_mid_x = lx_*0.19;
		background_mid_y = ly_*0.19;
	}
}








