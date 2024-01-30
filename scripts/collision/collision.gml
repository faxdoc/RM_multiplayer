function layer_get_tilemap_id_fixed(lay_){
/// layer_tilemap_get_id_fixed(layer)
/// @param layer
	var els = layer_get_all_elements(lay_);
	var n = array_length(els);
	for (var i = 0; i < n; i++) {
	    var el = els[i];
	    if (layer_get_element_type(el) == layerelementtype_tilemap) {
	    return el;
	    }
	}
	return -1;
}
//
function tplace_meeting(xx_,yy_,layer_) {
	
	var  _tm = layer_get_tilemap_id_fixed(layer_);
	var _x1 = tilemap_get_cell_x_at_pixel(_tm, clamp(bbox_left  + (xx_-x),  8, room_width - 8 ), clamp( y,						0, room_height ) ),
		_y1 = tilemap_get_cell_y_at_pixel(_tm, clamp(x,						8, room_width - 8 ), clamp( bbox_top    + (yy_-y),	0, room_height ) ),
		_x2 = tilemap_get_cell_x_at_pixel(_tm, clamp(bbox_right + (xx_-x),	8, room_width - 8 ), clamp( y,						0, room_height ) ),
		_y2 = tilemap_get_cell_y_at_pixel(_tm, clamp(x,						8, room_width - 8 ), clamp( bbox_bottom + (yy_-y),	0, room_height ) );
			
	for(var _x = _x1; _x <= _x2; _x++) {
	 for(var _y = _y1; _y <= _y2; _y++) {
	    if ( tile_get_index( tilemap_get(_tm, _x, _y) ) ) return true;
	 }
	}
	return false;
}

function tplace_meeting_index(xx_,yy_,layer_) {
	///@description tplace_meeting_index(x,y,layer)
	var  _tm = layer_get_tilemap_id_fixed(layer_);

		var _x1 = tilemap_get_cell_x_at_pixel(_tm, clamp(bbox_left  + (xx_-x),8,room_width-8),	clamp(y						,0, room_height ) ),
			_y1 = tilemap_get_cell_y_at_pixel(_tm, clamp(x,8,room_width-8),						clamp(bbox_top    + (yy_-y)	,0, room_height ) ),
			_x2 = tilemap_get_cell_x_at_pixel(_tm, clamp(bbox_right + (xx_-x),8,room_width-8),	clamp(y 				    ,0, room_height ) ),
			_y2 = tilemap_get_cell_y_at_pixel(_tm, clamp(x,8,room_width-8),						clamp(bbox_bottom + (yy_-y)	,0, room_height ) );
	for(var _x = _x1; _x <= _x2; _x++){
	 for(var _y = _y1; _y <= _y2; _y++){
	    if(tile_get_index(tilemap_get(_tm, _x, _y))){
	    return tile_get_index( tilemap_get( _tm, _x, _y ) );
	    }
	 }
	}
	return false;
}

function tplace_meeting_index_precise(xx_,yy_,layer_) {
	///@description tile_meeting(x,y,layer)
	if (!instance_exists(otile_collision_checker) ) return false;
	if (instance_exists( par_slice_collision )) {
		if ( place_meeting( xx_, yy_, ograss_seperate_render ) ) {
			return 1;
		} else if (place_meeting( xx_, yy_, par_slice_collision )) {
			return 0;
		}
	}
	
	var _tm = layer_get_tilemap_id_fixed(layer_col);
	
	var ww = g.room_grid_width;
	var hh = g.room_grid_height;
	var nx_ = xx_-x;
	var ny_ = yy_-y;
	var _x1 = clamp( floor( (bbox_left   + nx_ ) / 16 ), 0, ww );
	var _x2 = clamp( floor( (bbox_right  + nx_ ) / 16 ), 0, ww );
	var _y1 = clamp( floor( (bbox_top    + ny_ ) / 16 ), 0, hh );
	var _y2 = clamp( floor( (bbox_bottom + ny_ ) / 16 ), 0, hh );
	
	var xs, ys, rs;
	for (var _x = _x1; _x <= _x2; _x++) {
	 for (var _y = _y1; _y <= _y2; _y++) {
	    var ind = tile_get_index(tilemap_get(_tm, _x, _y));
		switch(ind) {
			case 2:
			case 3:
			case 4:
				ys = tile_get_flip(   tilemap_get(_tm, _x, _y   ) ) ? 1 : -1;
				rs = tile_get_rotate( tilemap_get(_tm, _x, _y   ) ) ? 1 :  0;
				if ( ind == 4 ) {
					xs = tile_get_mirror( tilemap_get(_tm, _x, _y   ) ) ? 135 : 45;
					otile_collision_checker.x			 = floor(_x * 16 + 8 );
					otile_collision_checker.y			 = floor(_y * 16 + 8 );
				} else {
					xs = tile_get_mirror( tilemap_get(_tm, _x, _y   ) ) ? 116 : 64;
					otile_collision_checker.x = floor(_x * 16 + 8 ) + ( !rs ? 0    :   ys*4 )*(ind == 2 ? 1 : -1);
					otile_collision_checker.y = floor(_y * 16 + 8 ) + ( !rs ? -ys*4 :     0 )*(ind == 2 ? 1 : -1);
				}
				otile_collision_checker.image_angle = ( xs * ys ) - rs*90;
				if ( place_meeting( xx_, yy_, otile_collision_checker ) ) return tile_get_index( tilemap_get( layer_get_tilemap_id_fixed( layer_ ), _x, _y ) );
			break;
			case 1: return tile_get_index( tilemap_get( layer_get_tilemap_id_fixed( layer_ ), _x, _y ) ); break;
			case 8: case 0: 	 break;
		}
	  }
	}
	return 0;
}




function tplace_meeting_index_target(xx_,yy_,layer_,target_) {
	///@description tile_meeting(x,y,layer)
	var _layer = layer_,
	    _tm = layer_get_tilemap_id_fixed(_layer);
	    
	var _x1 = tilemap_get_cell_x_at_pixel(_tm, clamp(bbox_left  + (xx_-x),8,room_width-8),	clamp(y						,0, room_height ) ),
		_y1 = tilemap_get_cell_y_at_pixel(_tm, clamp(x,8,room_width-8),						clamp(bbox_top    + (yy_-y)	,0, room_height ) ),
		_x2 = tilemap_get_cell_x_at_pixel(_tm, clamp(bbox_right + (xx_-x),8,room_width-8),	clamp(y 				    ,0, room_height ) ),
		_y2 = tilemap_get_cell_y_at_pixel(_tm, clamp(x,8,room_width-8),						clamp(bbox_bottom + (yy_-y)	,0, room_height ) );
	for(var _x = _x1; _x <= _x2; _x++){
	 for(var _y = _y1; _y <= _y2; _y++){
	    if(tile_get_index(tilemap_get(_tm, _x, _y))==target_){
			return true;
	    }
	 }
	}
	return false;
}


	
function tplace_meeting_walls(xx_,yy_,layer_) {
	///@description tile_meeting(x,y,layer)
	var _layer = layer_,
	    _tm = layer_get_tilemap_id_fixed(_layer);
	    
	var _x1 = tilemap_get_cell_x_at_pixel( _tm, clamp(bbox_left  + (xx_-x),8,room_width-8),	clamp( y						,0, room_height ) ),
		_y1 = tilemap_get_cell_y_at_pixel( _tm, clamp(x,8,room_width-8),					clamp( bbox_top    + (yy_-y)	,0, room_height ) ),
		_x2 = tilemap_get_cell_x_at_pixel( _tm, clamp(bbox_right + (xx_-x),8,room_width-8),	clamp( y 				    ,0, room_height ) ),
		_y2 = tilemap_get_cell_y_at_pixel( _tm, clamp(x,8,room_width-8),					clamp( bbox_bottom + (yy_-y)	,0, room_height ) );
	for(var _x = _x1; _x <= _x2; _x++){
	 for(var _y = _y1; _y <= _y2; _y++){
	    var ind = tile_get_index(tilemap_get(_tm, _x, _y));
		switch(ind) {
			default: return true; break;
			case 0:
			case 96: 
			case 97: 
			case 98: 
			case 99: break;
	    }
	 }
	}
	return false;
}

function tplace_meeting_walls_precise( xx_, yy_ ) {
	///@description tile_meeting(x,y,layer)
	if (!instance_exists(otile_collision_checker) ) return false;
	if( instance_exists( par_slice_collision ) ){
		if ( place_meeting( xx_, yy_, par_slice_collision ) ) return true;
	}
	
	var _tm = layer_get_tilemap_id_fixed( layer_col );
	    
	var ww = g.room_grid_width;
	var hh = g.room_grid_height;
	var nx_ = xx_-x;
	var ny_ = yy_-y;
	var _x1 = clamp( floor( ( bbox_left   + nx_ ) / 16 ), 0, ww );
	var _x2 = clamp( floor( ( bbox_right  + nx_ ) / 16 ), 0, ww );
	var _y1 = clamp( floor( ( bbox_top    + ny_ ) / 16 ), 0, hh );
	var _y2 = clamp( floor( ( bbox_bottom + ny_ ) / 16 ), 0, hh );
	
	var xs, ys, rs;
	for (var _x = _x1; _x <= _x2; _x++) {
	 for (var _y = _y1; _y <= _y2; _y++) {
	    var ind = tile_get_index(tilemap_get(_tm, _x, _y));
		switch(ind) {
			case 2:
			case 3:
			case 4:
				ys = tile_get_flip(   tilemap_get(_tm, _x, _y   ) ) ? 1 : -1;
				rs = tile_get_rotate( tilemap_get(_tm, _x, _y   ) ) ? 1 :  0;
				if ( ind == 4 ) {
					xs = tile_get_mirror( tilemap_get(_tm, _x, _y   ) ) ? 135 : 45;
					otile_collision_checker.x			 = floor(_x * 16 + 8 );
					otile_collision_checker.y			 = floor(_y * 16 + 8 );
				} else {
					xs = tile_get_mirror( tilemap_get(_tm, _x, _y   ) ) ? 116 : 64;
					otile_collision_checker.x = floor(_x * 16 + 8 ) + ( !rs ? 0    :   ys*4 )*(ind == 2 ? 1 : -1);
					otile_collision_checker.y = floor(_y * 16 + 8 ) + ( !rs ? -ys*4 :     0 )*(ind == 2 ? 1 : -1);
				}
				otile_collision_checker.image_angle = ( xs * ys ) - rs*90;
				if ( place_meeting( xx_, yy_, otile_collision_checker ) ) return true;
			break;
			case 1: return true; break;
			case 8: case 0: 	 break;
		}
	  }
	}
	return false;
}

function tplace_meeting_walls_general(xx_,yy_) {
	///@description tile_meeting(x,y,layer)
	var _layer = layer_col,
	    _tm = layer_get_tilemap_id_fixed(_layer);

	//var _x1 = tilemap_get_cell_x_at_pixel(_tm,	clamp(bbox_left  + (xx_-x),8,room_width-8), max( 0, y					 ) ),
	//    _y1 = tilemap_get_cell_y_at_pixel(_tm,	clamp(x,8,room_width-8),					  max( 0, bbox_top    + (yy_-y) ) ),
	//    _x2 = tilemap_get_cell_x_at_pixel(_tm,	clamp(bbox_right + (xx_-x),8,room_width-8), max( 0, y 				     ) ),
	//    _y2 = tilemap_get_cell_y_at_pixel(_tm,	clamp(x,8,room_width-8),					  max( 0, bbox_bottom + (yy_-y) ) );
	var _x1 = tilemap_get_cell_x_at_pixel(_tm,		clamp(bbox_left  + (xx_-x),8,room_width-8),	clamp(y						,0, room_height ) ),
			_y1 = tilemap_get_cell_y_at_pixel(_tm,	clamp(x,8,room_width-8),					clamp(bbox_top    + (yy_-y)	,0, room_height ) ),
			_x2 = tilemap_get_cell_x_at_pixel(_tm,	clamp(bbox_right + (xx_-x),8,room_width-8),	clamp(y 				    ,0, room_height ) ),
			_y2 = tilemap_get_cell_y_at_pixel(_tm,	clamp(x,8,room_width-8),					clamp(bbox_bottom + (yy_-y)	,0, room_height ) );
	for(var _x = _x1; _x <= _x2; _x++){
	 for(var _y = _y1; _y <= _y2; _y++){
	    var ind = tile_get_index(tilemap_get(_tm, _x, _y));
		switch(ind) {
			default: return true; break;
			case 0:
			case 96: 
			case 97: 
			case 98: 
			case 99: break;
	    }
	 }
	}
	return false;
}

function tile_sort_collision(x_,y_,target_layer_,target_) {
	switch(target_) {
		case 0: return !tplace_meeting(x_,y_,target_layer_); break;
		case 1: return tplace_meeting_walls(x_,y_,target_layer_); break;
		case 2:
			if (tplace_meeting_index_target(x_,y_,target_layer_,97)) return true;
			if (tplace_meeting_index_target(x_,y_,target_layer_,98)) return true;
			return false;
		break;
	}
}
function tile_sort_collision_alt(x_,y_,target_layer_,target_) {
	switch(target_) {
		case 0: return !tplace_meeting(				 x_,y_, target_layer_   ); break;
		case 1: return tplace_meeting_walls_precise( x_,y_ ); break;
		case 2: return tplace_meeting_index_target(  x_,y_, target_layer_,8 );  break;
	}
}

function tile_sort_genre(ind) {
	return 1;
	//switch(ind) {
	//	case 24:
	//	case 129:
	//	case 130:
	//		return 3;
	//	break;
	//	case 131:
	//	case 132:
	//	case 25:
	//	case 26: 
	//		return 2; 
	//	break;
			
	//	default:
	//		if ( ind > 0 && ind <= 26 ) {
	//			return 1;
	//		} else if (ind > (1+32) && ind <= (16+32)) || ( ind > (1+320) && ind <= (16+320)  ) {
	//			return 2;
	//		} else if (ind > 384) {
	//			return 4;
	//		}
	//	break;
	//}
	
	//return 0;
}

/// Returns true if the given point in room coordinates collides with a wall tile.
function tile_point_collision(xx, yy, tilemap)
{
	if (xx < 0 || xx >= room_width || yy < 0 || yy >= room_height) {
		return false;
	}
	
	var tx = tilemap_get_cell_x_at_pixel(tilemap, xx, yy);
	var ty = tilemap_get_cell_y_at_pixel(tilemap, xx, yy);
	switch (tile_get_index(tilemap_get(tilemap, tx, ty))) {
		// Don't know what these tile indices are but I copied
		// these from tplace_meeting_walls and seems to work.
		// -Riuku
		default: return true; break;
		case 0:
		case 96: 
		case 97: 
		case 98: 
		case 99: break;
    }
	return false;
}

/// Returns true if the given line in room coordinates collides with a wall tile.
/// You can improve the performance of this function by adjusting the interval.
/// A higher interval means less precision and better performance, because it means that more
/// pixels are skipped when checking collision points between the start and end points.
/// 
/// Note: In general this is not a very performant function and should really be replaced
///       with a completely different method, because more performant ones exist.
///       I'm just too lazy to figure it out right now and this was easy to implement.
///       -Riuku
function tile_line_collision(x1, y1, x2, y2, _layer, interval = 1)
{
	interval = floor(max(1, interval));
	
	var tilemap = layer_get_tilemap_id_fixed(_layer);
	
	// This function travels the pixels between the start
	// and end points akin to Bresenham's algorithm,
	// checking for tile collisions along the way.
	
	x1 = floor(x1);
	y1 = floor(y1);
	x2 = floor(x2);
	y2 = floor(y2);
	var xx = x1;
	var yy = y1;
	
	var w = x2 - xx;
    var h = y2 - yy;
    var dx1 = sign(w);
    var dy1 = sign(h);
    var dx2 = sign(w);
    var dy2 = 0;
    var longest = abs(w);
    var shortest = abs(h);
    if (longest <= shortest) {
        longest = abs(h);
        shortest = abs(w);
        dy2 = sign(h);
        dx2 = 0;
    }
    
    var numerator = longest / 2;
    for (var i = 0; i <= longest; ++i) {
    	if ((i % interval == 0) && tile_point_collision(xx, yy, tilemap)) {
    		return true;
    	}
        numerator += shortest;
        if (numerator >= longest) {
            numerator -= longest;
            xx += dx1;
            yy += dy1;
        }
        else {
            xx += dx2;
            yy += dy2;
        }
    }
	
	return false;
}

function scr_collision() {
	//if live_call() return live_result;
	var o = layer_col,h=hsp,v=vsp,n;
	if (tplace_meeting_walls(x+ceil(h),y,o)) ||( tplace_meeting_walls(x+h,y,o)) {
		var s = sign(hsp),n=0;
		while (!tplace_meeting_walls(x+s,y,o) )&& n<64 { n++; x+=s*.1; }
		hsp = 0;
	}
	x+=hsp;
	if ( tplace_meeting_walls(x,y+ceil(v),o) || tplace_meeting_walls(x,y+v,o) ) {
		
		var s = sign(vsp),n=0;
		while ( !tplace_meeting_walls(x,y+s,o) && n<32 ) { n++; y+=s; }
		vsp = 0;
		
	}
	y+=vsp;
}
function collision_init() {
	layer_col = layer_get_id("Tiles_1");
}
function wave(min_, max_, time_, offset_) {
	//var a4 = (max_ - min_) * 0.5;
	return lerp(min_,max_,0.5);//min_ + a4 + sin((((current_time * 0.001) + time_ * offset_) / time_) * (pi*2)) * a4;
}
function scr_collision_sea() {
	var o = layer_col,h=hsp,v=vsp,n;
	if( tplace_meeting_walls(x+ceil(h),y,o) || tplace_meeting_walls(x+h,y,o) ){
		var s = sign(hsp);var n=0;
		while( !tplace_meeting_walls(x+s,y,o) && n<32 ){ n++; x+=s*.1; }
		hsp = 0;
	}
	x+=hsp*.75;
	if( tplace_meeting_walls(x,y+ceil(v),o) || tplace_meeting_walls(x,y+v,o) ){
		var s = sign(vsp);var n=0;
		while( !tplace_meeting_walls(x,y+s,o) && n<32 ){ n++; y+=s; }
		vsp = 0;
	}
	y+=vsp*.75;
}

function scr_collision_precise() {
	var h=hsp,v=vsp,n;
	if (tplace_meeting_walls_precise(x+ceil(h),y) || tplace_meeting_walls_precise(x+h,y)) {
		var s = sign(hsp),n=0;
		while (!tplace_meeting_walls_precise(x+s,y) && n<32 ){ n++; x+=s*.1; }
		hsp = 0;
	}
	x+=hsp;
	if( tplace_meeting_walls_precise(x,y+ceil(v)) || tplace_meeting_walls_precise(x,y+v)) {
		var s = sign(vsp),n=0;
		while( !tplace_meeting_walls_precise(x,y+s) && n<32 ){ n++; y+=s; }
		vsp = 0;
	}
	y+=vsp;
}
function scr_collision_precise_slopes() {
	var h=hsp,v=vsp,n;
	var vn_ = clamp(vsp,-12,12);
	var on_ground = tplace_meeting_walls_precise(x,y+1);
	#region horizontal
	var ha = abs(hsp)+1;
	//if touching wall
	if (tplace_meeting_walls_precise(x+ceil(h),y) || tplace_meeting_walls_precise(x+h,y)) {
		
		if ( tplace_meeting_walls_precise( x, y + 4 ) ) && (!tplace_meeting_walls_precise(x+ceil(h),y-ha*1.2) && !tplace_meeting_walls_precise(x+h,y-ha*1.2)) {
			x += hsp;
			var n=0;
			while (tplace_meeting_walls_precise(x,y)) && n<64 { n++; y-=.2; }
		} else if ( tplace_meeting_walls_precise(x,y-3.5) ) && (!tplace_meeting_walls_precise(x+ceil(h),y+ha*1.2) && !tplace_meeting_walls_precise(x+h,y+ha*1.2)) {
			x += hsp;
			var n=0;
			while (tplace_meeting_walls_precise(x,y)) && n<64 { n++; y+=.2; }
		} else {
			var s = sign(hsp),n=0;
			while (!tplace_meeting_walls_precise(x+s,y)) && n<64 { n++; x+=s*.2; }
			hsp = 0;
		}
	} else {
		x += hsp;
	}
	
	//Downwards slopes
	if ( on_ground && vsp == 0 && tplace_meeting_walls_precise( x, y+ha*1.5 ) ) {
		var n=0;
		while (!tplace_meeting_walls_precise(x,y+1) && n<64) { n++; y+=.2; }
		vsp = 0;
	}
	
	#endregion
	
	#region vertical
	var skip_normal = false;
	var can_alt_skip = 0;
	
	#region slope push
	if ( !on_ground && vsp < 0 ) {
		
		ha = ( abs(clamp(vsp,-10,10)) )+1;
		var max_base_margin = 3;
		var max_margin = 2;
		if ( tplace_meeting_walls_precise( x, y-ha ) || tplace_meeting_walls_precise( x, y-ceil(ha) ) ) {
			//Part 1
			//if ( hsp >= -1 && !tplace_meeting_walls_precise( x+max_base_margin+(hsp*.5), y-ha ) ) {
			//	can_alt_skip = 1;
			//} else if ( hsp <= 1 && !tplace_meeting_walls_precise( x-max_base_margin+(hsp*.5), y-ha ) ) {
			//	can_alt_skip = 2;
			//}
			//Part 2
			//if ( can_alt_skip == 0 ) {
			if ( ( hsp >= -1 && !tplace_meeting_walls_precise(x+5,y-12) ) || !tplace_meeting_walls_precise( x + ( ha*1.2 )  + hsp, y-ha ) ) {
				y += vsp;
				var n = 0;
				while (tplace_meeting_walls_precise(x,y) || tplace_meeting_walls_precise(x+ceil(h),y) ) && n<64 { n++; x+=1; }
				
				if ( !tplace_meeting_walls_precise(x-1,y+3) && tplace_meeting_walls_precise(x-4,y+3) ) {
					hsp += n*.05;
					vsp += n*.05;
				}
				
				skip_normal = true;
				//can_alt_skip = 0;
			} else if ( ( hsp <= 1 && !tplace_meeting_walls_precise(x-5,y-12) ) || !tplace_meeting_walls_precise( x - ( ha*1.2 ) + hsp, y-ha ) ) {
				y += vsp;
				var n = 0;
				while ( tplace_meeting_walls_precise( x, y ) || tplace_meeting_walls_precise(x+ceil(h),y) ) && n<64 { n++; x-=1; }
				
				if ( !tplace_meeting_walls_precise( x+1,y+3 )  && tplace_meeting_walls_precise( x+4, y+3 ) ) {
					hsp -= n*.05;
					vsp += n*.05;
				}
				
				skip_normal = true;
				//can_alt_skip = 0;
			}
			//}
			//switch(can_alt_skip) {
			//	case 1:
			//		y += vsp;
			//		var n = 0;
			//		while (tplace_meeting_walls_precise(x,y)) && n<64 { n++; x+=.4; }
			//		skip_normal = true;
			//	break;
			//	case 2:
			//		y += vsp;
			//		var n = 0;
			//		while (tplace_meeting_walls_precise(x,y)) && n<64 { n++; x-=.4; }
			//		skip_normal = true;
			//	break;
			//}
		}
	}
		
		
	//	//
		
	//}
	#endregion
	
	#region normal
	if ( !skip_normal ) {
		if (tplace_meeting_walls_precise(x,y+ceil(v)) || tplace_meeting_walls_precise(x,y+v)) {
			var s = sign(vsp),n=0;
			while (!tplace_meeting_walls_precise(x,y+s) && n<32) { n++; y+=s; }
			vsp = 0;
		}
		y+=vsp;
	}
	#endregion
	
	#endregion
	
}
function scr_collision_sea_precise_slopes() {
	var h=hsp,v=vsp,n;
	var on_ground = tplace_meeting_walls_precise(x,y+1);
	var ha = abs(hsp)+1;
	//if touching wall
	if (tplace_meeting_walls_precise(x+ceil(h),y) || tplace_meeting_walls_precise(x+h,y)) {
		//if on ground but not slope forward
		if ( tplace_meeting_walls_precise(x,y+3.5) ) && (!tplace_meeting_walls_precise(x+ceil(h),y-ha*1.2) && !tplace_meeting_walls_precise(x+h,y-ha*1.2)) {
			x += hsp*.75;
			var n=0;
			while (tplace_meeting_walls_precise(x,y)) && n<64 { n++; y-=.2; }
		} else {
			var s = sign(hsp),n=0;
			while (!tplace_meeting_walls_precise(x+s,y)) && n<64 { n++; x+=s*.2; }
			hsp = 0;
		}
	} else {
		x += hsp*.75;
	}
	
	if ( on_ground && vsp == 0 && tplace_meeting_walls_precise(x,y+ha*1.5) ) {
		var n=0;
		while (!tplace_meeting_walls_precise(x,y+1) && n<64) { n++; y+=.2; }
		vsp = 0;
	}
	
	if (tplace_meeting_walls_precise(x,y+ceil(v)) || tplace_meeting_walls_precise(x,y+v)) {
		var s = sign(vsp),n=0;
		while (!tplace_meeting_walls_precise(x,y+s) && n<32) { n++; y+=s; }
		vsp = 0;
	}
	y+=vsp*.75;
}

	// if (!instance_exists(otile_collision_checker) ) {
	// 	return false;
	// }
	// var _tm = layer_get_tilemap_id_fixed( layer_ );

	// var _x1 = tilemap_get_cell_x_at_pixel( _tm, clamp( bbox_left  + (xx_-x),8,room_width-8),	    clamp(y						,0, room_height ) ),
	// 	_y1 = tilemap_get_cell_y_at_pixel( _tm, clamp( x,8,room_width-8),						clamp(bbox_top    + (yy_-y)	,0, room_height ) ),
	// 	_x2 = tilemap_get_cell_x_at_pixel( _tm, clamp( bbox_right + (xx_-x),8,room_width-8),	clamp(y 				    ,0, room_height ) ),
	// 	_y2 = tilemap_get_cell_y_at_pixel( _tm, clamp( x,8,room_width-8),						clamp(bbox_bottom + (yy_-y)	,0, room_height ) );

	
	
	// for(var _x = _x1; _x <= _x2; _x++){
	//  for(var _y = _y1; _y <= _y2; _y++){
	//   var ind = tile_get_index(tilemap_get(_tm, _x, _y));
	// 	switch(ind) {
	// 		default:
	// 			otile_collision_checker.x			 = floor(_x * 16+8);
	// 			otile_collision_checker.y			 = floor(_y * 16+8);
	// 			otile_collision_checker.image_index  = ind;
	// 			otile_collision_checker.image_xscale = tile_get_mirror(tilemap_get(_tm, _x, _y )) ? -1 : 1;
	// 			otile_collision_checker.image_yscale = tile_get_flip(tilemap_get(_tm, _x, _y   )) ? -1 : 1;
	// 			otile_collision_checker.image_angle  = tile_get_rotate(tilemap_get(_tm, _x, _y )) ? -90 : 0;
			
	// 			if(place_meeting(xx_,yy_,otile_collision_checker)) return tile_get_index( tilemap_get( _tm, _x, _y ) );
	// 		break;
	// 		case 0:
	// 		break;
	// 	}
	//   }
	// }
	
	// return false;
	
function scr_collision_slope_reg( _x, _y, _slope, _xscale_normal, _yscale_normal, _rotate ) {
	_x = !_xscale_normal ? ( 15 - _x mod 16 ) : _x  mod 16;
	_y = !_yscale_normal ? ( 15 - _y mod 16 ) : _y  mod 16;
	var ax = _x;
	var ay = _y;
	
	if ( _rotate ) {
		switch( ( !_xscale_normal ? 1 : 0 ) + ( !_yscale_normal ? 2 : 0 ) ) {
			case 0:
				_x = ay;
				_y = 15-ax;
			break;
			case 1:
				_x = 15-ay;
				_y = ax;
			break;
			case 2:
				_x = 15-ay;
				_y = ax;
			break;
			case 3:
				_x = ay;
				_y = 15-ax;
			break;
		}
	}
	
	//rotate
	switch(_slope) {
		case 0://45 degree
			return( _x + _y >= 15 );
		break;//22.5 1
		case 1:
			return( _x/2 + _y >= 15 );
		break;
		case 2://22.5 2
			return( _x/2 + _y >= 7 );
		break;
	}
}
#macro PLA tplace_meeting_walls_general
#macro player_input_init if ( can_input && input_skip <= 8 )  { var hh			= KRIGHT  - KLEFT;var hhp			= KPRIGHT - KPLEFT;var vvp			= KPDOWN  - KPUP;var vv			= KDOWN   - KUP;var jump_hold   = K3  || KUP;var jump_press  = K3P || ( TAP_JUMP && KUP ); } else {var hh			= 0;var hhp			= 0;var vvp			= 0;var vv			= 0;var jump_hold	= 0;var jump_press	= 0; }

