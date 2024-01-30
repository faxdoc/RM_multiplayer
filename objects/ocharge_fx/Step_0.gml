spd = lerp(spd,max_spd,lerp_pwr);

//image_xscale = (  (spd/1.5))*.3;
//image_yscale = (1-(spd/1.5))*.3;
if ( duration < 120 ) {
	image_xscale = (spd/max_spd)*size;
	image_yscale = (2/spd      )*size*yscale_mult;
}
if ( !duration-- )				  IDD();
if ( !instance_exists( target ) ) IDD();

var dir = point_direction(x,y,target.x+target_offset_x,target.y+target_offset_y);
var dis = point_distance( x,y,target.x+target_offset_x,target.y+target_offset_y);
if (dis < 17+spd) IDD();
if ( change_dir ) {
	image_angle = dir;
}
x += LDX( spd, dir );
y += LDY( spd, dir );

