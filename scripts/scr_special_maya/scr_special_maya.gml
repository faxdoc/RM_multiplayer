// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_special_maya(){
    #region Maya parry
		player_unactive_general(false);
		
		if ( active_timer == 0 ) {
			audio_play_sound_pitch( snd_blob_hit_wall, 0.3, 0.4, 0 );
			parry_duration = 15;
			draw_type = e_draw_type.animation;
			sprite_index = smaya_parry_into;
			image_index = 0;
			image_speed = 1;
		}
		active_timer++;
		
		if ( active_timer >= 30 ) {
			can_input	 = true;
			doing_active = false;
			audio_play_sound_pitch( snd_blob_hit_wall, 0.7, 0.7 + random( 0.1 ), 0 );
			state = e_player.normal;
			draw_type = e_draw_type.aiming;
		} else {
			can_input = false;
			
			if ( parry_duration > 0 ) {
				//if ( active_timer mod 5 == 4 ) {
					// flash += 3;
					// flash_col =  merge_color( dark_col, c_aqua, 0.5 );
				//}
				
				var ds_ = 999;
				var parry_hit = false;
				var t = instance_nearest( x, y, par_hitbox );
				if ( t && t.deal_damage && t.parent != id ) {
					ds_ = distance_to_object(t);
				}
				
				if ( t && ds_ < 5 ) {
					if instance_exists(own_grapple ) {
						with ( own_grapple ) {
							state = 2;
						}
					}
					
					can_hook_delay = 0;
					hook_air_cancel = 0;
					if ( state == e_player.hook ) {
						state = e_player.normal;
					}
					
					can_input		= true;
					doing_active	= false;
					audio_play_sound_pitch( snd_blob_hit_wall, 0.7, 0.7 + random( 0.1 ), 0 );
					hsp *= 0.8;
					if ( K3 || KUP ) {
						vsp = -6.0;
					} else {
					    vsp = -2;
					}
					maya_has_parry = true;
					space_buffer = true;
					
					INVIS = max( INVIS, 55 );
					
					SHAKE += 2.5;
					hit_timer = 35;
					
					audio_play_sound_pitch(			snd_maya_parry, 1,			RR(1,1.05),0);
				// 	audio_play_sound_pitch(			snd_maya_parry,0.7, 		RR(1,1.05)*0.9,0);
				// 	audio_play_sound_pitch(			snd_maya_start_hyper,0.7,	RR(1,1.05)*0.9,0);
				// 	audio_play_sound_pitch_falloff( snd_explotion_1,0.3,0.9+random(.15),4);
				// 	audio_play_sound_pitch_falloff( snd_explotion_1,0.3,0.9+random(.15),4);
				// 	audio_play_sound_pitch( 		snd_crystal_jump,		  1.30, 0.8 + random( 0.1 ),	7 );
					repeat( 36 ) {
						var dr = random(360);
						var len = 8+random(32*1.5);
						var eff = ICD( x+LDX(len,dr), y-21+LDY(len,dr),2,osmoke_fx);
						eff.dir = dr;
						eff.image_index = 0;
						eff.image_blend = c_aqua;
						eff.spd *= 2;
						
					}
					active_timer = 0;
					state = e_player.normal;
					draw_type = e_draw_type.aiming;
					parry_hit = true;
				} else {
					parry_duration--;
					if ( parry_duration <= 0 ) {
						if ( INVIS < 14 ) {
							INVIS = 0;
						}
					} else {
						INVIS = max(13,INVIS);
					}
				}
			}
		}
	#endregion
}
#region bot
#endregion
