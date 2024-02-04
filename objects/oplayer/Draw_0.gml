var hh =  KRIGHT-KLEFT;
var vv =  KDOWN-KUP;
var bwave, bmax =-1, bmin = 0, bdur = 4;

#region general effects

if ( !self_draw ) { exit; }
if ( state == e_player.hit ) {
	if ( hh != 0 || vv != 0 ) {
		var di_dir = point_direction(0,0,hh,vv);
		draw_sprite_ext(sdi_indicator,player_id,x,y-21,1,1,di_dir,c_dkgray, 1 ); 
		draw_sprite_ext(sdi_indicator,player_id,x,y-22,1,1,di_dir,c_white, 1 ); 
	}
}
draw_stats();
if ( hit_freeze ) {
	draw_sprite_ext(
		sprite_index,
		image_index,
		x+(hit_freeze mod 3),
		y+((hit_freeze+2) mod 3),
		draw_xscale,
		image_yscale,
		draw_angle,
		image_blend+hit_freeze/3,
		image_alpha
	);
	exit;
}

if ( flash ) gpu_set_fog( true, flash_col, -1, 0 );
#endregion

#region info render

var intcol_ =  merge_colour(c_ltgray, player_colour, 0.5 );
var fx_ = floor( x );
var fy_ = floor( y );
if (!grenade_cooldown && knife_state == 0 ) {
	draw_sprite_ext( splayer_grenade_silhouete, 0, fx_+12, fy_-48, 1, 1, 0, intcol_, 1 );
}
var intcol_ =  merge_colour(c_ltgray, player_colour, 0.5 );
draw_circle_colour(x-draw_xscale*2,y-29, 7, intcol_,intcol_, false );
draw_circle_colour(x-draw_xscale*2,y-29, 9, intcol_,intcol_, true );
draw_circle_colour(x-draw_xscale*2,y-29, 9.5, intcol_,intcol_, true );
draw_circle_colour(x-draw_xscale*2,y-29, 10, intcol_,intcol_, true );


shader_set(shd_palette);
	shader_set_uniform_f( main_shader_pal_index_pointer, player_id );
	texture_set_stage( shader_get_sampler_index(shd_palette, "palette" ), sprite_get_texture(spalette_player_1,0) );
if ( palette_init ) {	
	var palette_sprite = spalette_player_1; var uvs = sprite_get_uvs(spalette_player_1,0);
	shader_set_uniform_f(	    main_shader_col_num_pointer,   sprite_get_height(palette_sprite)  );
	shader_set_uniform_f(	    main_shader_pal_num_pointer,   sprite_get_width(palette_sprite) );
	shader_set_uniform_f_array( main_shader_uvs_pointer,	   [uvs[0],uvs[1],uvs[2]-uvs[0],uvs[3]-uvs[1]]  );
}

shader_reset();

#endregion

switch(char_index) {
	case e_char_index.fern:
		scr_player_draw_fern();
	break;
	case e_char_index.maya:
		scr_player_draw_maya();
	break;
	case e_char_index.ameli:
		scr_player_draw_ameli();
	break;
}

