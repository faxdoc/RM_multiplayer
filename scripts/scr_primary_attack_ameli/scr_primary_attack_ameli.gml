function scr_primary_attack_ameli() {

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
    
    
    if ( k1p_ ) {
        var children = [ orbs[ 0 ], orbs[ 1 ], orbs[ 2 ] ];
        var target_ = undefined;
        
        var i = 0; repeat( children ) {
            if ( target_ == undefined && children[i].state == e_ameli_orb_state.idle ) target_ = children[i];
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
                target_.state = e_ameli_orb_state.init;
                target_.target_x = MX;
                target_.target_y = MY;
                target_.target_state = target_attack_;
            }
        }
    }
    
}