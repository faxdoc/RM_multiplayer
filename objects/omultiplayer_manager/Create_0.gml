#macro TEST_DEFAULT false
#macro LIVE_DEFAULT false
#macro INIT_TEST_STATE e_meta_state.round_start
#macro TEST_FORCE_CHAR -1

#macro GAME_VERSION_NAME "VERSION "
#macro GAME_VERSION "B 0.1"

audio_channel_num( 40 );
global.test_enabled			= TEST_DEFAULT;
global.live_turned_on		= LIVE_DEFAULT;
global.training_mode		= false;

if (!instance_exists(orollback_holder)) {
	MAKES(orollback_holder);
}
if (!variable_global_exists("rollback_defined")) {
	global.rollback_value = -1;
	rollback_define_input_frame_delay( global.rollback_value );
	global.rollback_defined = true; 
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
		dash:	[ord( "E" ),vk_shift],
		KBACK:	vk_enter,
		mx:		m_axisx,
		my:		m_axisy,
		emote: ord("X"),
		
		wep_down:	m_scroll_down,
		wep_up:		m_scroll_up,
	
		quickswap_0: ord( "1" ),
		quickswap_1: ord( "2" ),
		quickswap_2: ord( "3" ),
		quickswap_3: [ord( "4" ), ord("R") ],
		quickswap_4: [ord( "5" ), ord("F") ],
		quickswap_5: [ord( "6" ), ord("G") ],
		switch_grapple_mode: ord( "U" )
	
	});
}

if ( global.test_enabled ) {
	IDD(orandom);
	IDD(omenu_bg_render);
	omultiplayer_manager.game_has_started = true; 
	audio_stop_sound( snd_music_menu_loop );
	with ( obutton ) {
		IDD();
	}
	layer_set_visible( layer_get_id("Assets_1"), false );
	layer_set_visible( layer_get_id("Assets_2"), false );
	game_has_started = true;
	rollback_create_game(2,true);
	global.training_mode = true;
	room_goto(rplatform);
	
	
} else if ( !rollback_join_game() ) {
	game_has_started = false;
} else {
	ICD(0,0,-500,oclo);
	game_has_started = true;
	with ( obutton ) {
		IDD();
	}
}
intimer = 0;
window_set_cursor( cr_none );

window_set_size( GW * 2, GH * 2 );
surface_resize( application_surface, GW, GH );
//application_surface_draw_enable( false );
draw_set_font( fnt_default );

//Maybe change
global.fnt_number_big		= font_add_sprite( snumber_big, ord("0"), false, 1 );
global.display_room_name	= "";
global.inital_select		= false;


rollback_use_random_input( false );


global.training_mode_visible		= true;
global.frame_by_frame_mode  		= false;
global.training_nocooldown  		= false;
global.training_infinite_hp 		= false;
global.training_stun_render 		= false;
global.training_display_hitboxes	= false;
global.training_mode_change_stage	= false;
global.speed_render 				= false;


