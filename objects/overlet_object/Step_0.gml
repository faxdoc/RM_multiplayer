#region init
if ( ex_init ) {
	switch(index) {
		default:
			var i = 0; repeat(ynum) {
				vertex[i] = verlet_create_vertex( x,y,0,x,y,0,8,false);
				if i != ynum - 1 lines[i] = verlet_create_line( i,i+1,line_len,true);
				i++;
			}
			number = array_length(vertex);
			line_number = array_length(vertex)-1;
		break;
		case 1:
			for (var i = 0; i < xnum; i++) {
				for (var j = 0; j < ynum; j++) {
					var cv = i * ynum + j;
				
					vertex[cv] = verlet_create_vertex( x, y,4,x+random_range_fixed(-5,5), y,i,16,false );
				
					if (j != ynum - 1) {
						lines[cv-i] = verlet_create_line( cv, cv+1, line_len, true );
					}
				
					if (i != xnum - 1) {
						lines[xnum * (ynum - 1) + cv] = verlet_create_line( cv, cv+ynum, line_len, true );
					}
				}
			}
			number = array_length(vertex);
			line_number = array_length(lines);
		break;
		case 2:
			
		break;
		case 3:
			
		break;
	}
	ex_init = false;
}
#endregion

#region math
var percent,vl=vertex,v,v1,v2,ld = lines,ll;
var vnum = number;
var lnum = line_number;
var i = 0; repeat(vnum) {
	v = vl[i];
	if( !v.frozen ){
		//x
		vx[i] = (v.xx-v.oldx)*universal_frc;
		v.oldx = v.xx;
		if( do_collision && gen_col(v.xx+vx[i],v.yy) ){
			vx[i] = 0;
		}
		v.xx += vx[i];

		//y	
		vy[i] = (v.yy-v.oldy)*universal_frc+grav;
		v.oldy = v.yy;
		if( do_collision && gen_col(v.xx,v.yy+vy[i])){
			vy[i] = 0;
		}
		v.yy += vy[i];

	}
	i++;
}
repeat(rep_number) {
	var i = 0; repeat(lnum) {
		ll = ld[i];
		var v1 = vl[ ll.p1 ];
		var v2 = vl[ ll.p2 ];
	
		var dx = v1.xx-v2.xx;
		var dy = v1.yy-v2.yy;
	
		var len = line_len;//ll.len;
		var len_2 = sqrt((dx*dx)+(dy*dy));
		var diff = len_2 - len;
		if diff > 0 {
			percent = (diff / len_2) / stretch;
			var offx = dx * percent;
			var offy = dy * percent;
			
			if do_collision {
				if !v1.frozen {
					if !gen_col(v1.xx-offx,v1.yy) {
						v1.xx -= offx;
					}
					if !gen_col(v1.xx,v1.yy-offy) {
						v1.yy -= offy;
					}
				}
				if !v2.frozen {
					if !gen_col(v2.xx+offx,v2.yy) {
						v2.xx += offx;
					}
					if !gen_col(v2.xx,v2.yy+offy) {
						v2.yy += offy;
					}
				}
			} else {
				if !v1.frozen {
					v1.xx -= offx;
					v1.yy -= offy;	
				}
				if !v2.frozen {
					v2.xx += offx;
					v2.yy += offy;
				}
			}
		}//
		i++;
	}
}
#endregion

#region collision

#endregion

#region parent
 if ( parent != undefined && instance_exists(core_parent) ) {
 	var vert = vertex[0];
 	vert.xx = core_parent.x + x_off;
 	vert.yy = core_parent.y + y_off;
 }

#endregion