//KUP		= input_check("up"            );
//KDOWN	= input_check("down"          );
//KLEFT	= input_check("left"          );
//KRIGHT	= input_check("right"         );
//K1		= input_check("shoot"         );
//K2		= input_check("grapple"       );
//K3		= input_check("jump"          );
//K4		= input_check("weapon_select" );
//K5		= input_check("map"           );
//K6		= input_check("heal"          );
//K7		= input_check("grenade"       );
//K8		= input_check("interact"      );
//KPAUSE	= input_check("pause"         );
//KBACK	= input_check("back"         );

//KPUP	= input_check_pressed("up"            ); 
//KPDOWN	= input_check_pressed("down"          ); 
//KPLEFT	= input_check_pressed("left"          ); 
//KPRIGHT	= input_check_pressed("right"         ); 
//K1P		= input_check_pressed("shoot"         ); 
//K2P		= input_check_pressed("grapple"       ); 
//K3P		= input_check_pressed("jump"          ); 
//K4P		= input_check_pressed("weapon_select" ); 
//K5P		= input_check_pressed("map"           ); 
//K6P		= input_check_pressed("heal"          ); 
//K7P		= input_check_pressed("grenade"       ); 
//K8P		= input_check_pressed("interact"      ); 
//KPPAUSE	= input_check_pressed("pause"         ); 
//KPBACK  = input_check_pressed("back"         ); 

//KRUP	=  input_check_released("up"            ); 
//KRDOWN	=  input_check_released("down"          ); 
//KRLEFT	=  input_check_released("left"          ); 
//KRRIGHT	=  input_check_released("right"         ); 
//K1R		=  input_check_released("shoot"         ); 
//K2R		=  input_check_released("grapple"       ); 
//K3R		=  input_check_released("jump"          ); 
//K4R		=  input_check_released("weapon_select" ); 
//K5R		=  input_check_released("map"           ); 
//K6R		=  input_check_released("heal"          ); 
//K7R		=  input_check_released("grenade"       ); 
//K8R		=  input_check_released("interact"      ); 
//KRPAUSE	=  input_check_released("pause"         ); 
//KRBACK	=  input_check_released("back"         ); 

//var button_KUP		= ord("W");
//var button_KDOWN	= ord("S");
//var button_KLEFT	= ord("A");
//var button_KRIGHT	= ord("D");
//var button_K1		= mb_left;
//var button_K2		= mb_right;
//var button_K3		= vk_space;
//var button_K4		= vk_shift;
//var button_K5		= vk_tab;
//var button_K6		= ord("E");
//var button_K7		= ord("Q");
//var button_K8		= ord("F");
//var button_KPAUSE	= vk_escape;
//var button_KBACK	= vk_escape;
var _input = rollback_get_input();

//var button_KUP		= _input.KUP;		//ord("W");
//var button_KDOWN	= _input.KDOWN;		//ord("S");
//var button_KLEFT	= _input.KLEFT;		//ord("A");
//var button_KRIGHT	= _input.KRIGHT;	//ord("D");
//var button_K1		= _input.K1;		//mb_left;
//var button_K2		= _input.K2;		//mb_right;
//var button_K3		= _input.K3;		//vk_space;
//var button_K4		= _input.K4;		//vk_shift;
//var button_K5		= _input.K5;		//vk_tab;
//var button_K6		= _input.K6;		//ord("E");
//var button_K7		= _input.K7;		//ord("Q");
//var button_K8		= _input.K8;		//ord("F");
//var button_KPAUSE	= _input.KPAUSE;	//vk_escape;
//var button_KBACK	= _input.KBACK;		//vk_escape;



KUP		= _input.KUP;	 //keyboard_check( button_KUP	 );
KDOWN	= _input.KDOWN;	 //keyboard_check( button_KDOWN	 );
KLEFT	= _input.KLEFT;	 //keyboard_check( button_KLEFT	 );
KRIGHT	= _input.KRIGHT; //keyboard_check( button_KRIGHT	 );
K1		= _input.K1;	 //mouse_check_button( button_K1	 );
K2		= _input.K2;	 //mouse_check_button( button_K2	 );
K3		= _input.K3;	 //keyboard_check( button_K3		 );
K4		= _input.K4;	 //keyboard_check( button_K4		 );
K5		= _input.K5;	 //keyboard_check( button_K5		 );
K6		= _input.K6;	 //keyboard_check( button_K6		 );
K7		= _input.K7;	 //keyboard_check( button_K7		 );
K8		= _input.K8;	 //keyboard_check( button_K8		 );
KDASH	= _input.dash; //keyboard_check( button_KPAUSE	 );
KBACK	= _input.KBACK;	 //keyboard_check( button_KBACK	 );

KPUP	= _input.KUP_pressed;	//keyboard_check_pressed( button_KUP		); 
KPDOWN	= _input.KDOWN_pressed;	//keyboard_check_pressed( button_KDOWN		); 
KPLEFT	= _input.KLEFT_pressed;	//keyboard_check_pressed( button_KLEFT		); 
KPRIGHT	= _input.KRIGHT_pressed;//keyboard_check_pressed( button_KRIGHT		); 
K1P		= _input.K1_pressed;	//mouse_check_button_pressed( button_K1			); 
K2P		= _input.K2_pressed;	//mouse_check_button_pressed( button_K2			); 
K3P		= _input.K3_pressed;	//keyboard_check_pressed( button_K3			); 
K4P		= _input.K4_pressed;	//keyboard_check_pressed( button_K4			); 
K5P		= _input.K5_pressed;	//keyboard_check_pressed( button_K5			); 
K6P		= _input.K6_pressed;	//keyboard_check_pressed( button_K6			); 
K7P		= _input.K7_pressed;	//keyboard_check_pressed( button_K7			); 
K8P		= _input.K8_pressed;	//keyboard_check_pressed( button_K8			); 
KDASHP	= _input.dash_pressed;//keyboard_check_pressed( button_KPAUSE		); 
KPBACK  = _input.KBACK_pressed;	//keyboard_check_pressed( button_KBACK		); 

KQ0 = _input.quickswap_0;
KQ1 = _input.quickswap_1;
KQ2 = _input.quickswap_2;
KQ3 = _input.quickswap_3;
KQ4 = _input.quickswap_4;
KQ5 = _input.quickswap_5;



KRUP	= false;//keyboard_check_released( button_KUP		); 
KRDOWN	= false;//keyboard_check_released( button_KDOWN		); 
KRLEFT	= false;//keyboard_check_released( button_KLEFT		); 
KRRIGHT	= false;//keyboard_check_released( button_KRIGHT	 ); 
K1R		= false;//mouse_check_button_released( button_K1		 ); 
K2R		= false;//mouse_check_button_released( button_K2		 ); 
K3R		= false;//keyboard_check_released( button_K3		 ); 
K4R		= false;//keyboard_check_released( button_K4		 ); 
K5R		= false;//keyboard_check_released( button_K5		 ); 
K6R		= false;//keyboard_check_released( button_K6		 ); 
K7R		= false;//keyboard_check_released( button_K7		 ); 
K8R		= false;//keyboard_check_released( button_K8		 ); 
KRPAUSE	= false;//keyboard_check_released( button_KPAUSE	 ); 
KRBACK	= false;//keyboard_check_released( button_KBACK		); 

MX = _input.mx;
MY = _input.my;





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