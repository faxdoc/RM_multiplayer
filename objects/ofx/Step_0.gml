switch(type) {
	case e_fx.fade:
		timer -= 1/duration;
		//if ( max_depth != undefined ) && do_max_depth {
		//	depth = min(depth+.5,max_depth);
		//}
		if( timer <= -.1 ) IDD();
		image_alpha = timer*alpha_mult;
	break;
}
