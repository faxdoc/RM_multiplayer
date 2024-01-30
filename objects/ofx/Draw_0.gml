if( start_delay )exit;
if( end_draw )exit;
if( sprite_index < 0 )exit;
switch(blendtype) {
	case e_blendtype.normal:
		draw_self();
	break;
	case e_blendtype.add:
		gpu_set_blendmode(bm_add);
		draw_self();
		gpu_set_blendmode(bm_normal);
	break;
}

