rollback_define_player(oplayer);
rollback_define_input({
	KUP:	ord( "W" ),
	KDOWN:	ord( "S" ),
	KLEFT:	ord( "A" ),
	KRIGHT:	ord( "D" ),
	K1:		mb_left,
	K2:		mb_right,
	K3:		vk_space,
	K4:		vk_escape,
	K5:		vk_tab,
	K6:		vk_control,
	K7:		ord( "Q" ),
	K8:		ord( "T" ),
	dash:	[ord( "E" ),vk_shift,ord("F")],
	KBACK:	vk_enter,
	mx:		m_axisx,
	my:		m_axisy,
	
	quickswap_0: ord( "1" ),
	quickswap_1: ord( "2" ),
	quickswap_2: ord( "3" ),
	quickswap_3: ord( "4" ),
	quickswap_4: ord( "5" ),
	quickswap_5: ord( "6" )
	
});

if ( !rollback_join_game() ) {
	game_has_started = false;
} else {
	game_has_started = true;
}
intimer = 0;
window_set_cursor( cr_none );

window_set_size( GW * 2, GH * 2 );
surface_resize( application_surface, GW, GH );
application_surface_draw_enable( false );
draw_set_font( fnt_default );