if( blendtype == e_blendtype.normal) {
	draw_self();
} else {
	gpu_set_blendmode(bm_add);
	draw_self();
	gpu_set_blendmode(bm_normal);
}