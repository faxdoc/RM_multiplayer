function scr_secondary_attack_ameli() {
	var mx_charge = 60;
	switch( maya_grenade_state ) {
		case 0:
			if ( knife_timer == 0 ) {
				knife_state = 0;
				knife_timer = 0;
				ameli_ranged_mode = !ameli_ranged_mode;
				
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
		            	shoot_delay = 17;
		            	RELOAD[0] = 17;
		                target_.state = target_attack_;
		                target_.attack_state = e_ameli_orb_attack_state.active;//ameli_ranged_mode ?  : e_ameli_orb_attack_state.active;
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
				// grenade_cooldown = 40;
			}
			if ( !K7 ) {
				maya_grenade_state = 1;
				knife_timer = min(floor(maya_grenade_charge),5);
			} else {
				shoot_delay = 5;
				var pre_charge = maya_grenade_charge;
				maya_grenade_charge = min( maya_grenade_charge + 1, mx_charge );
				if ( maya_grenade_charge != mx_charge ) {
					if ( maya_grenade_charge > 3 ) {
						var dr = random(360);
						if ( random( 1 ) > 0.6 ) {
							with (ICD(x+LDX(68,dr),y+LDY(68,dr),-1,ocharge_fx)) {
								target = other;
							}
						}
					}
				}
				
				if ( pre_charge != mx_charge && maya_grenade_charge == mx_charge ) {
					audio_play_sound_pitch( snd_splatter_1, RR( 0.6, 0.7 ) * 0.4, RR( 0.6, 0.7 ) * 1.3, 0 );
					SHAKE++;
					var size = 6,spd,fx,dir_;
					repeat(7) {
						spd = 3+random(1);
						dir_ = random(360);
						fx = create_fx( x + LDX(size*1.5,dir_) + hsp, y + LDY(size*1.5,dir_) + vsp -19, sdot_wave, .3+random(.4), 0, -110 );
						fx.image_blend = merge_color( c_gray, c_aqua, 0.3 + random( 0.5 ) );
					}
				}
			}
		break;
		case 1:
			knife_timer++;
			var ft_ = 1 + ( maya_grenade_charge / mx_charge );
			if ( knife_timer == 6 ) {
				audio_play_sound_pitch( snd_throw_grenade, RR( 0.9, 1 ) * 0.8, RR( 0.95, 1.1 ), 0 );
				var dmg_mult = 1;
				
				blink_state = 2;
				timer		= 20;
				var dr	= point_direction( x, y, MX, MY );
				var t	= ICD( x + draw_xscale * 16, y - 27, 0, par_hitbox );
				t.move_type = e_movetype.hvsp;
				t.hsp = LDX( 7, dr ) * 0.25 * ft_;
				t.vsp = LDY( 8, dr ) * 0.25 * ft_;
				t.custom_user = 0;
				t.grav = 0.09;
				t.sprite_index = sameli_page;
				t.duration = 43*ft_;
				t.angle_spin = ( 12 + random_fixed( 4 ) ) * choose_fixed( -1, 1 );
				t.draw_angle = random_fixed( 360 );
				t.dmg = 15;
				t.size_mult = 1;
				t.knockback *= 2.5;
				t.lag_add 	*= 4;
				t.shake_add	*= 3;
				t.mp_mult = 0;
				t.is_bullet = false;
				t.parent = id;
				t.stun_mult = 0.45;
				t.dir = point_direction(x,y,MX,MY);//-90;
				t.multihit = true;
				t.multihits_left = 6;
				t.image_xscale = 1.5;
				t.image_yscale = 1.5;
				t.image_index = irandom_fixed( 6 );
				
				
				with( t ) {
					var i = 32;
					var fc = 1;
					if ( instance_exists( oplayer ) ) fc = sign( oplayer.x - x );
					while( i > 0 && oplayer.gen_col( x, y ) ) {
						i--;
						x += fc;
					}
				}
				if ( tplace_meeting_walls( x, y + 1, layer_col ) ) hsp += 1.2 * draw_xscale;
			}
			if ( knife_timer > 20 ) {
				knife_state = 0;
				knife_timer = 0;
				grenade_cooldown = 40;
			}
				
		break;
	}
	
}

