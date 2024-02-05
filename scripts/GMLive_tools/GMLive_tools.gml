// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.
// Feather disable all

// Most of the functions that you are actually supposed to touch are here
#region live

if (live_enabled) 
function live_set_live_impl(l_thing, l_val, l_map, l_start, l_stop) {
	// live_set_live_impl(thing:T, val:V, map:ds_map<T; V>, start:ds_list<T>, stop:ds_list<T>)
	/// @ignore
	var l_i;
	if (l_val != undefined) {
		var l_cur = ds_map_find_value(l_map, l_thing);
		if (l_cur == undefined) {
			ds_map_set(l_map, l_thing, l_val);
			l_i = ds_list_find_index(l_stop, l_thing);
			if (l_i >= 0) ds_list_delete(l_stop, l_i);
			ds_list_add(l_start, l_thing);
		} else if (l_cur != l_val) {
			ds_map_set(l_map, l_thing, l_val);
			l_i = ds_list_find_index(l_stop, l_thing);
			if (l_i < 0) ds_list_add(l_stop, l_thing);
			l_i = ds_list_find_index(l_start, l_thing);
			if (l_i < 0) ds_list_add(l_start, l_thing);
		}
	} else {
		if (!ds_map_exists(l_map, l_thing)) exit;
		l_i = ds_list_find_index(l_start, l_thing);
		if (l_i >= 0) ds_list_delete(l_start, l_i);
		ds_list_add(l_stop, l_thing);
	}
}

if (live_enabled) 
function live_set_live_simple(l_thing, l_val, l_map, l_start, l_stop) {
	// live_set_live_simple(thing:T, val:bool, map:ds_map<T; bool>, start:ds_list<T>, stop:ds_list<T>)
	/// @ignore
	var l_val1 = (l_val ? true : undefined);
	var l_i;
	if (l_val1 != undefined) {
		var l_cur = ds_map_find_value(l_map, l_thing);
		if (l_cur == undefined) {
			ds_map_set(l_map, l_thing, l_val1);
			l_i = ds_list_find_index(l_stop, l_thing);
			if (l_i >= 0) ds_list_delete(l_stop, l_i);
			ds_list_add(l_start, l_thing);
		} else if (l_cur != l_val1) {
			ds_map_set(l_map, l_thing, l_val1);
			l_i = ds_list_find_index(l_stop, l_thing);
			if (l_i < 0) ds_list_add(l_stop, l_thing);
			l_i = ds_list_find_index(l_start, l_thing);
			if (l_i < 0) ds_list_add(l_start, l_thing);
		}
	} else if (ds_map_exists(l_map, l_thing)) {
		l_i = ds_list_find_index(l_start, l_thing);
		if (l_i >= 0) ds_list_delete(l_start, l_i);
		ds_list_add(l_stop, l_thing);
	}
}

function sprite_set_live(l_spr, l_live1) {
	/// sprite_set_live(spr:sprite, live:bool)
	/// @param {sprite} spr
	/// @param {bool} live
	/// @returns {void}
	if (live_enabled) {
		var l_map = live_live_sprites;
		var l_start = live_live_sprites_start;
		var l_stop = live_live_sprites_stop;
		var l_val = (l_live1 ? true : undefined);
		var l_i;
		if (l_val != undefined) {
			var l_cur = ds_map_find_value(l_map, l_spr);
			if (l_cur == undefined) {
				ds_map_set(l_map, l_spr, l_val);
				l_i = ds_list_find_index(l_stop, l_spr);
				if (l_i >= 0) ds_list_delete(l_stop, l_i);
				ds_list_add(l_start, l_spr);
			} else if (l_cur != l_val) {
				ds_map_set(l_map, l_spr, l_val);
				l_i = ds_list_find_index(l_stop, l_spr);
				if (l_i < 0) ds_list_add(l_stop, l_spr);
				l_i = ds_list_find_index(l_start, l_spr);
				if (l_i < 0) ds_list_add(l_start, l_spr);
			}
		} else if (ds_map_exists(l_map, l_spr)) {
			l_i = ds_list_find_index(l_start, l_spr);
			if (l_i >= 0) ds_list_delete(l_start, l_i);
			ds_list_add(l_stop, l_spr);
		}
	}
}

function path_set_live(l_pt, l_live1) {
	/// path_set_live(pt:path, live:bool)
	/// @param {path} pt
	/// @param {bool} live
	/// @returns {void}
	if (live_enabled) {
		var l_map = live_live_point_paths;
		var l_start = live_live_point_paths_start;
		var l_stop = live_live_point_paths_stop;
		var l_val = (l_live1 ? true : undefined);
		var l_i;
		if (l_val != undefined) {
			var l_cur = ds_map_find_value(l_map, l_pt);
			if (l_cur == undefined) {
				ds_map_set(l_map, l_pt, l_val);
				l_i = ds_list_find_index(l_stop, l_pt);
				if (l_i >= 0) ds_list_delete(l_stop, l_i);
				ds_list_add(l_start, l_pt);
			} else if (l_cur != l_val) {
				ds_map_set(l_map, l_pt, l_val);
				l_i = ds_list_find_index(l_stop, l_pt);
				if (l_i < 0) ds_list_add(l_stop, l_pt);
				l_i = ds_list_find_index(l_start, l_pt);
				if (l_i < 0) ds_list_add(l_start, l_pt);
			}
		} else if (ds_map_exists(l_map, l_pt)) {
			l_i = ds_list_find_index(l_start, l_pt);
			if (l_i >= 0) ds_list_delete(l_start, l_i);
			ds_list_add(l_stop, l_pt);
		}
	}
}

function animcurve_set_live(l_curve_id, l_live1, l_bezierIterations) {
	/// animcurve_set_live(curve_id:animcurve, live:bool, bezierIterations:int = 16)
	/// @param {animcurve} curve_id
	/// @param {bool} live
	/// @param {int} [bezierIterations=16]
	/// @returns {void}
	if (l_bezierIterations == undefined) l_bezierIterations = 16;
	if (false) show_debug_message(argument[2]);
	if (live_enabled) {
		var l_val = (l_live1 ? l_bezierIterations : undefined);
		var l_map = live_live_anim_curves;
		var l_start = live_live_anim_curves_start;
		var l_stop = live_live_anim_curves_stop;
		var l_i;
		if (l_val != undefined) {
			var l_cur = ds_map_find_value(l_map, l_curve_id);
			if (l_cur == undefined) {
				ds_map_set(l_map, l_curve_id, l_val);
				l_i = ds_list_find_index(l_stop, l_curve_id);
				if (l_i >= 0) ds_list_delete(l_stop, l_i);
				ds_list_add(l_start, l_curve_id);
			} else if (l_cur != l_val) {
				ds_map_set(l_map, l_curve_id, l_val);
				l_i = ds_list_find_index(l_stop, l_curve_id);
				if (l_i < 0) ds_list_add(l_stop, l_curve_id);
				l_i = ds_list_find_index(l_start, l_curve_id);
				if (l_i < 0) ds_list_add(l_start, l_curve_id);
			}
		} else if (ds_map_exists(l_map, l_curve_id)) {
			l_i = ds_list_find_index(l_start, l_curve_id);
			if (l_i >= 0) ds_list_delete(l_start, l_i);
			ds_list_add(l_stop, l_curve_id);
		}
	}
}

function file_set_live(l_path1, l_callback, l_kind) {
	/// file_set_live(path:string, ?callback:function<any;string;void>, ?kind:string)
	/// @param {string} path
	/// @param {function<any;string;void>} ?callback
	/// @param {string} ?kind
	/// @returns {void}
	if (false) show_debug_message(argument[2]);
	if (live_enabled) {
		var l_i;
		if (l_callback != undefined) {
			if (ds_map_exists(live_live_included_files, l_path1)) exit;
			var l_k;
			if (l_kind == undefined) {
				switch (string_lower(filename_ext(l_path1))) {
					case ".csv": l_k = 4; break;
					case ".json": l_k = 2; break;
					case ".txt": l_k = 1; break;
					case ".bin": l_k = 0; break;
					case ".b64": case ".base64": l_k = 3; break;
					default:
						show_error("Cannot auto-detect kind for \"" + l_path1 + "\"", false);
						exit;
				}
			} else switch (l_kind) {
				case "text": l_k = 1; break;
				case "json": l_k = 2; break;
				case "csv": l_k = 4; break;
				case "base64": l_k = 3; break;
				case "buffer": l_k = 0; break;
				case "auto":
					switch (string_lower(filename_ext(l_path1))) {
						case ".csv": l_k = 4; break;
						case ".json": l_k = 2; break;
						case ".txt": l_k = 1; break;
						case ".bin": l_k = 0; break;
						case ".b64": case ".base64": l_k = 3; break;
						default:
							show_error("Cannot auto-detect kind for \"" + l_path1 + "\"", false);
							exit;
					}
					break;
				default:
					show_error("Unrecognized kind \"" + gml_std_Std_stringify(l_kind) + "\"", false);
					exit;
			}
			ds_map_set(live_live_included_files, l_path1, { func: l_callback, kind: l_k });
			l_i = ds_list_find_index(live_live_included_files_stop, l_path1);
			if (l_i >= 0) ds_list_delete(live_live_included_files_stop, l_i);
			ds_list_add(live_live_included_files_start, l_path1);
		} else {
			if (!ds_map_exists(live_live_included_files, l_path1)) exit;
			if (l_kind != undefined) {
				show_error("Kind should not be specified without a callback", false);
				exit;
			}
			ds_map_delete(live_live_included_files, l_path1);
			l_i = ds_list_find_index(live_live_included_files_start, l_path1);
			if (l_i >= 0) ds_list_delete(live_live_included_files_start, l_i);
			ds_list_add(live_live_included_files_stop, l_path1);
		}
	}
}

function room_set_live(l_rm, l_enable) {
	/// room_set_live(rm:room, enable:bool)
	/// @param {room} rm
	/// @param {bool} enable
	/// @returns {void}
	if (live_enabled) {
		var l_i;
		if (l_enable) {
			if (ds_map_exists(live_live_rooms, l_rm)) exit;
			ds_map_set(live_live_rooms, l_rm, true);
			l_i = ds_list_find_index(live_live_rooms_stop, l_rm);
			if (l_i >= 0) ds_list_delete(live_live_rooms_stop, l_i);
			ds_list_add(live_live_rooms_start, l_rm);
		} else {
			if (!ds_map_exists(live_live_rooms, l_rm)) exit;
			ds_map_delete(live_live_rooms, l_rm);
			ds_map_delete(live_live_room_data, l_rm);
			l_i = ds_list_find_index(live_live_rooms_start, l_rm);
			if (l_i >= 0) ds_list_delete(live_live_rooms_start, l_i);
			ds_list_add(live_live_rooms_stop, l_rm);
		}
	}
}

function room_goto_live(l_rm) {
	/// room_goto_live(rm:room)
	/// @param {room} rm
	/// @returns {void}
	if (live_enabled) {
		if (ds_map_exists(live_live_rooms, l_rm) && ds_map_exists(live_live_room_data, l_rm)) {
			live_live_room = l_rm;
			if (!room_exists(live_blank_room)) throw gml_std_haxe_Exception_thrown("Please add a completely empty room, add live_room_start(); to it's Creation Code, and assign it to live_blank_room in obj_gmlive's create event.");
			room_goto(live_blank_room);
			exit;
		}
		room_goto(l_rm);
	}
}

if (live_enabled) 
function live_get_update_tail() {
	// live_get_update_tail()->string
	/// @ignore
	var l_url = "";
	var l_sl = live_live_sprites_stop;
	var l_sln = ds_list_size(l_sl);
	if (l_sln > 0) {
		l_url += "&sprites" + string(0) + "=" + sprite_get_name(ds_list_find_value(l_sl, 0));
		var l_i = 1;
		for (var l__g1 = l_sln; l_i < l__g1; l_i++) {
			l_url += "+" + sprite_get_name(ds_list_find_value(l_sl, l_i));
		}
		ds_list_clear(l_sl);
	}
	var l_sl = live_live_sprites_start;
	var l_sln = ds_list_size(l_sl);
	if (l_sln > 0) {
		l_url += "&sprites" + string(1) + "=" + sprite_get_name(ds_list_find_value(l_sl, 0));
		var l_i = 1;
		for (var l__g1 = l_sln; l_i < l__g1; l_i++) {
			l_url += "+" + sprite_get_name(ds_list_find_value(l_sl, l_i));
		}
		ds_list_clear(l_sl);
	}
	var l_sl = live_shader_live_shaders_stop;
	var l_sln = ds_list_size(l_sl);
	if (l_sln > 0) {
		l_url += "&shaders" + string(0) + "=" + shader_get_name(ds_list_find_value(l_sl, 0));
		var l_i = 1;
		for (var l__g1 = l_sln; l_i < l__g1; l_i++) {
			l_url += "+" + shader_get_name(ds_list_find_value(l_sl, l_i));
		}
		ds_list_clear(l_sl);
	}
	var l_sl = live_shader_live_shaders_start;
	var l_sln = ds_list_size(l_sl);
	if (l_sln > 0) {
		l_url += "&shaders" + string(1) + "=" + shader_get_name(ds_list_find_value(l_sl, 0));
		var l_i = 1;
		for (var l__g1 = l_sln; l_i < l__g1; l_i++) {
			l_url += "+" + shader_get_name(ds_list_find_value(l_sl, l_i));
		}
		ds_list_clear(l_sl);
	}
	var l_rl = live_live_rooms_stop;
	var l_rln = ds_list_size(l_rl);
	if (l_rln > 0) {
		l_url += "&rooms" + string(0) + "=" + room_get_name(ds_list_find_value(l_rl, 0));
		var l_i = 1;
		for (var l__g1 = l_rln; l_i < l__g1; l_i++) {
			l_url += "+" + room_get_name(ds_list_find_value(l_rl, l_i));
		}
		ds_list_clear(l_rl);
	}
	var l_rl = live_live_rooms_start;
	var l_rln = ds_list_size(l_rl);
	if (l_rln > 0) {
		l_url += "&rooms" + string(1) + "=" + room_get_name(ds_list_find_value(l_rl, 0));
		var l_i = 1;
		for (var l__g1 = l_rln; l_i < l__g1; l_i++) {
			l_url += "+" + room_get_name(ds_list_find_value(l_rl, l_i));
		}
		ds_list_clear(l_rl);
	}
	var l_rl = live_live_point_paths_stop;
	var l_rln = ds_list_size(l_rl);
	if (l_rln > 0) {
		l_url += "&paths" + string(0) + "=" + path_get_name(ds_list_find_value(l_rl, 0));
		var l_i = 1;
		for (var l__g1 = l_rln; l_i < l__g1; l_i++) {
			l_url += "+" + path_get_name(ds_list_find_value(l_rl, l_i));
		}
		ds_list_clear(l_rl);
	}
	var l_rl = live_live_point_paths_start;
	var l_rln = ds_list_size(l_rl);
	if (l_rln > 0) {
		l_url += "&paths" + string(1) + "=" + path_get_name(ds_list_find_value(l_rl, 0));
		var l_i = 1;
		for (var l__g1 = l_rln; l_i < l__g1; l_i++) {
			l_url += "+" + path_get_name(ds_list_find_value(l_rl, l_i));
		}
		ds_list_clear(l_rl);
	}
	var l_rl = live_live_anim_curves_stop;
	var l_rln = ds_list_size(l_rl);
	if (l_rln > 0) {
		l_url += "&animCurves" + string(0) + "=";
		var l_i = 0;
		for (var l__g1 = l_rln; l_i < l__g1; l_i++) {
			var l_ac = ds_list_find_value(l_rl, l_i);
			if (l_i > 0) l_url += "+" + animcurve_get(l_ac).name; else l_url += animcurve_get(l_ac).name;
		}
		ds_list_clear(l_rl);
	}
	var l_rl = live_live_anim_curves_start;
	var l_rln = ds_list_size(l_rl);
	if (l_rln > 0) {
		l_url += "&animCurves" + string(1) + "=";
		var l_i = 0;
		for (var l__g1 = l_rln; l_i < l__g1; l_i++) {
			var l_ac = ds_list_find_value(l_rl, l_i);
			if (l_i > 0) l_url += "+" + animcurve_get(l_ac).name; else l_url += animcurve_get(l_ac).name;
			l_url += "-" + gml_std_Std_stringify(ds_map_find_value(live_live_anim_curves, l_ac));
		}
		ds_list_clear(l_rl);
	}
	var l_rl = live_live_included_files_stop;
	var l_rln = ds_list_size(l_rl);
	if (l_rln > 0) {
		l_url += "&incFiles" + string(0) + "=" + ds_list_find_value(l_rl, 0);
		var l_i = 1;
		for (var l__g1 = l_rln; l_i < l__g1; l_i++) {
			l_url += "+" + ds_list_find_value(l_rl, l_i);
		}
		ds_list_clear(l_rl);
	}
	var l_rl = live_live_included_files_start;
	var l_rln = ds_list_size(l_rl);
	if (l_rln > 0) {
		l_url += "&incFiles" + string(1) + "=" + ds_list_find_value(l_rl, 0);
		var l_i = 1;
		for (var l__g1 = l_rln; l_i < l__g1; l_i++) {
			l_url += "+" + ds_list_find_value(l_rl, l_i);
		}
		ds_list_clear(l_rl);
	}
	return l_url;
}

if (live_enabled) 
function live_default_update(l_thing) {
	// live_default_update(thing:any)
	/// @ignore
	
}

if (live_enabled) 
function live_room_updated_impl(l_rm) {
	// live_room_updated_impl(rm:room)
	/// @ignore
	room_goto_live(l_rm);
}

#endregion

#region live

if (live_enabled) 
function live_temp_path_init() {
	// live_temp_path_init()->string
	/// @ignore
	return "gmlive-" + gml_std_Std_stringify(gml_std_Date_now().h_getTime());
}

if (live_enabled) 
function live_script_get_index(l_name) {
	// live_script_get_index(name:string)->script
	/// @ignore
	return asset_get_index(l_name);
}

if (live_enabled) 
function live_log_impl(l_text, l_level) {
	// live_log_impl(text:string, level:live_GMLiveLogLevel)
	/// @ignore
	if (l_level == 0) show_debug_message("[GMLive][" + date_datetime_string(gml_std_Date_now().h_date) + "] " + l_text); else show_debug_message("[GMLive][" + date_datetime_string(gml_std_Date_now().h_date) + "][" + live_log_impl_levels[l_level] + "] " + l_text);
}

if (live_enabled) 
function live_log(l_s, l_level) {
	// live_log(s:string, level:live_GMLiveLogLevel)
	/// @ignore
	live_log_script(l_s, l_level);
}

function live_update_script_impl(l_name, l_ident, l_code) {
	/// live_update_script_impl(name:string, ident:string, code:string)
	/// @param {string} name
	/// @param {string} ident
	/// @param {string} code
	/// @returns {void}
	if (live_enabled) {
		var l_data = live_live_map[$ l_ident];
		if (l_data == undefined) {
			l_data = live_cache_data_create();
			live_live_map[$ l_ident] = l_data;
		}
		var l_pg = live_gmlive_patcher_compile_ex(l_name, l_code);
		if (l_pg == undefined) {
			live_log_script("Error in " + l_name + ":", 2);
			live_log_script(live_gmlive_patcher_error_text, 2);
			exit;
		}
		if (l_pg.h_error_text != undefined) {
			live_log_script("Warning in " + l_name + ":", 2);
			live_log_script(l_pg.h_error_text, 2);
		}
		l_pg.h_live_ident = l_ident;
		live_log_script("Reloaded " + l_name + ".", 0);
		if (l_data[0/* program */] != undefined) l_data[0/* program */].h_destroy();
		l_data[@0/* program */] = l_pg;
	}
}

function live_constant_add(l_name, l_value) {
	/// live_constant_add(name:string, value:any)
	/// @param {string} name
	/// @param {any} value
	/// @returns {void}
	if (live_enabled) {
		gml_const_add(l_name, l_value);
	}
}

function live_constant_delete(l_name) {
	/// live_constant_delete(name:string)->bool
	/// @param {string} name
	/// @returns {bool}
	if (live_enabled) {
		return gml_remove_const(l_name);
	} else return false;
}

function live_variable_add(l_signature, l_func) {
	/// live_variable_add(signature:string, func:any)
	/// @param {string} signature
	/// @param {any} func
	/// @returns {void}
	if (live_enabled) {
		gml_var_add(l_signature, l_func);
	}
}

function live_variable_delete(l_name) {
	/// live_variable_delete(name:string)->bool
	/// @param {string} name
	/// @returns {bool}
	if (live_enabled) {
		return gml_remove_var(l_name);
	} else return false;
}

function live_function_add(l_signature, l_func) {
	/// live_function_add(signature:string, func:any)
	/// @param {string} signature
	/// @param {any} func
	/// @returns {void}
	if (live_enabled) {
		var l_f = new gml_func();
		l_f.h_set(l_signature, l_func);
		gml_func_map[$ l_f.h_name] = l_f;
	}
}

function live_function_delete(l_name) {
	/// live_function_delete(name:string)->bool
	/// @param {string} name
	/// @returns {bool}
	if (live_enabled) {
		if (gml_func_map[$ l_name] == undefined) {
			return false;
		} else {
			variable_struct_remove(gml_func_map, l_name);
			return true;
		}
	} else return false;
}

function live_throw_error(l_text) {
	/// live_throw_error(text:string)
	/// @param {string} text
	/// @returns {void}
	if (live_enabled) {
		gml_thread_error(l_text);
	}
}

function live_execute_string(l_gml_code) {
	/// live_execute_string(gml_code:string, ...args:any)->bool
	/// @param {string} gml_code
	/// @param {any} ...args
	/// @returns {bool}
	if (false) show_debug_message(argument[argument_count - 1]);
	if (live_enabled) {
		var l_pg = new gml_program([new gml_source("execute_string", l_gml_code, "execute_string")]);
		var l_ok;
		live_custom_self = self;
		live_custom_other = other;
		if (l_pg.h_error_text == undefined) {
			var l_argc = (argument_count - 1);
			var l_argv = array_create(l_argc);
			var l_i = 0;
			var l__ = 0;
			for (var l__g1 = l_argc; l__ < l__g1; l__++) {
				l_argv[@l_i] = argument[l_i + 1];
				l_i++;
			}
			var l_th = l_pg.h_call_v("execute_string", l_argv, false);
			if (l_th.h_status == 3) {
				l_ok = true;
				live_result = l_th.h_result;
			} else {
				l_ok = false;
				live_result = l_th.h_error_text;
				if (live_result == undefined) live_result = "(unknown error)";
			}
		} else {
			l_ok = false;
			live_result = l_pg.h_error_text;
		}
		l_pg.h_destroy();
		return l_ok;
	} else return false;
}

function live_snippet_create(l_gml_code, l_name) {
	/// live_snippet_create(gml_code:string, name:string = "snippet")->gml_program
	/// @param {string} gml_code
	/// @param {string} [name="snippet"]
	/// @returns {gml_program}
	if (l_name == undefined) l_name = "snippet";
	if (false) show_debug_message(argument[1]);
	if (live_enabled) {
		var l_pg = new gml_program([new gml_source(l_name, l_gml_code, "snippet")]);
		if (l_pg.h_error_text == undefined) {
			return l_pg;
		} else {
			live_result = l_pg.h_error_text;
			l_pg.h_destroy();
			return undefined;
		}
	} else return undefined;
}

function live_snippet_destroy(l_snippet) {
	/// live_snippet_destroy(snippet:gml_program)
	/// @param {gml_program} snippet
	/// @returns {void}
	if (live_enabled) {
		if (l_snippet.h_script_array != undefined) l_snippet.h_destroy(); else throw gml_std_haxe_Exception_thrown("This snippet is already destroyed");
	}
}

function live_snippet_call(l_snippet) {
	/// live_snippet_call(snippet:gml_program, ...args:any)->bool
	/// @param {gml_program} snippet
	/// @param {any} ...args
	/// @returns {bool}
	if (false) show_debug_message(argument[argument_count - 1]);
	if (live_enabled) {
		var l_argc = (argument_count - 1);
		var l_argv = array_create(l_argc);
		var l_i = 0;
		var l__ = 0;
		for (var l__g1 = l_argc; l__ < l__g1; l__++) {
			l_argv[@l_i] = argument[l_i + 1];
			l_i++;
		}
		live_custom_self = self;
		live_custom_other = other;
		var l_th = l_snippet.h_call_v("snippet", l_argv, false);
		if (l_th == undefined) {
			live_result = "(script missing)";
			return false;
		} else if (l_th.h_status == 3) {
			live_result = l_th.h_result;
			return true;
		} else {
			live_result = l_th.h_error_text;
			if (live_result == undefined) live_result = "(unknown error)";
			return false;
		}
	} else return false;
}

function live_update() {
	/// live_update()
	/// @returns {void}
	if (live_enabled) {
		if (live_request_url == undefined) exit;
		if (live_request_id == undefined) {
			var l_now = current_time / 1000 * 1000.;
			live_last_update_at = l_now;
			if (l_now > live_request_time) {
				live_request_time = l_now + live_request_rate * 1000;
				var l_url;
				if (live_request_guid == undefined) {
					if (current_time > live_init_timeout * 1000) {
						if (!live_warned_about_init_timeout) {
							live_warned_about_init_timeout = true;
							show_debug_message("Didn't receive a response from the server in " + string(live_init_timeout) + "s (live_init_timeout) - no longer retrying a connection");
						}
						exit;
					}
					live_log_script("Trying to connect to gmlive-server...", 0);
					l_url = live_request_url + "/init?password=" + live_request_password + "&version=" + string(106) + "&noscripts=1&config=" + live_config + "&runtime=" + live_runtime_version + "&buildDate=" + gml_std_Std_stringify(live_build_date);
				} else {
					l_url = live_request_url + "/update?guid=" + ((live_request_guid == undefined ? "null" : live_request_guid));
					l_url += live_get_update_tail();
				}
				live_request_id = http_get(l_url);
			}
		}
	}
}

function live_init(l_updateRate, l_url, l_password) {
	/// live_init(updateRate:number, url:string, password:string)
	/// @param {number} updateRate
	/// @param {string} url
	/// @param {string} password
	/// @returns {void}
	if (live_enabled) {
		if (l_url != undefined) {
			var l_url_last = string_length(l_url) - 1;
			if (string_ord_at(l_url, l_url_last + 1) == 47) l_url = gml_std_string_substring(l_url, 0, l_url_last);
		}
		live_log_script("Initializing...", 0);
		live_config = os_get_config();
		live_runtime_version = GM_runtime_version;
		var l_date1 = gml_std_Date_now();
		l_date1.h_date = GM_build_date;
		live_build_date = l_date1.h_getTime();
		live_request_rate = l_updateRate;
		live_request_url = l_url;
		live_request_password = l_password;
		var l_srs = asset_get_index("shader_replace_simple");
		if (l_srs != -1) live_shader_updated = l_srs;
		live_log_script("Indexing assets...", 0);
		live_bits_gmlive_indexer_add_assets();
		live_bits_gmlive_indexer_add_scripts();
		live_log_script("Indexed OK!", 0);
	}
}

if (live_enabled) 
function live_preinit_project_fake_call() {
	// live_preinit_project_fake_call()->bool
	/// @ignore
	live_name = undefined;
	return false;
}

if (live_enabled) 
function live_preinit_project_lf(l_write, l_val) {
	// live_preinit_project_lf(write:bool, val:any)->string
	/// @ignore
	if (l_write) {
		live_name = l_val;
		return l_val;
	} else return live_name;
}

if (live_enabled) 
function live_preinit_project() {
	// live_preinit_project()
	/// @ignore
	gml_var_add("live_name", live_preinit_project_lf);
	gml_const_add("live_result", false);
	var l_f = new gml_func();
	l_f.h_set("live_call(...):", live_preinit_project_fake_call);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("live_defcall(...):", live_preinit_project_fake_call);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("live_call_ext(...):", live_preinit_project_fake_call);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("live_defcall_ext(...):", live_preinit_project_fake_call);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("live_method(self, func):", live_method);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("method(self, func):", live_method);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("live_method_get_self(func):", live_method_get_self);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("method_get_self(func):", live_method_get_self);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("live_execute_string(:string):", live_execute_string);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("live_snippet_create(:string, :string=\"snippet\"):", live_snippet_create);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("live_snippet_call(snip, ...rest):", live_snippet_call);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("live_snippet_destroy(snip):", live_snippet_destroy);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("sprite_set_live(spr:index, status:bool)", sprite_set_live);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("shader_set_live(sh:index, status:bool)", shader_set_live);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("path_set_live(pt:index, status:bool)", path_set_live);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("room_set_live(rm:index, status:bool)", room_set_live);
	gml_func_map[$ l_f.h_name] = l_f;
	var l_f = new gml_func();
	l_f.h_set("room_goto_live(rm:index)", room_goto_live);
	gml_func_map[$ l_f.h_name] = l_f;
}

#endregion
