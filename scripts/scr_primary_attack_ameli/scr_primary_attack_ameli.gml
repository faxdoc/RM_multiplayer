function scr_primary_attack_ameli() {
	
	if ( K1 ) {
		shoot_delay = 20;
	}
   if ( input_skip <= 0 ) {
    	if ( K1P ) {
    		shoot_press_buffer = 8;
    	} else if ( shoot_press_buffer > 0 ) {
    		shoot_press_buffer--;
    	}
    	if ( K1 ) {
    		shoot_hold_buffer = 8;
    	} else if ( shoot_hold_buffer > 0 ) {
    		shoot_hold_buffer--;
    	}	
    }
    	
    var k1_ = shoot_hold_buffer > 0;
    var k1p_ = shoot_press_buffer > 0;
    var i = 0; repeat(6) {
    	if ( RELOAD[i] > 0 )RELOAD[i]--;
    	i++;
    }
    
    
    if ( k1p_ && RELOAD[current_weapon] <= 0 ) {
        var children = [ orbs[ 0 ], orbs[ 1 ], orbs[ 2 ] ];
        var target_ = undefined;
        
        var i = 0; repeat( array_length(children) ) {
            if ( target_ == undefined && children[i].attack_state == e_ameli_orb_attack_state.idle ) target_ = children[i];
            i++;
        }
        if ( target_ != undefined ) {
            var target_attack_ = undefined;
            switch( current_weapon ) {
                case e_gun.pistol:  target_attack_ = e_ameli_orb_state.time_bomb;   break;
                case e_gun.flame:   target_attack_ = e_ameli_orb_state.trap;        break;
                case e_gun.shotgun: target_attack_ = e_ameli_orb_state.bomb;        break;
                case e_gun.grenade: target_attack_ = e_ameli_orb_state.anti_air;    break;
                case e_gun.sniper:  target_attack_ = e_ameli_orb_state.beam;        break;
                case e_gun.rail:    target_attack_ = e_ameli_orb_state.strike;      break;
            }
            
            if ( target_attack_ != undefined ) {
            	
            	shoot_delay = 30;
            	RELOAD[current_weapon] = 20;
                target_.state = target_attack_;
                switch(target_attack_) {//
                	case e_ameli_orb_state.time_bomb:	target_.attack_state = e_ameli_orb_attack_state.active;	 audio_play_sound_pitch( snd_ameli_cast_2, RR( 0.6, 0.7 ), RR(0.95,1.05), 0 ); ameli_arm_outer_state = e_ameli_arm_outer_state.casting;		ameli_arm_outer_timer = 11;break;
					case e_ameli_orb_state.trap:		target_.attack_state = e_ameli_orb_attack_state.passive; audio_play_sound_pitch( snd_ameli_cast_1, RR( 0.6, 0.7 ), RR(0.95,1.05), 0 ); ameli_arm_outer_state = e_ameli_arm_outer_state.holding_up;	ameli_arm_outer_timer = 11;break;
					case e_ameli_orb_state.bomb:    	target_.attack_state = e_ameli_orb_attack_state.active;	 audio_play_sound_pitch( snd_ameli_cast_2, RR( 0.6, 0.7 ), RR(0.95,1.05), 0 ); ameli_arm_inner_state = e_ameli_arm_inner_state.snap;		ameli_arm_inner_timer = 11;break;
					case e_ameli_orb_state.anti_air:	target_.attack_state = e_ameli_orb_attack_state.passive; audio_play_sound_pitch( snd_ameli_cast_0, RR( 0.6, 0.7 ), RR(0.95,1.05), 0 ); ameli_arm_inner_state = e_ameli_arm_inner_state.casting; 	ameli_arm_inner_timer = 11;break;
					case e_ameli_orb_state.beam:		target_.attack_state = e_ameli_orb_attack_state.active;	 audio_play_sound_pitch( snd_ameli_cast_1, RR( 0.6, 0.7 ), RR(0.95,1.05), 0 ); ameli_arm_outer_state = e_ameli_arm_outer_state.casting;		ameli_arm_outer_timer = 11;break;
					case e_ameli_orb_state.strike:		target_.attack_state = e_ameli_orb_attack_state.active;	 audio_play_sound_pitch( snd_ameli_cast_2, RR( 0.6, 0.7 ), RR(0.95,1.05), 0 ); ameli_arm_outer_state = e_ameli_arm_outer_state.explode;		ameli_arm_outer_timer = 11;break;
                }
                
                
                	// case : 
					// if ( ameli_arm_inner_timer-- <= 0 ) ameli_arm_inner_state = e_ameli_arm_inner_state.idle;
				// break;
				
                target_.target_x = MX;
                target_.target_y = MY;
                target_.target_state = target_attack_;
                shoot_press_buffer = 0;
                SHAKE++;
                
                with ( target_ ) {
                    repeat(4) {
        				var spd = 3+random_fixed(1);
        				var dir = random_fixed(360);
        				var fx = create_fx( x + LDX( 3,dir) + hsp, y + LDY( 3,dir) + vsp -6, sdot_wave, 0.3+random_fixed(0.4), 0, -110 );
        				fx.image_blend = main_blend;
        				fx.image_xscale = 2;
			            fx.image_yscale = 2;
        			}
                }


            }
        }
    }
    
}
// effect_create_depth( -40, ef_ring, MX, MY, 0, merge_colour( player_colour, c_gray, 0.4 ) );
