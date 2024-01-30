var _input = rollback_get_input();

KUP		= _input.KUP;	
KDOWN	= _input.KDOWN;	
KLEFT	= _input.KLEFT;	
KRIGHT	= _input.KRIGHT;
K1		= _input.K1;	
K2		= _input.K2;	
K3		= _input.K3;	
K4		= _input.K4;	
K5		= _input.K5;	
K6		= _input.K6;	
K7		= _input.K7;	
K8		= _input.K8;	
KDASH	= _input.dash;	
KBACK	= _input.KBACK;	

KPUP	= _input.KUP_pressed;	
KPDOWN	= _input.KDOWN_pressed;	
KPLEFT	= _input.KLEFT_pressed;	
KPRIGHT	= _input.KRIGHT_pressed;
K1P		= _input.K1_pressed;	
K2P		= _input.K2_pressed;	
K3P		= _input.K3_pressed;	
K4P		= _input.K4_pressed;	
K5P		= _input.K5_pressed;	
K6P		= _input.K6_pressed;	
K7P		= _input.K7_pressed;	
K8P		= _input.K8_pressed;	
KDASHP	= _input.dash_pressed;
KPBACK  = _input.KBACK_pressed;	

KQ0 = _input.quickswap_0;
KQ1 = _input.quickswap_1;
KQ2 = _input.quickswap_2;
KQ3 = _input.quickswap_3;
KQ4 = _input.quickswap_4;
KQ5 = _input.quickswap_5;

KRUP	= false;
KRDOWN	= false;
KRLEFT	= false;
KRRIGHT	= false;
K1R		= false;
K2R		= false;
K3R		= false;
K4R		= false;
K5R		= false;
K6R		= false;
K7R		= false;
K8R		= false;
KRPAUSE	= false;
KRBACK	= false;

MX = _input.mx;
MY = _input.my;


#region camera
var sn_ = ( current_weapon == e_gun.sniper && gun_charge > 0 );
mouse_bias =  sn_ ? 0.35 : 0.18;
var mb_ = mouse_bias*1.3;

var ld__ = player_id;
var alt_t = undefined;
with ( oplayer ) {
	if ( player_id != ld__ && meta_state == 1 ) {
		alt_t = id;
	}
}

if ( alt_t != undefined ) {
	var cx_ = lerp(x,alt_t.x,0.03);
	var cy_ = lerp(y,alt_t.y,0.03);
} else {
	var cx_ = x;
	var cy_ = y;
}


camera_x = lerp( camera_x, round( lerp( cx_,    MX, mb_ ) -(GW/2) ), 0.08 );
camera_y = lerp( camera_y, round( lerp( cy_-32, MY, mb_ ) -(GH/2) ), 0.08 );

if ( camera_clamp_pos ) {
	camera_x = clamp( camera_x, 0, room_width -GW );
	camera_y = clamp( camera_y, 0, room_height-GH );
}

if ( player_local ) {
	camera_set_view_pos( view_camera[ 0 ], floor( camera_x ), floor( camera_y ) );
}

#endregion

#region meta state
switch( meta_state ) {
	case -1:
		intro_timer += 1.25;
		if ( intro_timer > 100 ) {
			intro_timer = 20;
			spawn_timer = 0;
			meta_state = 1;
			state = e_player.normal;
			INVIS = 60;
			
		}
		
	break;
	case 1:
		if ( intro_timer > 0 ) {
			intro_timer--;
		}
	break;
	case 0:
		
	break;
}
if ( flash_alpha > 0 ) {
	flash_alpha -= 0.04;
}

#endregion
