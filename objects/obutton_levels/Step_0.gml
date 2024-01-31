var controller = undefined;
with ( oplayer ) {
	if ( first_looser == id ) {
		if ( priority_select_timer > 0 ) {
			priority_select_timer -= 1/6;
			controller = id;
		}
	}
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
} else {
	var do_hover_ = false;
	with ( oplayer ) {
		var mx_ = MX-camera_x;
		var my_ = MY-camera_y;
		var k1p = K1P;
		
		
		with ( other ) {
			if ( instance_position(mx_,my_,id) ) {
				do_hover_ = true;
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
		
			
	}
	
	if ( do_hover_ ) {
		image_blend = c_white;
		image_xscale = lerp(image_xscale, 1, 0.2 );
		image_yscale = lerp(image_yscale, 1, 0.2 );
	} else {
		image_xscale = lerp(image_xscale,0.8, 0.2 );
		image_yscale = lerp(image_yscale,0.8, 0.2 );
		image_blend = c_gray;
	}
			
}


