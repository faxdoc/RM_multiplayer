if ( vsp > 0 && tplace_meeting( x, y+1, layer_col ) ) {
	IDD();
}
vsp += grav;

x += hsp;
y += vsp;

if ( !duration-- ) IDD();
