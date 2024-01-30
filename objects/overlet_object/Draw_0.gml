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
