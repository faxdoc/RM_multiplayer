var controller = undefined;
with ( oplayer ) {
	if ( first_looser == id ) controller = id;
}


if ( controller != undefined ) {
	var mx_ = controller.MX-controller.camera_x;
	var my_ = controller.MY-controller.camera_y;
	var k1p = controller.K1P;
	
	if ( instance_position(mx_,my_,id) ) {
		image_blend = c_white;
		image_xscale = lerp(image_xscale, 1, 0.2 );
		image_yscale = lerp(image_yscale, 1, 0.2 );
	} else {
		image_xscale = lerp(image_xscale,0.8, 0.2 );
		image_yscale = lerp(image_yscale,0.8, 0.2 );
		image_blend = c_gray;
	}

	if (k1p ) {
	
		if ( instance_position(mx_,my_,id) ) {
			//randomize();
			var rl_ = [rtest,rtower,rceiling,rflat,rplatform,ropen];

			var rm__ = rl_[ image_index ];
			switch(image_index) {
				default: room_goto(rm__); break;
			}
		}
	}

}


