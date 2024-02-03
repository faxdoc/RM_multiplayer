function random_range_fixed(x_,y_) {
	orandom.random_array_index = (orandom.random_array_index+1) mod (array_length(orandom.random_array)-1);
	return lerp(x_,y_,orandom.random_array[orandom.random_array_index]);
}
function irandom_range_fixed(x_,y_) {
	orandom.random_array_index = (orandom.random_array_index+1) mod (array_length(orandom.random_array)-1);
	return floor(lerp(x_,y_,orandom.random_array[orandom.random_array_index]));
}

function random_fixed(x_) {
	orandom.random_array_index = (orandom.random_array_index+1) mod (array_length(orandom.random_array)-1);
	return x_*orandom.random_array[orandom.random_array_index];
}

function irandom_fixed(x_) {
	orandom.random_array_index = (orandom.random_array_index+1) mod (array_length(orandom.random_array)-1);
	return floor( x_*orandom.random_array[orandom.random_array_index] );
}
function choose_fixed() {
	return argument[0];
}


function scr_gun_code() {
var bullet_sprites = [ sbullet_lime, sbullet_big_lime, sbullet_2_lime,	sbullet_big_alt_lime, sbullet_1_lime,	sbullet_saw_player_lime	];

if (K1P) {
	shoot_press_buffer = 8;
} else if ( shoot_press_buffer > 0 ) {
	shoot_press_buffer--;
}//
var cg		= current_weapon;
var k1_		= K1 || shoot_press_buffer;
var k1p_	= shoot_press_buffer > 0;

//var pre_reload = RELOAD[cg];
var i = 0; repeat(weapon_number) {
	if (RELOAD[i] > 0 )RELOAD[i] = max(0,RELOAD[i]-1.5);
	i++;
}
//if( cg == e_gun.shotgun && pre_reload > 0 && RELOAD[cg] <= 0 )audio_play_sound_pitch( snd_shotgun_reload, .35, RR(.95,1.2), -1 );

if ( CLIP[cg] != 99 ) {
	if( CLIP[cg] == 0 ){
		if( K1P ) audio_play_sound_pitch( snd_shoot_no_bullets, RR(.8,1),RR(.95,1.1),-1);
		k1_ = false;
		k1p_ = false;
	}
} else { 
	if ( RELOAD[cg] > 0 ) {
		if k1p_ audio_play_sound_pitch( snd_shoot_no_bullets, RR(.8,1),RR(.95,1.1),-1);
		k1_  = false;
		k1p_ = false;
	}
}

if ( knife_state == 1 || input_skip > 0 ) {
	k1_ = false; k1p_ = false;
	shoot_press_buffer = 0;
}
var charge_mult = 1;

if ( doing_active ) exit;
 
switch(current_weapon) {
	
	#region rifle
	case e_gun.pistol:
		gun_len = 32;
		
		
		#region v2
		CLIP[cg] = clamp( CLIP[cg], 0, 4 );
		if( RELOAD[cg] <= 0 )CLIP[cg] = 5;
		if( CLIP[cg] == 0 )gun_charge = 0;
		
		if ( gun_charge <= 0 ) {
			if( k1p_ )gun_charge = 1;
		}
		//LOG(gun_charge)
		if ( gun_charge > 0 ) {
			if( round(gun_charge) mod 4 == 1 ) {
				gun_general(10,60,9);
				var b = bullet_general(4.9,19,bullet_sprites[0],0);
				b.duration *= 1.12;
				scr_set_size(b,0.9);
				bullet_effects_general(sammo);
				effect_general(0.7,4,2);
				audio_play_sound_pitch( snd_railgun_shooting, 0.5, 0.9 + random_fixed( 0.1 ), 1 );
				CLIP[cg]--;
				RELOAD[cg] = 96;
				shoot_delay = 15;
			}
					
			gun_charge++;
		}
		#endregion
		
	break;
	#endregion
	
	#region shotgun
	case e_gun.shotgun:
		gun_charge = 0;
		CLIP[cg] = clamp(CLIP[cg],0,2);
		if( RELOAD[cg] <= 0 ) CLIP[cg] = 2;
		
		if( CLIP[cg] == 0 ){
			if k1p_ audio_play_sound_pitch( snd_shoot_no_bullets, RR(.8,1),RR(.95,1.1),-1);
			exit;
		}
			if ( k1p_ ) {
				shoot_press_buffer = 0;
				if ( CLIP[cg] == 2 ) {
					var dr = point_direction(x,y-gun_height,MX,MY);
					var hpwr_e = max(0, 1.7-abs(hsp) );
					var vpwr_e = max(0, 1.7-abs(vsp) );

					var hpwr = ( .62 ) * 1.1;
					var vpwr = ( .9  ) * 1.1;
					
					var dr_check_y = LDY(3,dr);
					hsp -= LDX( (2+hpwr_e)*hpwr,dr );
					if( !gen_col(x,y+1) ){
						if( sign(vsp) != sign(dr_check_y) ){
							vsp -= LDY((2+vpwr_e)*vpwr,dr);
						} else {
							vsp = -LDY(3*vpwr,dr);
						}
					}
				}
				//repeat(2) {
					audio_play_sound_pitch( snd_railgun_shooting, 0.8, 0.95 + random_fixed( 0.1 ), 1 );
					audio_play_sound_pitch( snd_shoot_1, 0.25, 0.85+random_fixed( 0.1 ), 1 );
				//}
				gun_fully_charged = true;
				gun_charge = 20;
				if ( charge_sound != -1 ) {
					audio_stop_sound(charge_sound);
					charge_sound = -1;
				}
				gun_len = 28;
				var i = 0;
				repeat(4) {
					var b = bullet_general( 4, 51, !gun_fully_charged ? bullet_sprites[0] : bullet_sprites[2], 6 );
					b.frc = 0.8;
					b.duration = 15 + ( i++ / 1.5 );
					b.spd *=       0.30;
					b.spd += ( gun_charge / 14 );
					b.spd *=       1.32;
					b.knockback *= 0.95;
				}
				
				bullet_effects_general( undefined );
				bullet_effects_general( undefined );
				effect_general( 1, 9, 3 );
				
				gun_charge  =  0;
				shoot_delay = 40;
				gun_fully_charged = false;
				if ( CLIP[cg] == 2 ) {
					RELOAD[cg] = 120;
				}
				CLIP[cg]--;
			}
	break; 
	#endregion
	
	#region rail
	case e_gun.rail:
		var max_ammo = 19;
		var charge_cap = 24;
		if( RELOAD[cg] <= 0 )CLIP[cg] = max_ammo;
		if( CLIP[cg] == 0 ) {
			if( k1p_ )audio_play_sound_pitch( snd_shoot_no_bullets, RR(.8,1),RR(.95,1.1),-1);
			shoot_delay = 0;
			gun_charge = 0;
			exit;
		}
		//LOG_NUMBER("fully_charged: ", gun_fully_charged );
		gun_len = 30;		
		if( K1 ) {
			if( gun_charge == 0 ){
				audio_play_sound_pitch(snd_railgun_charge,.75,.85,0);
			}
			shoot_delay = 6;
			gun_charge++;
			if( gen_col(x,y+1) ) hsp *= 0.92;
			gun_col = merge_color( c_black, c_orange, gun_charge/22 );
			if ( gun_charge > 40 ) gun_fully_charged = true;
		} else {
			gun_fully_charged = false;
			gun_charge = 0;
			if (charge_sound != -1) {
				audio_stop_sound(charge_sound);
				charge_sound = -1;
			}
			bullet_spread_index = 0;
		}
		if ( gun_charge == charge_cap ) {
			if ( charge_sound != -1 ) {
				audio_stop_sound(charge_sound);
				charge_sound = -1;
			}
			//repeat( 2 ) 
			audio_play_sound_pitch(snd_shoot_0,0.55,0.95+random_fixed(.1),1);
			//
			audio_play_sound_pitch( snd_railgun_charge_done, 1, .9, 0 );
			y -= 20;
			repeat( 5 ) MAKES( ospark_alt );
			y += 20;
		}
		#macro MAKES create_at_self
		if ( gun_charge < charge_cap || !K1 ) exit;
		
		if ( gun_charge mod 5 == 0 ) {
			if ( gun_fully_charged ) {
				audio_play_sound_pitch( snd_shoot_1, 0.85, 1.15 + random_fixed( 0.1 ),1);
				audio_play_sound_pitch( snd_shoot_2, 0.75, 1.35 + random_fixed( 0.1 ),1);
			} else {
				audio_play_sound_pitch( snd_shoot_1, 0.75, 1.00 + random_fixed( 0.1 ),1);
				audio_play_sound_pitch( snd_shoot_2, 0.65, 1.15 + random_fixed( 0.1 ),1);
			}
			//gun_general(4,60,9);
			var b = bullet_general( (gun_fully_charged ? 9 : 6)*0.35,30, gun_fully_charged ? sbullet_bolt_white : sbullet_bolt,0);
			b.duration = 8;
			b.mp_mult =  0;
		
			var unacc_array = [0,.3,-0.2,0.5,0.1,-0.6,1,0.4,-0.7,-1,-0.3,0.4,-0.2];
			bullet_spread_index = (bullet_spread_index+1) mod ( array_length(unacc_array)-2 );
			var current_unacc = unacc_array[bullet_spread_index];
			b.dir += current_unacc*2;
			
			b.delete_on_wall_col = false;
			bullet_effects_general( sammo_red );
			effect_general( 0.6, 3, 4 );
			if ( CLIP[cg] == max_ammo ) {
				RELOAD[cg] = 900;
			}
			CLIP[cg]--;
		}
		
		
	break; 
	#endregion
	
	#region rocket
	case e_gun.grenade:
		gun_charge = 0;
		var dmg_mult = 1;
		var mp_mult = 1;
		CLIP[cg] = clamp(CLIP[cg],0,1);
		if( RELOAD[cg] <= 0 )CLIP[cg] = 1;
		
		if( CLIP[cg] == 0 ){
			if k1p_ audio_play_sound_pitch( snd_shoot_no_bullets, RR(.8,1),RR(.95,1.1),-1);
			exit;
		}
		
		if ( k1p_ ) {
			shoot_press_buffer = 0;
			gun_charge = 30;
			gun_len = 14;
			var drr = point_direction(x,y-gun_height,MX,MY);
			var xx = x+LDX(gun_len*0.3,drr);
			var yy = y-gun_height+LDY(gun_len*0.3,drr);

			var t = ICD( xx, yy, -1, ogrenade );
			t.bounce = 0.9;
			t.hsp = LDX(7+gun_charge/5,drr) * 0.82 * 0.92;
			t.vsp = LDY(7+gun_charge/5,drr) * 0.82 * 0.92;
			t.grav = 0;
			//t.duration *= 0.96;//0.96*1.05;
			t.explode_on_ground = true;
			t.explotion_size = 1;
			t.explode_on_contact = true;
			t.push_player = true;
			t.duration = 13;
			t.explode_damage = 22*dmg_mult;
			t.sprite_index = srocket_alt;
			t.spin = 0;
			t.draw_angle = drr;
			t.mp_mult = mp_mult;
			t.parent = id;
			
				
			audio_play_sound_pitch( snd_railgun_shooting,0.8,  0.85 + random_fixed( 0.1 ), 1 );
			audio_play_sound_pitch( 		 snd_shoot_1,0.25, 0.75 + random_fixed( 0.1 ), 1 );
						
			CLIP[cg]--;
			RELOAD[cg] = 135;
			effect_general(3,12,6);
			//gun_general(70,90,2);
			gun_charge = 0;
			shoot_delay = 40;
				
		}
		
		
	break;
	#endregion
	
	#region sniper 
	case e_gun.sniper:
		if ( gun_charge ) {
			var max_charge = 60;
			var pre_charge = gun_charge;
			gun_charge += 1.15;
			gun_charge = min(gun_charge,max_charge);
			if ( gun_charge == max_charge && pre_charge != max_charge ) {
				audio_play_sound_pitch( snd_reload_1,			0.9, 0.85, 0 );
				audio_play_sound_pitch( snd_railgun_charge_done,  1, 0.9,  0 );
				gun_fully_charged = true;
				if ( charge_sound != -1 ) {
					audio_stop_sound(charge_sound);
					charge_sound = -1;
				}
				//audio_play_sound_pitch(snd_reload_1,.6,.9,0);
				SHAKE += 2;
				repeat(7) {
					var spd = 3+random_fixed(1);
					var _dir = random_fixed(360);
					var	fx = create_fx( x + hsp, y + vsp -20, sdot_wave, .6+random_fixed(.7), 0, -110 );
					fx.image_blend = merge_color(dark_col,choose_fixed(c_blue,c_aqua),.2+random_fixed(.2));
					fx.hsp = LDX(spd,_dir);
					fx.vsp = LDY(spd, _dir);
					fx.frc = .9;
				}
			}
			if ( gun_charge < max_charge )&& random_fixed(1) < max( .1, gun_charge/140 ) {
				var dr = random_fixed(360);
				var ld_ = id;
				with ICD( x+LDX(20+gun_charge,dr), y-20+LDY(20+gun_charge,dr), depth+RR(-1,1), ocharge_fx ) {
					image_blend = choose_fixed(c_ltgray,c_aqua);
					target_offset_y = -16;
					target = ld_;
				}
			}
			
			if ( gun_charge > 2 ) {
				shoot_delay = 5;
				hsp *= .84;
			}
			
			if ( !K1 ) {
				gun_len = 50;
				effect_general(3,12,6);
				gun_general(50,90,2);
				var cmult = gun_fully_charged ? 1.1 : 0.85;
				var b = bullet_general(gun_charge*0.85*cmult,49,bullet_sprites[0],0,, 0.96 );
				b.duration		= 30;
				b.image_xscale  = ( gun_charge + 15 ) / 12 * cmult;
				b.image_yscale  = ( gun_charge + 15 ) / 90 * cmult;
				b.mp_mult		= 0;
				b.piercing = true;
				b.lag_add   *= (cmult*2.5);
				b.shake_add *= (cmult*2.5);
				b.step_number = 3;
				b.spd *= 0.33;
				b.stun_mult *= 0.1;
				
				var dr = point_direction(x,y-gun_height,MX,MY);
				hsp -= LDX( gun_charge*cmult*  0.05, dr );
				vsp -= LDY( gun_charge*cmult* 0.033, dr );
				
				bullet_effects_general(undefined);
				gun_charge = -1;
				RELOAD[cg] = 135;
				audio_play_sound_pitch(snd_shoot_0,0.95, 1.05+random_fixed(.1), 1 );
				audio_play_sound_pitch(snd_shoot_2, 0.4,  .95+random_fixed(.1), 1 );
				if ( charge_sound != -1 ) {
					audio_stop_sound(charge_sound);
					charge_sound = -1;
				}
				
			}
			RELOAD[current_weapon] = 135;
		} else {
			//var needed_ = sniper_cost;
			//if ( !k1_ && !SHOOT_BUFFER ) exit; 
			//if ( MP < needed_ ) {
				//if ( k1p_ ) {
				//	shoot_press_buffer = 0;
				//	//audio_play_sound_pitch(snd_menu_error,.7,.8,1);
				//	var tll = ICD(oplayer.x,oplayer.y-39,oplayer.depth+1,otext_up);
				//	tll.str = "[smp_low]";
				//	tll.base_col = c_white;
				//	tll.back_col = c_darkest;
				//	//audio_play_sound_pitch( snd_shoot_no_bullets, RR(.8,1),RR(.95,1.1),-1);
				//}
			//} else {
			if ( K1 && RELOAD[current_weapon] <= 0 ) {
				gun_charge = 1;
				gun_fully_charged = false;
				shoot_delay = 0;
				RELOAD[current_weapon] = 135;
			}
			
			//MP -= needed_;
			//charge_sound = audio_play_sound_pitch( snd_railgun_charge,.75,.85,0);
			//}
		}
		
	break; 
	#endregion
	
	#region pistol
	case e_gun.flame:
	
		#region pistol v2
		CLIP[cg] = clamp(CLIP[cg],0,1);
		if( RELOAD[cg] <= 0 )CLIP[cg] = 1;
		gun_fully_charged = false;
		if ( CLIP[cg] == 0 ) {
			gun_charge = 0;
			exit;
		}
			
		if ( k1p_ && gun_charge <= 0 ) {
			shoot_press_buffer = 0;
			gun_len = 22;
			var drr = point_direction( x, y - gun_height, MX, MY );
			var xx = x+LDX( gun_len, drr );
			var yy = y - gun_height + LDY( gun_len, drr );
			
			var spr_ = sbullet_saw_player_aqua;
			switch(player_id) {
				default: spr_ = sbullet_saw_player_aqua;  break;
				case 1:  spr_ = sbullet_saw_player_red;   break;
				case 2:  spr_ = sbullet_saw_player_lime;  break;
				case 3:  spr_ = sbullet_saw_player_white; break;
				
			}
			var b = bullet_general( 2, 20, spr_, 0, ohitbox_saw );//
			b.duration			*=  40;
			b.frc				= 0.85;
			b.fully_charged		= true;
			b.multihit			= true;
			b.dir_angle_spin	= RR( 7, 8 );
			b.bounces = true;
			b.hsp				= LDX( b.spd*0.2, b.dir );
			b.vsp				= LDY( b.spd*0.2, b.dir );
			b.can_bounce_delay  = 12;
				
			scr_set_size( b, 1 );
			shoot_delay = 20;
				
			bullet_effects_general( sammo_small );
				
			//audio_play_sound_pitch( snd_railgun_shooting, 0.8, 0.85 + random_fixed(0.1), 1 );
			audio_play_sound_pitch( snd_railgun_shooting, 0.8, 0.85 + random_fixed(0.1), 1 );
			audio_play_sound_pitch( choose(snd_pistol_shot_0,snd_pistol_shot_1), RR(0.85,0.95), 0.95 + random_fixed( 0.1 ), 1 );
						
			CLIP[cg]--;
			effect_general(3,12,6);
			//gun_general(220,90,2);
			RELOAD[cg] = 320;
			shoot_delay = 30;
				
		}
		#endregion
		
		
		
	break;
	#endregion
	
}


}



function create_at_0(obj) {
	return ICD(0,0,0,obj);
}
function create_at_self(obj) {
	return ICD(x,y,0,obj);
}
function create_at_self_depth(obj,depth_ = depth) {
	return ICD(x,y,depth_,obj);
}

function create_fx(x_, y_, sprite_, speed_, angle_, depth_) {
	var e_ = instance_create_depth(x_,y_,depth_,ofx);
	e_.sprite_index = sprite_;
	e_.image_speed = speed_;
	e_.image_angle = angle_;
	return e_;
}
function create_fx_call(x_, y_, sprite_, speed_, angle_, depth_) {
	var e_ = instance_create_depth(x_,y_,depth_,ofx_caller);
	e_.sprite_index = sprite_;
	e_.image_speed = speed_;
	e_.image_angle = angle_;
	e_.call_index = id;
	return e_;
}

function bullet_effects_general( shell, target_x = MX, target_y = MY ) {
	if ( object_index == oplayer ) {
		var cr = crouching;
		var drr = point_direction(x,y-gun_height,target_x,target_y);
	} else {
		var cr = false;
		var drr = aim_dir;
	}
	var xx = x+LDX(gun_len,drr);
	var yy = y-gun_height+LDY(gun_len,drr)+( cr ? 4 : 0 );
	create_fx(xx,yy,sgun_blink_2,1,drr,0);
	ICD(xx,yy,0,osmoke);
	ICD(xx,yy,0,osmoke);
	if ( shell != undefined ) {
		var xx_ = x			  +LDX(gun_len*0.3,drr);
		var yy_ = y-gun_height+LDY(gun_len*0.3,drr)+( cr ? 4 : 0 );
		var b = ICD(xx_,yy_,depth,oblood);
		b.vsp = -3-random_fixed(4);
		b.hsp *= .5;
		b.sprite_index = shell;
	}
	
	
}

function bullet_general(dmg,spd,sprite, unacc, obj_ = par_hitbox, cb_mult_ = 1, target_x = MX, target_y = MY) {
	var dmg_mult = 1;
	var mp_mult  = 1;
	
	
	var drr = point_direction( x, y-gun_height, target_x, target_y ) + random_range_fixed( -unacc, unacc );
	var xx = x				+ LDX( gun_len*0.1, drr );
	var yy = y-gun_height	+ LDY( gun_len*0.1, drr ) + ( crouching ? 5 : 0 );
	
	var cb_ =  0.055;
	hsp -= LDX( min( dmg, 30 ) * cb_ * cb_mult_, drr );
	vsp -= LDY( min( dmg, 30 ) * cb_ * cb_mult_, drr );
	
	var t = ICD( xx, yy, 1, obj_ );
	t.spd = spd;
	t.dir = drr;
	t.dmg = dmg*dmg_mult;
	t.duration = 6;
	t.image_angle = drr;
	t.sprite_index = sprite;
	t.mp_mult *= mp_mult;
	t.parent = id;
	
	switch(current_weapon) {
		case e_gun.shotgun:
			t.knockback = dmg * 1.1;
			t.stun_mult = 1.6;
			t.spd *= 1.4;
			t.duration *= 0.93;
			t.damage_mult = 1.4;
		break;
		case e_gun.sniper:
			t.knockback = dmg * 0.05;
			t.stun_mult = dmg * 0.05;
		break;
		case e_gun.flame:
			t.knockback = dmg * 1;
			t.stun_mult = 1.3;
		break;
		default:
			t.knockback = dmg * 1;
		break;
		case e_gun.pistol:// gun 1
			t.stun_mult = 1.1;
			t.knockback *= 1.2;
			t.bonus_vsp = -0.3;
		break;
		case e_gun.rail:
			t.stun_mult = 2.6;
			t.knockback *= 2.1;
		break;
		
	}
	
	return t;
	
}

function gun_general(RELOAD_set,clip_set,clip_size) {
	SHOOT_BUFFER = false;
    var cg = current_weapon;
    RELOAD[cg] = RELOAD_set;
}

enum e_movetype {
	vector,
	melee,
	hvsp,
}

function scr_set_size(target,size) {
	target.image_xscale = size;
	target.image_yscale = size;
	
}

function effect_general(shake_,recoil_,camera_recoil_, target_x = MX, target_y = MY) {
	var drr = point_direction( x, y - gun_height, target_x, target_y );
	SHAKE += shake_;
	recoil = recoil_;
	gun_col = c_orange;
	blink_state = 2;
	timer = 17;
	//CAMX -= LDX(camera_recoil_,drr)*SHAKE_MULT;
	//CAMY -= LDY(camera_recoil_,drr)*SHAKE_MULT;
	//var hpush = recoil_ * .13;
	//var vl = hair.vertex;
	//var vert = vl[hair.number-2];
	//vert.oldx += LDX(hpush,drr);
	//vert.oldy += LDY(hpush,drr);
	//var vl = hair.vertex;
	//var vert = vl[hair.number-4];
	//vert.oldx += LDX(hpush,drr);
	//vert.oldy += LDY(hpush,drr);
	//var vl = hair.vertex;
	//var vert = vl[hair.number-6];
	//vert.oldx += LDX(hpush,drr);
	//vert.oldy += LDY(hpush,drr);
	//var vl = hair.vertex;
	//var vert = vl[hair.number-8];
	//vert.oldx += LDX(hpush,drr);
	//vert.oldy += LDY(hpush,drr);
}

function angle_approach(angle,target_angle,turn_speed) {
	var tempdir;
	var diff = abs(target_angle-angle);
	if (diff > 180){
	    if (target_angle > 180){
	        tempdir = target_angle - 360;
	        if (abs(tempdir-angle ) > turn_speed){
	            angle -= turn_speed;
	        }else{
	            angle = target_angle;
	        }
	    }else{
	        tempdir = target_angle + 360;
	        if (abs(tempdir-angle) > turn_speed){
	            angle += turn_speed;
	        }else{
	            angle = target_angle;
	        }
	    }
	}else{
	    if (diff > turn_speed){
	        if (target_angle > angle){
	            angle += turn_speed;
	        }else{
	            angle -= turn_speed;
	        }
	    }else{
	        angle = target_angle;
	    }
	}
	return angle;
}

function get_angle_at_player() { return instance_exists(oplayer)?point_direction(x,y,oplayer.x,player_mid_y) : 0; }

 
#macro dark_col c_dkgray

#macro blend_add	gpu_set_blendmode(bm_add)
#macro blend_normal gpu_set_blendmode(bm_normal)
#macro DSA			draw_set_alpha
#macro RR			random_range_fixed

#macro LDX lengthdir_x
#macro LDY lengthdir_y

