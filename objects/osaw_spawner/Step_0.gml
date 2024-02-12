if !cooldown && ( personal_saw == undefined || !instance_exists(personal_saw) ) {
	personal_saw = ICD(x,y,0,par_hitbox);
	personal_saw.duration = 60;
	personal_saw.spd = 0;
	personal_saw.ghost = true;
	personal_saw.dir_angle_spin = 12;
	personal_saw.hsp = 0;
	personal_saw.vsp = 0;
	personal_saw.sprite_index = sbullet_saw_player_red;
	personal_saw.image_xscale = 2;
	personal_saw.image_yscale = 2;
	personal_saw.parent = other_player;
	personal_saw.dir = 96;
	personal_saw.knockback *= 1.9;
	personal_saw.stun_mult *= 4;
	personal_saw.alt_t_knockback = false;
	cooldown = 10;
	
	//if instance_exists(other_player) {
	//var b_;
	//with ( other_player ) {
	//	b_ = bullet_general(1,0,sbullet_saw_player_red,0);
	//}
	//b_.x = x;
	//b_.y = y;
	//personal_saw = b_;
	//}
}
if ( cooldown ) {
	cooldown--;
}


if ( !instance_exists(other_player) ) {
	var d;
	with ( oplayer ) {
		if ( player_id == 1 ) d = id;
	}
	other_player = d;

}
