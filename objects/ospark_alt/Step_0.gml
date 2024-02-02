if ( init_del ) {
	init_del = false;
	if ( random_fixed(1) < 0.5 ) {
		IDD();
	}
}
if !duration-- {IDD();}

vsp += grav;
var t = duration/start; 
image_blend =  merge_color(col,c_white,max(0,t*.5-.3));
image_alpha = min(1,duration/30);
draw_xscale = t*1.2;
x += hsp;
y += vsp;
if duration < start - 5 {
	if tplace_meeting(x,y+vsp,layer_col) {
		vsp = -vsp * (0.5+random_fixed(0.2));
		y-=1;
		duration -= 5;
	}
	if tplace_meeting(x+hsp,y-1,layer_col) {
		hsp = -hsp * (0.3+random_fixed(0.3));
		duration -= 5;
	}
}

