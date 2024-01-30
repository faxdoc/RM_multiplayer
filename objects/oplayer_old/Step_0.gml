var _input = rollback_get_input();

if ( _input.left ) {
	x -= 1;
}
if ( _input.right ) {
	x += 1;
}

if ( _input.up ) {
	y -= 1;
}

if ( _input.down) {
	y += 1;
}

image_angle = point_direction( x, y, _input.mb_x, _input.mb_y );


if ( _input.fire_pressed ) {
	var _proj = instance_create_depth( x, y, 0, oprojectile );
	_proj.speed = 10;
	_proj.direction =	image_angle;
	_proj.image_angle = image_angle;
	_proj.player = self;
	
}
