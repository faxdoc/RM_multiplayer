var xoffset_ = 0;
var yoffset_ = 0;
	
shader_set(shd_max_a);
draw_surface_part( application_surface, frac(parent.camera_x), frac(parent.camera_y),GW*2,GH*2,round(parent.screen_shake_x)-xoffset_, round(parent.screen_shake_y)-yoffset_);
shader_reset();

