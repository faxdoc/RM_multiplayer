
var ld_ = layer_get_id("Background");
var dp_ = layer_get_depth(ld_);
depth = dp_ - 50;
parent = undefined;
paralax_timer = 0;
x_off = 0;
y_off = 0;
background_cloud_x = 0;
background_cloud_y = 0;

background_max_x = 0;
background_max_y = 0;
background_mid_x = 0;
background_mid_y = 0;
type = 0;
switch(room) {
	case rplatform: type = 1; break;
	case rhill: type = 2; break;
	case rtower: type = 2; break;
	case rcup: type = 3; break;
	case rcity: type = 4; break;
	default: type = 0; break;
}
