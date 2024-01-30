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
	K6:		vk_shift,
	K7:		ord( "Q" ),
	K8:		ord( "F" ),
	dash:	ord( "E" ),
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
