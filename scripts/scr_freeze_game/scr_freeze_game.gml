//function scr_freeze_game(){
//	while( true ) {
//		if keyboard_check( ord("L") ) {
//			break;
//		}
//	}
//}

function scr_check_hitscan_collision( _start_x, _start_y, target ) {
	if ( !instance_exists(target) ) {
		return false;
	}
	var t_ = ICD( _start_x, _start_y, 0, par_game );
	with ( par_game ) {
		gen_col			= tplace_meeting_walls_general;
		layer_col		= layer_get_id("Tiles_1");
		collision_code	= scr_collision;
		
		var col_ = true;
		var cx_  = _start_x;
		var cy_  = _start_y;
		var _end_x = lerp( target.bbox_left, target.bbox_right,  0.5 );
		var _end_y = lerp( target.bbox_top,  target.bbox_bottom, 0.5 );
		var ds_ = point_distance( _start_x, _start_y, _end_x, _end_y ) div 2;
		var i = 0; repeat( ds_ ) {
			x = lerp(_start_x,_end_x,i/ds_);
			y = lerp(_start_y,_end_y,i/ds_);
			if( place_meeting(x,y,target) ) {
				IDD();
				return true;
			} else if ( gen_col( x, y ) ) {
				IDD(); 
				return false;
			}
			i++;
		}
		IDD();
		return true;
		
	}
}
