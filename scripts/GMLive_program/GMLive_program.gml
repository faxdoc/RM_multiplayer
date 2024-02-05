// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.
// Feather disable all

// VM "programs"
#region gml.program

if (live_enabled) 
function gml_program(l_sources) constructor {
	// gml_program(sources:array<gml_source>)
	/// @ignore
	static h_sources = undefined; /// @is {array<gml_source>}
	static h_get_source = function(l_posSrc) {
		if (l_posSrc == -2) return gml_source_builtin;
		if (l_posSrc >= 0 && l_posSrc < array_length(self.h_sources)) return self.h_sources[l_posSrc];
		return gml_source_unknown;
	}
	static h_script_array = undefined; /// @is {array<gml_script>}
	static h_script_map = undefined; /// @is {tools_Dictionary<gml_script>}
	static h_enum_array = undefined; /// @is {array<gml_enum>}
	static h_enum_map = undefined; /// @is {tools_Dictionary<gml_enum>}
	static h_macro_map = undefined; /// @is {tools_Dictionary<gml_macro>}
	static h_wait_list = undefined; /// @is {tools_ArrayList<gml_thread>}
	static h_wait_list_swap = undefined; /// @is {tools_ArrayList<gml_thread>}
	static h_callback = undefined; /// @is {function<gml_thread;void>}
	static h_time_tag = undefined; /// @is {vm_GmlThreadTimeTag}
	static h_error_text = undefined; /// @is {string}
	static h_error_pos = undefined; /// @is {gml_pos}
	static h_is_ready = undefined; /// @is {bool}
	static h_tag = undefined; /// @is {any}
	static h_live_ident = undefined; /// @is {string}
	static h_has_fast_getter = function(l_fd) {
		return variable_struct_exists(gml_fast_field_getters, l_fd);
	}
	static h_get_fast_getter = function(l_fd) {
		return gml_fast_field_getters[$ l_fd];
	}
	static h_get_fast_setter = function(l_fd) {
		return gml_fast_field_setters[$ l_fd];
	}
	static h_get_fast_setter_after_getter = function(l_fd) {
		return gml_fast_field_setters[$ l_fd];
	}
	static h_error = function(l_text, l_d) {
		var l_pos = l_d;
		self.h_error_text = gml_pos_to_string(l_pos, self) + " " + l_text;
		self.h_error_pos = l_pos;
		return true;
	}
	static h_merge_builder_results = function(l_b) {
		var l_main = l_b.h_source.h_main;
		var l__g = 0;
		var l__g1 = l_b.h_scripts;
		while (l__g < array_length(l__g1)) {
			var l_scr = l__g1[l__g];
			l__g++;
			if (variable_struct_exists(self.h_script_map, l_scr.h_name)) {
				if (l_scr.h_name == l_main) {
					var l__g2 = self.h_script_map[$ l_main].h_node;
					var l_tmp;
					if (l__g2[0]/* gml_node */ == gml_node.block) l_tmp = array_length(l__g2[2/* nodes */]) == 0; else l_tmp = false;
					if (l_tmp) {
						var l_w = self.h_script_array;
						var l_i = 0;
						var l_n = array_length(l_w);
						while (l_i < l_n) {
							if (l_w[l_i].h_name == l_main) {
								while (++l_i < l_n) {
									l_w[@l_i - 1] = l_w[l_i];
								}
								l_w[@l_n - 1] = l_scr;
							} else l_i++;
						}
						self.h_script_map[$ l_scr.h_name] = l_scr;
					} else {
						self.h_error("Cannot override prefix-script \"" + l_main + "\" because it is not empty", l_scr.h_pos);
						exit;
					}
				} else {
					self.h_error("Script " + l_scr.h_name + " is already defined at " + gml_pos_to_string(self.h_script_map[$ l_scr.h_name].h_pos, self), l_scr.h_pos);
					exit;
				}
			} else {
				array_push(self.h_script_array, l_scr);
				self.h_script_map[$ l_scr.h_name] = l_scr;
			}
		}
		var l__g = 0;
		var l__g1 = l_b.h_enums;
		while (l__g < array_length(l__g1)) {
			var l_e = l__g1[l__g];
			l__g++;
			array_push(self.h_enum_array, l_e);
			self.h_enum_map[$ l_e.h_name] = l_e;
		}
		var l_mcrNames = l_b.h_macro_names;
		var l_mcrNodes = l_b.h_macro_nodes;
		var l_mcrMap = self.h_macro_map;
		var l_i = 0;
		for (var l__g1 = array_length(l_mcrNames); l_i < l__g1; l_i++) {
			l_mcrMap[$ l_mcrNames[l_i]] = l_mcrNodes[l_i];
		}
	}
	static h_destroy = function() {
		var l__g = 0;
		var l__g1 = self.h_script_array;
		while (l__g < array_length(l__g1)) {
			var l_q = l__g1[l__g];
			l__g++;
			l_q.h_destroy();
		}
		self.h_script_array = undefined;
		self.h_script_map = undefined;
		self.h_enum_map = undefined;
		self.h_macro_map = undefined;
		ds_list_destroy(self.h_wait_list);
		self.h_wait_list = undefined;
		ds_list_destroy(self.h_wait_list_swap);
		self.h_wait_list_swap = undefined;
	}
	static h_call_v = function(l_name, l_args1, l_copy) {
		if (l_copy == undefined) l_copy = true;
		if (false) show_debug_message(argument[2]);
		var l_scr = self.h_script_map[$ l_name];
		if (l_scr != undefined) {
			var l_locals = array_create(l_scr.h_locals);
			if (l_copy) l_args1 = gml_value_list_copy(l_args1);
			gml_value_list_pad_to_size_with_null(l_args1, l_scr.h_arguments);
			var l_th = new gml_thread(self, l_scr.h_actions, l_args1, l_locals);
			l_th.h_callback = self.h_callback;
			l_th.h_time_tag = self.h_time_tag;
			l_th.h_exec();
			return l_th;
		} else return undefined;
	}
	static h_print = function() {
		var l_r = new gml_std_StringBuf();
		var l_i = 0;
		for (var l__g1 = array_length(self.h_script_array); l_i < l__g1; l_i++) {
			if (l_i > 0) l_r.h_addChar(10);
			var l_scr = self.h_script_array[l_i];
			l_r.h_add("#define ");
			l_r.h_add(l_scr.h_name);
			l_r.h_add("\n// locals: {");
			var l_localNames = l_scr.h_local_names;
			var l_k = 0;
			for (var l__g3 = array_length(l_localNames); l_k < l__g3; l_k++) {
				if (l_k > 0) l_r.h_add(", "); else l_r.h_add(" ");
				l_r.h_add(l_k);
				l_r.h_add(": \"");
				l_r.h_add(l_localNames[l_k]);
				l_r.h_add("\"");
			}
			l_r.h_add(" }\n");
			l_r.h_add(gml_action_list_print(l_scr.h_actions));
		}
		return l_r.h_toString();
	}
	static h_seek = function(l_f, l_st) {
		if (l_st == undefined) l_st = false;
		if (false) show_debug_message(argument[1]);
		var l_w = (l_st ? ds_list_create() : undefined);
		gml_program_seek_func = l_f;
		var l_m = self.h_script_array;
		var l_n = array_length(l_m);
		var l_i = 0;
		while (l_i < l_n) {
			var l_scr = l_m[l_i];
			gml_program_seek_script = l_scr;
			var l_scrNode = l_scr.h_node;
			if (l_scrNode != undefined && l_f(l_scrNode, l_w)) break; else l_i++;
		}
		gml_program_seek_script = undefined;
		gml_program_seek_func = undefined;
		if (l_st) ds_list_destroy(l_w);
		return l_i < l_n;
	}
	static h_check = function() {
		gml_program_seek_inst = self;
		if (self.h_seek(gml_seek_arguments_proc, false)) return true;
		if (self.h_seek(gml_seek_locals_proc, false)) return true;
		if (self.h_seek(gml_seek_idents_proc, true)) return true;
		if (self.h_seek(gml_seek_fields_proc, false)) return true;
		if (self.h_seek(gml_seek_calls_proc, false)) return true;
		if (gml_seek_enum_values_proc()) return true;
		if (self.h_seek(gml_seek_enum_fields_proc, false)) return true;
		if (gml_seek_eval_opt()) return true;
		if (self.h_seek(gml_seek_self_fields_proc, false)) return true;
		if (self.h_seek(gml_seek_alarms_proc, false)) return true;
		if (self.h_seek(gml_seek_adjfix_proc, true)) return true;
		if (self.h_seek(gml_seek_set_op_proc, true)) return true;
		gml_program_seek_inst = undefined;
		return false;
	}
	static h_eval_value = undefined; /// @is {any}
	static h_eval = function(l_q) {
		var l_r, l_v;
		var l__g = l_q;
		switch (l__g[0]) {
			case gml_node.number: l_r = l__g[2/* value */]; break;
			case gml_node.cstring: l_r = l__g[2/* value */]; break;
			case gml_node.field:
				var l__hx_tmp = l__g[2/* obj */];
				if (l__hx_tmp[0]/* gml_node */ == gml_node.ident) {
					var l_d = l__g[1/* d */];
					var l_s = l__hx_tmp[2/* id */];
					var l_f = l__g[3/* field */];
					var l_e = self.h_enum_map[$ l_s];
					if (l_e != undefined) {
						var l_c = l_e.h_ctr_map[$ l_f];
						if (l_c != undefined) {
							l_r = l_c.h_value;
							if (l_r == undefined) return self.h_error("Value of " + l_s + "." + l_f + " is not known here", l_d);
						} else return self.h_error("Enum `" + l_s + "` does not contain field `" + l_f + "`", l_d);
					} else return self.h_error("Could not find enum " + l_s, l_d);
				} else return self.h_error("Can not evaluate this compile-time", gml_std_haxe_enum_tools_getParameter(l_q, 0));
				break;
			case gml_node.bin_op:
				if (self.h_eval(l__g[3/* a */])) return true;
				l_r = self.h_eval_value;
				if (self.h_eval(l__g[4/* b */])) return true;
				l_v = self.h_eval_value;
				switch (l__g[2/* op */]) {
					case 16: l_r += l_v; break;
					case 17: l_r -= l_v; break;
					case 0: l_r *= l_v; break;
					case 1: l_r /= l_v; break;
					case 2: l_r %= l_v; break;
					case 3:
						var l_a = l_r;
						var l_b = l_v;
						if (l_b == 0 && is_int64(l_b) && is_int64(l_a)) throw gml_std_haxe_Exception_thrown("Division by zero");
						l_r = (l_a div l_b);
						break;
					case 49: l_r &= l_v; break;
					case 48: l_r |= l_v; break;
					case 50: l_r ^= l_v; break;
					case 32: l_r = l_r << l_v; break;
					case 33: l_r = l_r >> l_v; break;
					default: return self.h_error("Can not evaluate this compile-time", gml_std_haxe_enum_tools_getParameter(l_q, 0));
				}
				break;
			default: return self.h_error("Can not evaluate this compile-time", gml_std_haxe_enum_tools_getParameter(l_q, 0));
		}
		self.h_eval_value = l_r;
		return false;
	}
	self.h_is_ready = false;
	self.h_error_text = undefined;
	self.h_time_tag = undefined;
	self.h_callback = undefined;
	self.h_wait_list_swap = ds_list_create();
	self.h_wait_list = ds_list_create();
	self.h_macro_map = { }
	self.h_enum_map = { }
	self.h_enum_array = [];
	self.h_script_map = { }
	self.h_script_array = [];
	self.h_sources = undefined;
	var l_i = 0;
	for (var l__g1 = array_length(l_sources); l_i < l__g1; l_i++) {
		l_sources[l_i].h_index = l_i;
	}
	self.h_sources = l_sources;
	var l_builders = [];
	var l__g = 0;
	while (l__g < array_length(l_sources)) {
		var l_src = l_sources[l__g];
		l__g++;
		array_push(l_builders, new gml_builder(self, l_src));
	}
	if (array_length(l_sources) > 0 && !l_sources[0].h_version.h_expr_macros) {
		if (ast_gml_macro_proc_run(self, l_builders)) exit;
	}
	var l__g = 0;
	while (l__g < array_length(l_builders)) {
		var l_b = l_builders[l__g];
		l__g++;
		l_b.h_run();
		if (l_b.h_error_text == undefined) {
			self.h_merge_builder_results(l_b);
		} else if (l_b.h_source.h_opt) {
			var l_errorNext = l_b.h_error_text;
			if (self.h_error_text != undefined) self.h_error_text += "\n" + l_errorNext; else self.h_error_text = l_errorNext;
		} else {
			self.h_error_text = l_b.h_error_text;
			self.h_error_pos = l_b.h_error_pos;
			exit;
		}
	}
	var l_i;
	var l_n = array_length(self.h_script_array);
	for (l_i = 0; l_i < l_n; l_i++) {
		self.h_script_array[l_i].h_index = gml_script_index_offset + l_i;
	}
	if (self.h_check()) {
		gml_program_seek_inst = undefined;
		exit;
	}
	if (gml_compile_program(self)) {
		if (self.h_error_text != undefined) self.h_error_text += "\n" + gml_compile_error_text; else self.h_error_text = gml_compile_error_text;
		self.h_error_pos = gml_compile_error_pos;
		exit;
	}
	l_builders = undefined;
	l_n = array_length(self.h_script_array);
	for (l_i = 0; l_i < l_n; l_i++) {
		self.h_script_array[l_i].h_node = undefined;
	}
	self.h_is_ready = true;
	static __class__ = mt_gml_program;
}

#endregion
