if ( duration < 30 && duration mod 4 < 2 ) {
	fog_white
	event_inherited();
	fog_off
} else {
	event_inherited();
}
