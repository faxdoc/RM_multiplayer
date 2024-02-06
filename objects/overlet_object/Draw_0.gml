//var vnum = number;
//if is_array(vertex) {
//	var vl=vertex;
//	var i = 0,v; repeat(vnum) {
//		DSC( merge_color( start_col, end_col, clamp( (i/number)*color_mult, 0, 1 ) ));
//		v = vl[i];
//		draw_circle(v.xx,v.yy,circle_size,false);
//		i++;
//	}
//	DSC( c_white );
//}

//var vnum = number;
//var yl = ynum;
//var i = 0,vl=vertex; repeat(vnum-1-ynum) {
//	var v1 = vl[i];
//	var v2 = vl[i+1];
//	var v3 = vl[i+ynum];
//	var v4 = vl[i+ynum+1];
//	DSC( merge_color( $1D94F8, $2D64F2, (i mod yl) / yl )  );
//	if ( i mod yl == 0 ) draw_primitive_begin(pr_trianglestrip );
//	draw_vertex( v1.xx, v1.yy );
//	draw_vertex( v2.xx, v2.yy );
//	draw_vertex( v3.xx, v3.yy );
//	draw_vertex( v4.xx, v4.yy );
//	if ( i mod yl == yl-2 ) draw_primitive_end();
//	i++;
//}
//DSC( c_white );

switch(draw_index) {
	default:
		if (!is_undefined(parent) && instance_exists(parent) ) {
			var vnum = number;
			if is_array(vertex) {
				var vl=vertex;
				draw_primitive_begin( pr_trianglestrip );
				var i = 0,v; repeat( vnum ) {
					DSC( merge_color( start_col, end_col, ( i/number )  ) );
					v = vl[i];
					draw_vertex(v.xx+0.8,v.yy);
					draw_vertex(v.xx-0.8,v.yy);
					i++;
				}
				draw_vertex(parent.x+1,parent.y-24);
				draw_vertex(parent.x-1,parent.y-24);
				DSC(c_white);
				draw_primitive_end();
	
				draw_primitive_begin(pr_trianglestrip);
				var i = 0,v; repeat(vnum) {
					DSC( merge_color( start_col, end_col, ( i/number )  ) );
					v = vl[i];
					draw_vertex(v.xx,v.yy+0.8);
					draw_vertex(v.xx,v.yy-0.8);
					i++;
				}
				draw_vertex(parent.x+1,parent.y-24);
				draw_vertex(parent.x-1,parent.y-24);
				DSC(c_white);
				draw_primitive_end();
			}
		}
	break;
	case 1:
		var vnum = number;
		if is_array(vertex) {
			var vl=vertex;
			var v1;
			var v2;
			var i = 0,v; repeat(vnum-1) {
				DSC( merge_color( start_col, end_col, ( i/number )  ) );
				v1  = vl[i];
				v2  = vl[i+1];
				var dr = point_direction(  v1.xx, v1.yy,  v2.xx, v2.yy );
				var ds_ = point_distance( v1.xx, v1.yy,  v2.xx, v2.yy )/24;
				draw_sprite_ext( chain_maya, i, v2.xx, v2.yy, ds_, 1, dr+180,  merge_color( start_col, end_col, ( i/number )  ),  1 );
				i++;
			}
			var ds_ = point_distance( oplayer.x, player_mid_y,  v2.xx, v2.yy )/32;
				
			draw_sprite_ext( chain_maya, i, v2.xx, v2.yy, ds_,  1, dr,  merge_color( start_col, end_col, ( i/number )  ),  1 );
			
			var v;
			v = vl[0];
			draw_sprite_ext( schain_maya_rose, 0, v.xx, v.yy, 1, 1, 0,  merge_color( start_col, end_col, 0  ), 1  );
			v = vl[vnum - 1];
			draw_sprite_ext( schain_maya_rose, 0, oplayer.x, player_mid_y, 0.5, 0.5, 0,  merge_color( start_col, end_col, 1  ), 1  );
			
				
				
		}
	break;
}
//switch(draw_index) {
//	default:
//		var vnum = number;
//		if is_array(vertex) {
//			var vl=vertex;
//			var i = 0,v; repeat(vnum) {
//				DSC( merge_color( start_col, end_col, clamp( (i/number)*color_mult, 0, 1 ) ));
//				v = vl[i];
//				draw_circle(v.xx,v.yy,circle_size,false);
//				i++;
//			}
//			DSC( c_white );
//		}
//	break;
//	case 1:
//		var vnum = number;
//		var yl = ynum;
//		var i = 0,vl=vertex; repeat(vnum-1-ynum) {
//			var v1 = vl[i];
//			var v2 = vl[i+1];
//			var v3 = vl[i+ynum];
//			var v4 = vl[i+ynum+1];
//			DSC( merge_color( $1D94F8, $2D64F2, (i mod yl) / yl )  );
//			if ( i mod yl == 0 ) draw_primitive_begin(pr_trianglestrip );
//			draw_vertex( v1.xx, v1.yy );
//			draw_vertex( v2.xx, v2.yy );
//			draw_vertex( v3.xx, v3.yy );
//			draw_vertex( v4.xx, v4.yy );
//			if ( i mod yl == yl-2 ) draw_primitive_end();
//			i++;
//		}
//		DSC( c_white );
//	break;
//	case 2:
//		var vnum = number;
//		if is_array(vertex) {
//			var vl=vertex;
//			draw_primitive_begin( pr_trianglestrip );
//			var i = 0,v; repeat( vnum ) {
//				DSC( merge_color( start_col, end_col, ( i/number )  ) );
//				v = vl[i];
//				draw_vertex(v.xx+.8,v.yy);
//				draw_vertex(v.xx-.8,v.yy);
//				i++;
//			}
//			draw_vertex(oplayer.x+1,oplayer.y-24);
//			draw_vertex(oplayer.x-1,oplayer.y-24);
//			DSC(c_white);
//			draw_primitive_end();
			
//			draw_primitive_begin(pr_trianglestrip);
//			var i = 0,v; repeat(vnum) {
//				DSC( merge_color( start_col, end_col, ( i/number )  ) );
//				v = vl[i];
//				draw_vertex(v.xx,v.yy+.8);
//				draw_vertex(v.xx,v.yy-.8);
//				i++;
//			}
//			draw_vertex(oplayer.x+1,oplayer.y-24);
//			draw_vertex(oplayer.x-1,oplayer.y-24);
//			DSC(c_white);
//			draw_primitive_end();
//		}
		
//	break;
//	case 3:
		
//	break;
//}

//// draw_self();
