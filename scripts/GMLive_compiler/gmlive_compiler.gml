// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.
// Feather disable all

// converts AST to "instructions"!
#region gml.compile

if (live_enabled) 
function gml_compile_error(l_text, l_pos) {
	// gml_compile_error(text:string, pos:gml_pos)->bool
	/// @ignore
	gml_compile_error_text = gml_pos_to_string(l_pos, gml_compile_curr_program) + " " + l_text;
	gml_compile_error_pos = l_pos;
	return true;
}

if (live_enabled) 
function gml_compile_const_val_of(l_q) {
	// gml_compile_const_val_of(q:ast_GmlNode)->bool
	/// @ignore
	var l__g = l_q;
	var l_tmp;
	switch (l__g[0]) {
		case gml_node.undefined_hx: l_tmp = undefined; break;
		case gml_node.number: l_tmp = l__g[2/* value */]; break;
		case gml_node.cstring: l_tmp = l__g[2/* value */]; break;
		case gml_node.other_const: l_tmp = l__g[2/* value */]; break;
		case gml_node.const: l_tmp = gml_const_val[$ l__g[2/* name */]]; break;
		default: return false;
	}
	gml_compile_const_val_of_val = l_tmp;
	return true;
}

if (live_enabled) 
function gml_compile_set_handlers(l_fn, l_defNames) {
	// gml_compile_set_handlers(fn:function<q:ast_GmlNode;actions:gml_action_list;out:bool;bool?>, defNames:array<string>)
	/// @ignore
	var l__g = 0;
	while (l__g < array_length(l_defNames)) {
		var l_defName = l_defNames[l__g];
		l__g++;
		var l_i = gml_compile_def_indexes.h_obj[$ l_defName];
		if (l_i == undefined) throw gml_std_haxe_Exception_thrown("Couldn't find " + l_defName);
		if (gml_compile_handlers[l_i] != undefined) show_debug_message(("Handler re-definition for " + l_defName));
		gml_compile_handlers[@l_i] = l_fn;
	}
}

if (live_enabled) 
function gml_compile_init() {
	// gml_compile_init()->gml_script?
	/// @ignore
	gml_compile_def_indexes = new haxe_ds_string_map();
	var l_names = gml_std_gml_internal_ArrayImpl_copy(g_gml_node_constructors);
	var l__g_current = 0;
	var l__g_array = l_names;
	while (l__g_current < array_length(l__g_array)) {
		var l_name = l__g_array[l__g_current];
		var l_i = l__g_current++;
		if (gml_std_StringTools_endsWith(l_name, "_hx")) l_name = gml_std_string_substring(l_name, 0, string_length(l_name) - 3);
		gml_compile_def_indexes.h_obj[$ l_name] = l_i;
	}
	gml_compile_handlers = array_create(array_length(l_names), undefined);
	compile_groups_gml_compile_group_literal_init();
	compile_groups_gml_compile_group_ds_init();
	compile_groups_gml_compile_group_array_init();
	compile_groups_gml_compile_group_local_init();
	compile_groups_gml_compile_group_static_init();
	return undefined;
}

if (live_enabled) 
function gml_compile_node(l_q, l_actions, l_out) {
	// gml_compile_node(q:ast_GmlNode, actions:gml_action_list, out:bool)->bool?
	/// @ignore
	var l_h = gml_compile_handlers[l_q[0]];
	if (l_h != undefined) {
		var l_z = l_h(l_q, l_actions, l_out);
		if (l_z != undefined) return l_z;
	}
	var l_x, l_x2, l_w, l_i, l_k, l_z, l_n, l_p0, l_p1, l_p2, l_p3, l_pc, l_pb, l_s, l_v, l_d, l_o, l_fn, l_fn2;
	var l__g = l_q;
	switch (l__g[0]) {
		case gml_node.ensure_array_for_local: ds_list_add(l_actions, gml_action_ensure_array_for_local(l__g[1/* d */], gml_compile_curr_script.h_local_map[$ l__g[2/* name */]])); break;
		case gml_node.ensure_array_for_global: ds_list_add(l_actions, gml_action_ensure_array_for_global(l__g[1/* d */], l__g[2/* name */])); break;
		case gml_node.ensure_array_for_field:
			if (gml_compile_node(l__g[2/* obj */], l_actions, true)) return true;
			ds_list_add(l_actions, gml_action_ensure_array_for_field(l__g[1/* d */], l__g[3/* fd */]));
			break;
		case gml_node.ensure_array_for_index:
			if (compile_gml_compile_args_proc(l_actions, [l__g[2/* arr */], l__g[3/* ind */]])) return true;
			ds_list_add(l_actions, gml_action_ensure_array_for_index(l__g[1/* d */]));
			break;
		case gml_node.ensure_array_for_index2d:
			if (compile_gml_compile_args_proc(l_actions, [l__g[2/* arr */], l__g[3/* ind1 */], l__g[4/* ind2 */]])) return true;
			ds_list_add(l_actions, gml_action_ensure_array_for_index2d(l__g[1/* d */]));
			break;
		case gml_node.in:
			var l__field = l__g[2/* fd */];
			var l__g1 = l__field;
			if (l__g1[0]/* gml_node */ == gml_node.cstring) {
				if (gml_compile_node(l__g[3/* obj */], l_actions, true)) return true;
				ds_list_add(l_actions, gml_action_in_const(l__g[1/* d */], l__g1[2/* value */], l__g[4/* not */]));
			} else {
				if (compile_gml_compile_args_proc(l_actions, [l__field, l__g[3/* obj */]])) return true;
				ds_list_add(l_actions, gml_action_in(l__g[1/* d */], l__g[4/* not */]));
			}
			break;
		case gml_node.global_hx: ds_list_add(l_actions, gml_action_global_hx(l__g[1/* d */], l__g[2/* name */])); break;
		case gml_node.global_set:
			if (gml_compile_node(l__g[3/* val */], l_actions, true)) return true;
			ds_list_add(l_actions, gml_action_global_set(l__g[1/* d */], l__g[2/* name */]));
			break;
		case gml_node.global_aop:
			if (gml_compile_node(l__g[4/* val */], l_actions, true)) return true;
			ds_list_add(l_actions, gml_action_global_aop(l__g[1/* d */], l__g[3/* op */], l__g[2/* name */]));
			break;
		case gml_node.field:
			var l_x1 = l__g[2/* obj */];
			var l_s = l__g[3/* field */];
			var l_fastGetter = gml_compile_curr_program.h_get_fast_getter(l_s);
			var l__g1 = l_x1;
			switch (l__g1[0]) {
				case gml_node.self_hx: if (l_fastGetter != undefined) ds_list_add(l_actions, gml_action_fast_self_field(l__g[1/* d */], l_fastGetter)); else ds_list_add(l_actions, gml_action_self_field(l__g[1/* d */], l_s)); break;
				case gml_node.local_hx:
					var l_i1 = gml_compile_curr_script.h_local_map[$ l__g1[2/* name */]];
					if (l_fastGetter != undefined) ds_list_add(l_actions, gml_action_fast_local_field(l__g[1/* d */], l_i1, l_fastGetter)); else ds_list_add(l_actions, gml_action_local_field(l__g[1/* d */], l_i1, l_s));
					break;
				default:
					if (gml_compile_node(l_x1, l_actions, true)) return true;
					if (l_fastGetter != undefined) ds_list_add(l_actions, gml_action_call_func1o(l__g[1/* d */], l_fastGetter)); else ds_list_add(l_actions, gml_action_field(l__g[1/* d */], l_s));
			}
			break;
		case gml_node.field_set:
			var l_x1 = l__g[2/* obj */];
			var l_s = l__g[3/* field */];
			var l_fastSetter = gml_compile_curr_program.h_get_fast_setter(l_s);
			var l__g1 = l_x1;
			switch (l__g1[0]) {
				case gml_node.self_hx:
					if (gml_compile_node(l__g[4/* val */], l_actions, true)) return true;
					if (l_fastSetter != undefined) ds_list_add(l_actions, gml_action_fast_self_field_set(l__g[1/* d */], l_fastSetter)); else ds_list_add(l_actions, gml_action_self_field_set(l__g[1/* d */], l_s));
					break;
				case gml_node.local_hx:
					var l_i1 = gml_compile_curr_script.h_local_map[$ l__g1[2/* name */]];
					if (gml_compile_node(l__g[4/* val */], l_actions, true)) return true;
					if (l_fastSetter != undefined) ds_list_add(l_actions, gml_action_fast_local_field_set(l__g[1/* d */], l_i1, l_fastSetter)); else ds_list_add(l_actions, gml_action_local_field_set(l__g[1/* d */], l_i1, l_s));
					break;
				default:
					if (compile_gml_compile_args_proc(l_actions, [l_x1, l__g[4/* val */]])) return true;
					if (l_fastSetter != undefined) ds_list_add(l_actions, gml_action_call_func2(l__g[1/* d */], l_fastSetter)); else ds_list_add(l_actions, gml_action_field_set(l__g[1/* d */], l_s));
			}
			break;
		case gml_node.field_aop:
			var l_x1 = l__g[2/* obj */];
			var l_s = l__g[3/* field */];
			var l_fastGetter = gml_compile_curr_program.h_get_fast_getter(l_s);
			var l_fastSetter = gml_compile_curr_program.h_get_fast_setter_after_getter(l_s);
			var l__g1 = l_x1;
			switch (l__g1[0]) {
				case gml_node.self_hx:
					if (gml_compile_node(l__g[5/* val */], l_actions, true)) return true;
					if (l_fastGetter != undefined && l_fastSetter != undefined) ds_list_add(l_actions, gml_action_fast_self_field_aop(l__g[1/* d */], l__g[4/* op */], l_fastGetter, l_fastSetter)); else ds_list_add(l_actions, gml_action_self_field_aop(l__g[1/* d */], l__g[4/* op */], l_s));
					break;
				case gml_node.local_hx:
					var l_i1 = gml_compile_curr_script.h_local_map[$ l__g1[2/* name */]];
					if (gml_compile_node(l__g[5/* val */], l_actions, true)) return true;
					if (l_fastGetter != undefined && l_fastSetter != undefined) ds_list_add(l_actions, gml_action_fast_local_field_aop(l__g[1/* d */], l_i1, l__g[4/* op */], l_fastGetter, l_fastSetter)); else ds_list_add(l_actions, gml_action_local_field_aop(l__g[1/* d */], l_i1, l__g[4/* op */], l_s));
					break;
				default:
					if (compile_gml_compile_args_proc(l_actions, [l_x1, l__g[5/* val */]])) return true;
					if (l_fastGetter != undefined && l_fastSetter != undefined) ds_list_add(l_actions, gml_action_fast_field_aop(l__g[1/* d */], l__g[4/* op */], l_fastGetter, l_fastSetter)); else ds_list_add(l_actions, gml_action_field_aop(l__g[1/* d */], l__g[4/* op */], l_s));
			}
			break;
		case gml_node.alarm:
			if (compile_gml_compile_args_proc(l_actions, [l__g[2/* obj */], l__g[3/* index */]])) return true;
			ds_list_add(l_actions, gml_action_alarm(l__g[1/* d */]));
			break;
		case gml_node.alarm_set_hx:
			if (compile_gml_compile_args_proc(l_actions, [l__g[2/* obj */], l__g[3/* index */], l__g[4/* val */]])) return true;
			ds_list_add(l_actions, gml_action_alarm_set_hx(l__g[1/* d */]));
			break;
		case gml_node.alarm_aop:
			if (compile_gml_compile_args_proc(l_actions, [l__g[2/* obj */], l__g[3/* index */], l__g[5/* val */]])) return true;
			ds_list_add(l_actions, gml_action_alarm_aop(l__g[1/* d */], l__g[4/* op */]));
			break;
		case gml_node.env: ds_list_add(l_actions, gml_action_env(l__g[1/* d */], l__g[2/* v */].h_func)); break;
		case gml_node.env_set:
			var l_av = l__g[2/* v */];
			if (gml_compile_node(l__g[3/* val */], l_actions, true)) return true;
			ds_list_add(l_actions, gml_action_env_set(l__g[1/* d */], l_av.h_func, l_av.h_type_check));
			break;
		case gml_node.env_aop:
			if (gml_compile_node(l__g[4/* val */], l_actions, true)) return true;
			ds_list_add(l_actions, gml_action_env_aop(l__g[1/* d */], l__g[3/* op */], l__g[2/* v */].h_func));
			break;
		case gml_node.env1d:
			if (gml_compile_node(l__g[3/* index */], l_actions, true)) return true;
			ds_list_add(l_actions, gml_action_env1d(l__g[1/* d */], l__g[2/* v */].h_func));
			break;
		case gml_node.env1d_set:
			var l_av = l__g[2/* v */];
			if (compile_gml_compile_args_proc(l_actions, [l__g[3/* index */], l__g[4/* val */]])) return true;
			ds_list_add(l_actions, gml_action_env1d_set(l__g[1/* d */], l_av.h_func, l_av.h_type_check));
			break;
		case gml_node.env1d_aop:
			if (compile_gml_compile_args_proc(l_actions, [l__g[3/* index */], l__g[5/* val */]])) return true;
			ds_list_add(l_actions, gml_action_env1d_aop(l__g[1/* d */], l__g[4/* op */], l__g[2/* v */].h_func));
			break;
		case gml_node.arg_const: ds_list_add(l_actions, gml_action_arg_const(l__g[1/* d */], l__g[2/* index */])); break;
		case gml_node.arg_index:
			if (gml_compile_node(l__g[2/* index */], l_actions, true)) return true;
			ds_list_add(l_actions, gml_action_arg_index(l__g[1/* d */]));
			break;
		case gml_node.arg_count: ds_list_add(l_actions, gml_action_arg_count(l__g[1/* d */])); break;
		case gml_node.set_op:
			l_d = l__g[1/* d */];
			l_o = l__g[2/* op */];
			l_x = l__g[3/* a */];
			l_x2 = l__g[4/* b */];
			var l__g1 = l_x;
			switch (l__g1[0]) {
				case gml_node.arg_const:
					l_i = l__g1[2/* index */];
					if (gml_compile_node(l_x2, l_actions, true)) return true;
					if (l_o != -1) ds_list_add(l_actions, gml_action_arg_const_aop(l_d, l_o, l_i)); else ds_list_add(l_actions, gml_action_arg_const_set(l_d, l_i));
					break;
				case gml_node.arg_index:
					if (gml_compile_node(l__g1[2/* index */], l_actions, true)) return true;
					if (gml_compile_node(l_x2, l_actions, true)) return true;
					if (l_o != -1) ds_list_add(l_actions, gml_action_arg_index_aop(l_d, l_o)); else ds_list_add(l_actions, gml_action_arg_index_set(l_d));
					break;
				default: return gml_compile_error("Cannot set " + gml_std_Type_enumConstructor(l_x), l_d);
			}
			break;
		case gml_node.bin_op: return compile_gml_compile_bin_op_proc(l_actions, l__g[1/* d */], l__g[2/* op */], l__g[3/* a */], l__g[4/* b */]);
		case gml_node.un_op:
			if (gml_compile_node(l__g[2/* expr */], l_actions, true)) return true;
			ds_list_add(l_actions, gml_action_un_op(l__g[1/* d */], l__g[3/* op */]));
			break;
		case gml_node.prefix: return compile_gml_compile_adjfix_proc(l__g[1/* d */], l__g[2/* expr */], true, l__g[3/* inc */], l_actions, l_out);
		case gml_node.postfix: return compile_gml_compile_adjfix_proc(l__g[1/* d */], l__g[2/* expr */], false, l__g[3/* inc */], l_actions, l_out);
		case gml_node.call_script:
			l_d = l__g[1/* d */];
			l_w = l__g[3/* args */];
			l_n = array_length(l_w);
			for (l_i = 0; l_i < l_n; l_i++) {
				if (gml_compile_node(l_w[l_i], l_actions, true)) return true;
			}
			ds_list_add(l_actions, gml_action_call_script(l_d, gml_compile_curr_program.h_script_map[$ l__g[2/* name */]], l_n));
			if (l_out) ds_list_add(l_actions, gml_action_result(l_d));
			break;
		case gml_node.call_script_id:
			l_d = l__g[1/* d */];
			l_w = l__g[3/* args */];
			l_n = array_length(l_w);
			if (gml_compile_node(l__g[2/* index */], l_actions, true)) return true;
			for (l_i = 0; l_i < l_n; l_i++) {
				if (gml_compile_node(l_w[l_i], l_actions, true)) return true;
			}
			ds_list_add(l_actions, gml_action_call_script_id(l_d, l_n));
			if (l_out) ds_list_add(l_actions, gml_action_result(l_d));
			break;
		case gml_node.call_field:
			l_d = l__g[1/* d */];
			if (gml_compile_node(l__g[2/* obj */], l_actions, true)) return true;
			l_w = l__g[4/* args */];
			l_n = array_length(l_w);
			for (l_i = 0; l_i < l_n; l_i++) {
				gml_compile_node(l_w[l_i], l_actions, true);
			}
			ds_list_add(l_actions, gml_action_call_field(l_d, l__g[3/* field */], l_n));
			if (l_out) ds_list_add(l_actions, gml_action_result(l_d));
			break;
		case gml_node.call_func_at:
			l_d = l__g[1/* d */];
			if (gml_compile_node(l__g[2/* expr */], l_actions, true)) return true;
			l_w = l__g[4/* args */];
			l_n = array_length(l_w);
			for (l_i = 0; l_i < l_n; l_i++) {
				gml_compile_node(l_w[l_i], l_actions, true);
			}
			ds_list_add(l_actions, gml_action_call_field(l_d, l__g[3/* fname */], l_n));
			if (l_out) ds_list_add(l_actions, gml_action_result(l_d));
			break;
		case gml_node.construct:
			l_d = l__g[1/* d */];
			l_w = l__g[3/* args */];
			l_n = array_length(l_w);
			if (gml_compile_node(l__g[2/* ctr */], l_actions, true)) return true;
			for (l_i = 0; l_i < l_n; l_i++) {
				if (gml_compile_node(l_w[l_i], l_actions, true)) return true;
			}
			ds_list_add(l_actions, gml_action_construct(l_d, l_n));
			if (l_out) ds_list_add(l_actions, gml_action_result(l_d));
			break;
		case gml_node.call_script_with_array:
			l_d = l__g[1/* d */];
			if (gml_compile_node(l__g[2/* index */], l_actions, true)) return true;
			if (gml_compile_node(l__g[3/* array */], l_actions, true)) return true;
			ds_list_add(l_actions, gml_action_call_script_with_array(l_d));
			if (l_out) ds_list_add(l_actions, gml_action_result(l_d));
			break;
		case gml_node.call_script_at:
			l_d = l__g[1/* d */];
			return gml_compile_error("dot-calls are currently not supported.", l_d);
		case gml_node.call_func: return compile_gml_compile_call_func_proc(l_actions, l__g[1/* d */], l__g[2/* func */], l__g[3/* args */], l_out);
		case gml_node.func_literal: ds_list_add(l_actions, gml_action_func_literal(l__g[1/* d */], l__g[2/* name */], l__g[3/* unbound */])); break;
		case gml_node.block:
			l_w = l__g[2/* nodes */];
			l_n = array_length(l_w);
			if (l_n > 0) {
				l_n--;
				for (l_i = 0; l_i < l_n; l_i++) {
					if (gml_compile_node(l_w[l_i], l_actions, false)) return true;
				}
				if (gml_compile_node(l_w[l_i], l_actions, l_out)) return true;
			}
			break;
		case gml_node.if_then:
			l_d = l__g[1/* d */];
			l_x = l__g[4/* not */];
			if (gml_compile_node(l__g[2/* cond */], l_actions, true)) return true;
			l_i = ds_list_size(l_actions);
			ds_list_add(l_actions, gml_action_jump_unless(l_d, 0));
			if (gml_compile_node(l__g[3/* then */], l_actions, false)) return true;
			if (l_x != undefined) {
				l_n = ds_list_size(l_actions);
				ds_list_add(l_actions, gml_action_jump(l_d, 0));
				ds_list_set(l_actions, l_i, gml_action_jump_unless(l_d, ds_list_size(l_actions)));
				if (gml_compile_node(l_x, l_actions, false)) return true;
				ds_list_set(l_actions, l_n, gml_action_jump(l_d, ds_list_size(l_actions)));
			} else ds_list_set(l_actions, l_i, gml_action_jump_unless(l_d, ds_list_size(l_actions)));
			break;
		case gml_node.ternary:
			l_d = l__g[1/* d */];
			if (gml_compile_node(l__g[2/* cond */], l_actions, true)) return true;
			l_i = ds_list_size(l_actions);
			ds_list_add(l_actions, gml_action_jump_unless(l_d, 0));
			if (gml_compile_node(l__g[3/* then */], l_actions, l_out)) return true;
			l_n = ds_list_size(l_actions);
			ds_list_add(l_actions, gml_action_jump(l_d, 0));
			ds_list_set(l_actions, l_i, gml_action_jump_unless(l_d, ds_list_size(l_actions)));
			if (gml_compile_node(l__g[4/* not */], l_actions, l_out)) return true;
			ds_list_set(l_actions, l_n, gml_action_jump(l_d, ds_list_size(l_actions)));
			break;
		case gml_node.null_co:
			l_d = l__g[1/* d */];
			if (gml_compile_node(l__g[2/* a */], l_actions, true)) return true;
			l_i = ds_list_size(l_actions);
			ds_list_add(l_actions, gml_action_jump_placeholder(l_d));
			if (gml_compile_node(l__g[3/* b */], l_actions, true)) return true;
			ds_list_set(l_actions, l_i, gml_action_null_co(l_d, ds_list_size(l_actions)));
			if (!l_out) ds_list_add(l_actions, gml_action_discard(l_d));
			break;
		case gml_node.repeat_hx:
			l_d = l__g[1/* d */];
			if (gml_compile_node(l__g[2/* times */], l_actions, true)) return true;
			l_n = ds_list_size(l_actions);
			ds_list_add(l_actions, gml_action_repeat_pre(l_d, 0));
			l_p0 = ds_list_size(l_actions);
			l_pc = gml_compile_curr_continue;
			l_pb = gml_compile_curr_break;
			gml_compile_curr_continue = l_p0;
			gml_compile_curr_break = l_p0;
			if (gml_compile_node(l__g[3/* loop */], l_actions, false)) return true;
			gml_compile_curr_continue = l_pc;
			gml_compile_curr_break = l_pb;
			l_p1 = ds_list_size(l_actions);
			ds_list_add(l_actions, gml_action_repeat_jump(l_d, l_p0));
			l_p2 = ds_list_size(l_actions);
			ds_list_add(l_actions, gml_action_discard(l_d));
			for (l_k = l_p0; l_k < l_p2; l_k++) {
				var l__g1 = ds_list_find_value(l_actions, l_k);
				switch (l__g1.__enumIndex__/* gml_action */) {
					case 105/* continue_hx */: if (l__g1.h_lp == l_p0) ds_list_set(l_actions, l_k, gml_action_jump(l__g1.h_d, l_p1)); break;
					case 104/* break_hx */: if (l__g1.h_lp == l_p0) ds_list_set(l_actions, l_k, gml_action_jump(l__g1.h_d, l_p2)); break;
				}
			}
			ds_list_set(l_actions, l_n, gml_action_repeat_pre(l_d, ds_list_size(l_actions)));
			break;
		case gml_node.while_hx:
			l_d = l__g[1/* d */];
			l_p0 = ds_list_size(l_actions);
			if (gml_compile_node(l__g[2/* cond */], l_actions, true)) return true;
			l_p1 = ds_list_size(l_actions);
			ds_list_add(l_actions, gml_action_jump_unless(l_d, 0));
			l_pc = gml_compile_curr_continue;
			l_pb = gml_compile_curr_break;
			gml_compile_curr_continue = l_p0;
			gml_compile_curr_break = l_p0;
			if (gml_compile_node(l__g[3/* loop */], l_actions, false)) return true;
			gml_compile_curr_continue = l_pc;
			gml_compile_curr_break = l_pb;
			ds_list_add(l_actions, gml_action_jump(l_d, l_p0));
			l_p2 = ds_list_size(l_actions);
			ds_list_set(l_actions, l_p1, gml_action_jump_unless(l_d, l_p2));
			for (l_k = l_p1; l_k < l_p2; l_k++) {
				var l__g1 = ds_list_find_value(l_actions, l_k);
				switch (l__g1.__enumIndex__/* gml_action */) {
					case 105/* continue_hx */: if (l__g1.h_lp == l_p0) ds_list_set(l_actions, l_k, gml_action_jump(l__g1.h_d, l_p0)); break;
					case 104/* break_hx */: if (l__g1.h_lp == l_p0) ds_list_set(l_actions, l_k, gml_action_jump(l__g1.h_d, l_p2)); break;
				}
			}
			break;
		case gml_node.do_until:
			l_d = l__g[1/* d */];
			l_p0 = ds_list_size(l_actions);
			l_pc = gml_compile_curr_continue;
			l_pb = gml_compile_curr_break;
			gml_compile_curr_continue = l_p0;
			gml_compile_curr_break = l_p0;
			if (gml_compile_node(l__g[2/* loop */], l_actions, false)) return true;
			gml_compile_curr_continue = l_pc;
			gml_compile_curr_break = l_pb;
			l_p1 = ds_list_size(l_actions);
			if (gml_compile_node(l__g[3/* cond */], l_actions, true)) return true;
			var l__g1 = l_q;
			if ((l__g1[0] == 102)) ds_list_add(l_actions, gml_action_jump_unless(l_d, l_p0)); else ds_list_add(l_actions, gml_action_jump_if(l_d, l_p0));
			l_p2 = ds_list_size(l_actions);
			for (l_k = l_p0; l_k < l_p1; l_k++) {
				var l__g1 = ds_list_find_value(l_actions, l_k);
				switch (l__g1.__enumIndex__/* gml_action */) {
					case 105/* continue_hx */: if (l__g1.h_lp == l_p0) ds_list_set(l_actions, l_k, gml_action_jump(l__g1.h_d, l_p1)); break;
					case 104/* break_hx */: if (l__g1.h_lp == l_p0) ds_list_set(l_actions, l_k, gml_action_jump(l__g1.h_d, l_p2)); break;
				}
			}
			break;
		case gml_node.do_while:
			l_d = l__g[1/* d */];
			l_p0 = ds_list_size(l_actions);
			l_pc = gml_compile_curr_continue;
			l_pb = gml_compile_curr_break;
			gml_compile_curr_continue = l_p0;
			gml_compile_curr_break = l_p0;
			if (gml_compile_node(l__g[2/* loop */], l_actions, false)) return true;
			gml_compile_curr_continue = l_pc;
			gml_compile_curr_break = l_pb;
			l_p1 = ds_list_size(l_actions);
			if (gml_compile_node(l__g[3/* cond */], l_actions, true)) return true;
			var l__g1 = l_q;
			if ((l__g1[0] == 102)) ds_list_add(l_actions, gml_action_jump_unless(l_d, l_p0)); else ds_list_add(l_actions, gml_action_jump_if(l_d, l_p0));
			l_p2 = ds_list_size(l_actions);
			for (l_k = l_p0; l_k < l_p1; l_k++) {
				var l__g1 = ds_list_find_value(l_actions, l_k);
				switch (l__g1.__enumIndex__/* gml_action */) {
					case 105/* continue_hx */: if (l__g1.h_lp == l_p0) ds_list_set(l_actions, l_k, gml_action_jump(l__g1.h_d, l_p1)); break;
					case 104/* break_hx */: if (l__g1.h_lp == l_p0) ds_list_set(l_actions, l_k, gml_action_jump(l__g1.h_d, l_p2)); break;
				}
			}
			break;
		case gml_node.for_hx:
			l_d = l__g[1/* d */];
			if (gml_compile_node(l__g[2/* pre */], l_actions, false)) return true;
			l_p0 = ds_list_size(l_actions);
			if (gml_compile_node(l__g[3/* cond */], l_actions, true)) return true;
			l_p1 = ds_list_size(l_actions);
			ds_list_add(l_actions, gml_action_jump_unless(l_d, 0));
			l_pc = gml_compile_curr_continue;
			l_pb = gml_compile_curr_break;
			gml_compile_curr_continue = l_p0;
			gml_compile_curr_break = l_p0;
			if (gml_compile_node(l__g[5/* loop */], l_actions, false)) return true;
			gml_compile_curr_continue = l_pc;
			gml_compile_curr_break = l_pb;
			l_p2 = ds_list_size(l_actions);
			l_pb = gml_compile_curr_break;
			gml_compile_curr_break = l_p0;
			if (gml_compile_node(l__g[4/* post */], l_actions, false)) return true;
			gml_compile_curr_break = l_pb;
			ds_list_add(l_actions, gml_action_jump(l_d, l_p0));
			l_p3 = ds_list_size(l_actions);
			ds_list_set(l_actions, l_p1, gml_action_jump_unless(l_d, l_p3));
			for (l_k = l_p1; l_k < l_p3; l_k++) {
				var l__g1 = ds_list_find_value(l_actions, l_k);
				switch (l__g1.__enumIndex__/* gml_action */) {
					case 105/* continue_hx */: if (l__g1.h_lp == l_p0) ds_list_set(l_actions, l_k, gml_action_jump(l__g1.h_d, l_p2)); break;
					case 104/* break_hx */: if (l__g1.h_lp == l_p0) ds_list_set(l_actions, l_k, gml_action_jump(l__g1.h_d, l_p3)); break;
				}
			}
			break;
		case gml_node.switch_hx:
			var l__cc = l__g[3/* cases */];
			l_d = l__g[1/* d */];
			var l_jt = ds_map_create();
			if (gml_compile_node(l__g[2/* expr */], l_actions, true)) return true;
			l_p0 = ds_list_size(l_actions);
			l_n = array_length(l__cc);
			for (l_i = 0; l_i < l_n; l_i++) {
				var l__cv = l__cc[l_i].values;
				l_z = array_length(l__cv);
				for (l_k = 0; l_k < l_z; l_k++) {
					if (gml_node_tools_to_case_value(l__cv[l_k]) == undefined) break;
				}
				if (l_k < l_z) break;
			}
			if (l_i < l_n) {
				var l_caseLabels = [];
				l_pb = gml_compile_curr_break;
				gml_compile_curr_break = l_p0;
				for (l_i = 0; l_i < l_n; l_i++) {
					var l__cv = l__cc[l_i].values;
					l_z = array_length(l__cv);
					var l_cl1 = [];
					for (l_k = 0; l_k < l_z; l_k++) {
						if (gml_compile_node(l__cv[l_k], l_actions, true)) return true;
						l_cl1[@l_k] = ds_list_size(l_actions);
						ds_list_add(l_actions, gml_action_switch_case(l_d, 0));
					}
					l_caseLabels[@l_i] = l_cl1;
				}
				ds_list_add(l_actions, gml_action_discard(l_d));
				var l_defCasePos = ds_list_size(l_actions);
				ds_list_add(l_actions, gml_action_jump(l_d, 0));
				for (l_i = 0; l_i < l_n; l_i++) {
					var l_cl1 = l_caseLabels[l_i];
					l_z = array_length(l_cl1);
					for (l_k = 0; l_k < l_z; l_k++) {
						ds_list_set(l_actions, l_cl1[l_k], gml_action_switch_case(l_d, ds_list_size(l_actions)));
					}
					if (gml_compile_node(l__cc[l_i].expr, l_actions, false)) return true;
				}
				ds_list_set(l_actions, l_defCasePos, gml_action_jump(l_d, ds_list_size(l_actions)));
				l_x = l__g[4/* def */];
				if (l_x != undefined) {
					if (gml_compile_node(l_x, l_actions, false)) return true;
				}
				gml_compile_curr_break = l_pb;
			} else {
				ds_list_add(l_actions, gml_action_switch_hx(l_d, l_jt, 0));
				l_pb = gml_compile_curr_break;
				gml_compile_curr_break = l_p0;
				l_n = array_length(l__cc);
				for (l_i = 0; l_i < l_n; l_i++) {
					var l__cv = l__cc[l_i].values;
					l_z = array_length(l__cv);
					for (l_k = 0; l_k < l_z; l_k++) {
						ds_map_set(l_jt, gml_node_tools_to_case_value(l__cv[l_k]), ds_list_size(l_actions));
					}
					if (gml_compile_node(l__cc[l_i].expr, l_actions, false)) return true;
				}
				l_p1 = ds_list_size(l_actions);
				l_x = l__g[4/* def */];
				if (l_x != undefined) {
					if (gml_compile_node(l_x, l_actions, false)) return true;
				}
				gml_compile_curr_break = l_pb;
				ds_list_set(l_actions, l_p0, gml_action_switch_hx(l_d, l_jt, l_p1));
			}
			l_p2 = ds_list_size(l_actions);
			for (l_k = l_p0; l_k < l_p2; l_k++) {
				var l__g1 = ds_list_find_value(l_actions, l_k);
				if (l__g1.__enumIndex__/* gml_action */ == 104/* break_hx */) {
					var l_d1 = l__g1.h_d;
					if (l__g1.h_lp == l_p0) ds_list_set(l_actions, l_k, gml_action_jump(l_d1, l_p2));
				}
			}
			break;
		case gml_node.with_hx:
			l_d = l__g[1/* d */];
			if (gml_compile_node(l__g[2/* ctx */], l_actions, true)) return true;
			ds_list_add(l_actions, gml_action_with_pre(l_d));
			l_p0 = ds_list_size(l_actions);
			ds_list_add(l_actions, gml_action_with_next(l_d, 0));
			l_pc = gml_compile_curr_continue;
			l_pb = gml_compile_curr_break;
			gml_compile_curr_continue = l_p0;
			gml_compile_curr_break = l_p0;
			if (gml_compile_node(l__g[3/* loop */], l_actions, false)) return true;
			gml_compile_curr_continue = l_pc;
			gml_compile_curr_break = l_pb;
			ds_list_add(l_actions, gml_action_jump(l_d, l_p0));
			l_p1 = ds_list_size(l_actions);
			ds_list_add(l_actions, gml_action_with_post(l_d));
			ds_list_set(l_actions, l_p0, gml_action_with_next(l_d, l_p1));
			for (l_k = l_p0; l_k < l_p1; l_k++) {
				var l__g1 = ds_list_find_value(l_actions, l_k);
				switch (l__g1.__enumIndex__/* gml_action */) {
					case 105/* continue_hx */: if (l__g1.h_lp == l_p0) ds_list_set(l_actions, l_k, gml_action_jump(l__g1.h_d, l_p0)); break;
					case 104/* break_hx */: if (l__g1.h_lp == l_p0) ds_list_set(l_actions, l_k, gml_action_jump(l__g1.h_d, l_p1)); break;
				}
			}
			break;
		case gml_node.try_catch:
			l_d = l__g[1/* d */];
			l_p0 = ds_list_size(l_actions);
			ds_list_add(l_actions, gml_action_try_hx(l_d, 0));
			if (gml_compile_node(l__g[2/* block */], l_actions, false)) return true;
			l_p1 = ds_list_size(l_actions);
			ds_list_add(l_actions, gml_action_finally_hx(l_d, 0));
			ds_list_set(l_actions, l_p0, gml_action_try_hx(l_d, ds_list_size(l_actions)));
			ds_list_add(l_actions, gml_action_catch_hx(l_d, gml_compile_curr_script.h_local_map[$ l__g[3/* capvar */]]));
			if (gml_compile_node(l__g[4/* catcher */], l_actions, false)) return true;
			ds_list_set(l_actions, l_p1, gml_action_finally_hx(l_d, ds_list_size(l_actions)));
			break;
		case gml_node.throw_hx:
			if (gml_compile_node(l__g[2/* err */], l_actions, true)) return true;
			ds_list_add(l_actions, gml_action_throw_hx(l__g[1/* d */]));
			break;
		case gml_node.break_hx:
			l_d = l__g[1/* d */];
			l_i = gml_compile_curr_break;
			if (l_i >= 0) ds_list_add(l_actions, gml_action_break_hx(l_d, l_i)); else return gml_compile_error("Cannot `break` here", l_d);
			break;
		case gml_node.continue_hx:
			l_d = l__g[1/* d */];
			l_i = gml_compile_curr_continue;
			if (l_i >= 0) ds_list_add(l_actions, gml_action_continue_hx(l_d, l_i)); else return gml_compile_error("Cannot `continue` here", l_d);
			break;
		case gml_node.return_hx:
			if (gml_compile_node(l__g[2/* val */], l_actions, true)) return true;
			ds_list_add(l_actions, gml_action_return_hx(l__g[1/* d */]));
			break;
		case gml_node.exit_hx:
			l_d = l__g[1/* d */];
			ds_list_add(l_actions, gml_action_return_const(l_d, gml_compile_curr_program.h_get_source(l_d[0/* src */]).h_version.h_default_ret_value));
			break;
		case gml_node.wait:
			if (gml_compile_node(l__g[2/* time */], l_actions, true)) return true;
			ds_list_add(l_actions, gml_action_wait(l__g[1/* d */]));
			break;
		case gml_node.delete_hx: if (compile_gml_compile_delete_proc(l_actions, l__g[1/* d */], l__g[2/* expr */])) return true; break;
		case gml_node.fork: ds_list_add(l_actions, gml_action_fork(l__g[1/* d */], l_out)); break;
		default: return gml_compile_error("Cannot compile " + gml_std_Type_enumConstructor(l_q), gml_std_haxe_enum_tools_getParameter(l_q, 0));
	}
	return false;
}

if (live_enabled) 
function gml_compile_add_exit(l_actions) {
	// gml_compile_add_exit(actions:gml_action_list)
	/// @ignore
	gml_compile_node([gml_node.exit_hx, gml_compile_curr_script.h_pos], l_actions, false);
}

if (live_enabled) 
function gml_compile_script(l_q) {
	// gml_compile_script(q:gml_script)->bool
	/// @ignore
	var l_actions = ds_list_create();
	l_q.h_actions = l_actions;
	gml_compile_curr_script = l_q;
	gml_compile_curr_break = -1;
	gml_compile_curr_continue = -1;
	var l_trouble;
	l_trouble = compile_groups_gml_compile_group_static_proc_static_init(l_actions);
	if (!l_trouble) l_trouble = gml_compile_node(l_q.h_node, l_actions, false);
	if (!l_trouble) gml_compile_add_exit(l_actions);
	if (!l_trouble) {
		var l_i = 0;
		for (var l__g1 = ds_list_size(l_actions); l_i < l__g1; l_i++) {
			var l_a = ds_list_find_value(l_actions, l_i);
			if (l_a.__enumIndex__/* gml_action */ == 123/* closure */) l_a.__func__ = l_a.h_fn; else l_a.__func__ = vm_v2_gml_thread_v2_handlers[l_a.__enumIndex__];
		}
	}
	gml_compile_curr_script = undefined;
	return l_trouble;
}

if (live_enabled) 
function gml_compile_program(l_p) {
	// gml_compile_program(p:gml_program)->bool
	/// @ignore
	gml_compile_curr_program = l_p;
	var l_arr = l_p.h_script_array;
	var l_i;
	var l_num = array_length(l_arr);
	for (l_i = 0; l_i < l_num; l_i++) {
		if (gml_compile_script(l_arr[l_i])) break;
	}
	gml_compile_curr_program = undefined;
	return l_i < l_num;
}

#endregion
