// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.
// Feather disable all

// Helpers for AST nodes
#region gml.node_tools

if (live_enabled) 
function gml_node_tools_unpack(l_q) {
	// gml_node_tools_unpack(q:ast_GmlNode)->ast_GmlNode
	/// @ignore
	while (l_q != undefined) {
		var l__g = l_q;
		if (l__g[0]/* gml_node */ == gml_node.block) {
			var l__g2 = l__g[2/* nodes */];
			if (array_length(l__g2) == 1) l_q = l__g2[0]; else return l_q;
		} else return l_q;
	}
	return l_q;
}

if (live_enabled) 
function gml_node_tools_is_statement(l_q) {
	// gml_node_tools_is_statement(q:ast_GmlNode)->bool
	/// @ignore
	switch (l_q[0]) {
		case gml_node.call: return true;
		case gml_node.set_op: return true;
		case gml_node.var_decl: return true;
		case gml_node.prefix: return true;
		case gml_node.postfix: return true;
		case gml_node.block: return true;
		case gml_node.if_then: return true;
		case gml_node.switch_hx: return true;
		case gml_node.for_hx: return true;
		case gml_node.while_hx: return true;
		case gml_node.repeat_hx: return true;
		case gml_node.do_while: return true;
		case gml_node.do_until: return true;
		case gml_node.with_hx: return true;
		case gml_node.break_hx: return true;
		case gml_node.continue_hx: return true;
		case gml_node.exit_hx: return true;
		case gml_node.return_hx: return true;
		case gml_node.wait: return true;
		case gml_node.debugger: return true;
		case gml_node.try_catch: return true;
		case gml_node.throw_hx: return true;
		default: return false;
	}
}

if (live_enabled) 
function gml_node_tools_is_in_block(l_q, l_p) {
	// gml_node_tools_is_in_block(q:ast_GmlNode, p:ast_GmlNode)->bool
	/// @ignore
	if (l_p == undefined || l_q == undefined) return false;
	var l__g = l_p;
	switch (l__g[0]) {
		case gml_node.block: return true;
		case gml_node.if_then: if (l_q != l__g[3/* then */]) return l_q == l__g[4/* not */]; else return true;
		case gml_node.while_hx: return l_q == l__g[3/* loop */];
		case gml_node.do_while: return l_q == l__g[2/* loop */];
		case gml_node.do_until: return l_q == l__g[2/* loop */];
		case gml_node.repeat_hx: return l_q == l__g[3/* loop */];
		case gml_node.with_hx: return l_q == l__g[3/* loop */];
		case gml_node.for_hx: return (l_q == l__g[2/* pre */] || l_q == l__g[4/* post */]) || l_q == l__g[5/* loop */];
		case gml_node.switch_hx:
			var l__cases = l__g[3/* cases */];
			if (l_q == l__g[4/* def */]) return true;
			var l_i = 0;
			for (var l__g2 = array_length(l__cases); l_i < l__g2; l_i++) {
				if (l__cases[l_i].expr == l_q) return true;
			}
			return false;
		case gml_node.try_catch: return l_q == l__g[2/* block */];
		default: return false;
	}
}

if (live_enabled) 
function gml_node_tools_to_case_value(l_q) {
	// gml_node_tools_to_case_value(q:ast_GmlNode)->any
	/// @ignore
	var l__g = l_q;
	switch (l__g[0]) {
		case gml_node.number:
			var l_f = l__g[2/* value */];
			if (is_real(l_f) && sign(frac(l_f)) != 0) return undefined;
			if (int64(l_f) != l_f) return undefined;
			return l_f;
		case gml_node.cstring: return l__g[2/* value */];
		case gml_node.enum_ctr: return l__g[3/* ctr */].h_value;
		default: return undefined;
	}
}

if (live_enabled) 
function gml_node_tools_equals_list(l_a, l_b) {
	// gml_node_tools_equals_list(a:array<ast_GmlNode>, b:array<ast_GmlNode>)->bool
	/// @ignore
	var l_n = array_length(l_a);
	if (array_length(l_b) != l_n) return false;
	var l_i = 0;
	while (l_i < l_n) {
		if (gml_node_tools_equals(l_a[l_i], l_b[l_i])) l_i++; else return false;
	}
	return true;
}

if (live_enabled) 
function gml_node_tools_equals_lf(l__, l_av, l_bv, l_ip) {
	// gml_node_tools_equals_lf(_:int, av:any, bv:any, ip:ast_gml_node_def_param)->bool
	/// @ignore
	var l_tmp;
	switch (l_ip.h_type) {
		case 0: l_tmp = gml_node_tools_equals(l_av, l_bv); break;
		case 13: l_tmp = l_av == l_bv; break;
		case 1: l_tmp = gml_node_tools_equals_list(l_av, l_bv); break;
		case 5: case 6: case 7: l_tmp = l_av == l_bv; break;
		case 10: case 11: case 12: l_tmp = l_av == l_bv; break;
		case 8: case 9: l_tmp = l_av == l_bv; break;
		case 14: return array_equals(l_av, l_bv);
		case 4:
			var l_cca = l_av;
			var l_ccb = l_bv;
			var l_n = array_length(l_cca);
			var l_i = -1;
			var l_ok = l_n == array_length(l_ccb);
			if (l_ok) while (++l_i < l_n) {
				if (!gml_node_tools_equals(l_cca[l_i].expr, l_ccb[l_i].expr)) {
					l_ok = false;
					break;
				}
				if (!gml_node_tools_equals_list(l_cca[l_i].values, l_ccb[l_i].values)) {
					l_ok = false;
					break;
				}
			}
			l_tmp = l_ok;
			break;
		default: l_tmp = true;
	}
	return !l_tmp;
}

if (live_enabled) 
function gml_node_tools_equals(l_a, l_b) {
	// gml_node_tools_equals(a:ast_GmlNode, b:ast_GmlNode)->bool
	/// @ignore
	if (l_a == undefined) return l_b == undefined;
	if (l_b == undefined) return false;
	if (l_a[0] != l_b[0]) return false;
	var l_params = ast_gml_node_def_info_array[gml_std_Type_enumIndex(l_a)].h_params;
	var l_result = false;
	var l_i = 0;
	for (var l__g1 = array_length(l_params); l_i < l__g1; l_i++) {
		if (gml_node_tools_equals_lf(l_i, l_a[l_i + 1], l_b[l_i + 1], l_params[l_i])) {
			l_result = true;
			break;
		}
	}
	return !l_result;
}

if (live_enabled) 
function gml_node_tools_clone_list(l__arr) {
	// gml_node_tools_clone_list(_arr:array<ast_GmlNode>)->array<ast_GmlNode>
	/// @ignore
	if (l__arr == undefined) return undefined;
	var l_arr = gml_std_gml_internal_ArrayImpl_copy(l__arr);
	var l_i = array_length(l_arr);
	while (--l_i >= 0) {
		l_arr[@l_i] = gml_node_tools_clone(l_arr[l_i]);
	}
	return l_arr;
}

if (live_enabled) 
function gml_node_tools_clone_case(l_cc0) {
	// gml_node_tools_clone_case(cc:ast_GmlNodeCase)->ast_GmlNodeCase
	/// @ignore
	return { values: gml_node_tools_clone_list(l_cc0.values), expr: gml_node_tools_clone(l_cc0.expr), pre: gml_node_tools_clone_list(l_cc0.pre) }
}

if (live_enabled) 
function gml_node_tools_clone(l_q) {
	// gml_node_tools_clone(q:ast_GmlNode)->ast_GmlNode
	/// @ignore
	if (l_q == undefined) return undefined;
	var l_ndef = gml_std_gml_internal_ArrayImpl_concatFront(gml_std_Type_enumParameters(l_q), gml_std_Type_enumIndex(l_q));
	var l_params = ast_gml_node_def_info_array[gml_std_Type_enumIndex(l_q)].h_params;
	var l_i = 0;
	for (var l__g1 = array_length(l_params); l_i < l__g1; l_i++) {
		var l_v = l_ndef[l_i + 1];
		var l_val;
		switch (l_params[l_i].h_type) {
			case 2: l_val = l_v; break;
			case 8: case 9: l_val = l_v; break;
			case 13: l_val = l_v; break;
			case 14: l_val = gml_std_gml_internal_ArrayImpl_copy(l_v); break;
			case 1: l_val = gml_node_tools_clone_list(l_v); break;
			case 0: l_val = gml_node_tools_clone(l_v); break;
			case 5: case 6: case 7: l_val = l_v; break;
			case 10: case 11: case 12: l_val = l_v; break;
			case 3: l_val = gml_node_tools_clone_case(l_v); break;
			case 4:
				var l_cc = gml_std_gml_internal_ArrayImpl_copy(l_v);
				var l_i1 = array_length(l_cc);
				while (--l_i1 >= 0) {
					l_cc[@l_i1] = gml_node_tools_clone_case(l_cc[l_i1]);
				}
				l_val = l_cc;
				break;
		}
		l_ndef[@l_i + 1] = l_val;
	}
	return l_ndef;
}

if (live_enabled) 
function gml_node_tools_seek_all_out(l_q, l_st, l_c, l_si, l_pg) {
	// gml_node_tools_seek_all_out(q:ast_GmlNode, st:tools_ArrayList<ast_GmlNode>, c:ast_GmlNodeIter, si:int, pg:gml_program)->bool
	/// @ignore
	var l_w, l_i;
	var l_par = ds_list_find_value(l_st, l_si);
	if (l_par == undefined) return false;
	var l__g = l_par;
	switch (l__g[0]) {
		case gml_node.block:
			l_w = l__g[2/* nodes */];
			l_i = array_length(l_w);
			while (--l_i >= 0) {
				if (l_w[l_i] == l_q) break;
			}
			while (--l_i >= 0) {
				if (l_c(l_w[l_i], undefined)) return true;
			}
			break;
		case gml_node.if_then:
			var l_c1 = l__g[2/* cond */];
			if (l_c1 != l_q && l_c(l_c1, undefined)) return true;
			break;
		case gml_node.while_hx:
			var l_c1 = l__g[2/* cond */];
			if (l_c1 != l_q && l_c(l_c1, undefined)) return true;
			break;
		case gml_node.do_while:
			var l_c1 = l__g[2/* loop */];
			if (l_c1 != l_q && l_c(l_c1, undefined)) return true;
			break;
		case gml_node.do_until:
			var l_c1 = l__g[2/* loop */];
			if (l_c1 != l_q && l_c(l_c1, undefined)) return true;
			break;
		case gml_node.repeat_hx:
			var l_c1 = l__g[2/* times */];
			if (l_c1 != l_q && l_c(l_c1, undefined)) return true;
			break;
		case gml_node.for_hx:
			var l_c1 = l__g[2/* pre */];
			if (l_c1 != l_q && l_c(l_c1, undefined)) return true;
			break;
		case gml_node.switch_hx:
			var l_c1 = l__g[2/* expr */];
			if (l_c1 != l_q && l_c(l_c1, undefined)) return true;
			break;
		case gml_node.with_hx:
			var l_c1 = l__g[2/* ctx */];
			if (l_c1 != l_q && l_c(l_c1, undefined)) return true;
			break;
		default: throw gml_std_haxe_Exception_thrown("Can't seekAllOut over " + ast_gml_node_tools_ni_get_pos_string(l_par, l_pg) + " " + gml_std_Type_enumConstructor(l_par));
	}
	return gml_node_tools_seek_all_out(l_par, l_st, l_c, l_si + 1, l_pg);
}

if (live_enabled) 
function gml_node_tools_seek_arr(l_arr, l_fn, l_st) {
	// gml_node_tools_seek_arr(arr:array<ast_GmlNode>, fn:ast_GmlNodeIter, st:tools_ArrayList<ast_GmlNode>)->bool
	/// @ignore
	var l_i = 0;
	for (var l__g1 = array_length(l_arr); l_i < l__g1; l_i++) {
		if (l_fn(l_arr[l_i], undefined)) return true;
	}
	return false;
}

if (live_enabled) 
function gml_node_tools_seek_or2(l_a, l_b, l_fn, l_st) {
	// gml_node_tools_seek_or2(a:ast_GmlNode, b:ast_GmlNode, fn:ast_GmlNodeIter, st:tools_ArrayList<ast_GmlNode>)->bool
	/// @ignore
	return l_fn(l_a, undefined) || l_fn(l_b, undefined);
}

if (live_enabled) 
function gml_node_tools_seek_or3(l_a, l_b, l_c, l_fn, l_st) {
	// gml_node_tools_seek_or3(a:ast_GmlNode, b:ast_GmlNode, c:ast_GmlNode, fn:ast_GmlNodeIter, st:tools_ArrayList<ast_GmlNode>)->bool
	/// @ignore
	return (l_fn(l_a, undefined) || l_fn(l_b, undefined)) || l_fn(l_c, undefined);
}

if (live_enabled) 
function gml_node_tools_seek_or4(l_a, l_b, l_c, l_d, l_fn, l_st) {
	// gml_node_tools_seek_or4(a:ast_GmlNode, b:ast_GmlNode, c:ast_GmlNode, d:ast_GmlNode, fn:ast_GmlNodeIter, st:tools_ArrayList<ast_GmlNode>)->bool
	/// @ignore
	return (l_fn(l_a, undefined) || l_fn(l_b, undefined) || l_fn(l_c, undefined)) || l_fn(l_d, undefined);
}

if (live_enabled) 
function gml_node_tools_seek_1or_arr(l_a, l_arr, l_fn, l_st) {
	// gml_node_tools_seek_1or_arr(a:ast_GmlNode, arr:array<ast_GmlNode>, fn:ast_GmlNodeIter, st:tools_ArrayList<ast_GmlNode>)->bool
	/// @ignore
	if (l_fn(l_a, undefined)) return true;
	var l_i = 0;
	for (var l__g1 = array_length(l_arr); l_i < l__g1; l_i++) {
		if (l_fn(l_arr[l_i], undefined)) return true;
	}
	return false;
}

if (live_enabled) 
function gml_node_tools_seek_all(l_q, l_st, l_c, l_pg) {
	// gml_node_tools_seek_all(q:ast_GmlNode, st:tools_ArrayList<ast_GmlNode>, c:ast_GmlNodeIter, pg:gml_program)->bool
	/// @ignore
	if (l_st != undefined) ds_list_insert(l_st, 0, l_q);
	var l_r = false;
	var l_x, l_w, l_i, l_n;
	var l_trouble = false;
	var l__g = l_q;
	switch (l__g[0]) {
		case gml_node.ensure_array_for_field: l_r = l_c(l__g[2/* obj */], undefined); break;
		case gml_node.arg_index: l_r = l_c(l__g[2/* index */], undefined); break;
		case gml_node.prefix: l_r = l_c(l__g[2/* expr */], undefined); break;
		case gml_node.postfix: l_r = l_c(l__g[2/* expr */], undefined); break;
		case gml_node.delete_hx: l_r = l_c(l__g[2/* expr */], undefined); break;
		case gml_node.to_bool: l_r = l_c(l__g[2/* val */], undefined); break;
		case gml_node.from_bool: l_r = l_c(l__g[2/* val */], undefined); break;
		case gml_node.local_set: l_r = l_c(l__g[3/* val */], undefined); break;
		case gml_node.local_aop: l_r = l_c(l__g[4/* val */], undefined); break;
		case gml_node.static_set: l_r = l_c(l__g[3/* val */], undefined); break;
		case gml_node.static_aop: l_r = l_c(l__g[4/* val */], undefined); break;
		case gml_node.global_set: l_r = l_c(l__g[3/* val */], undefined); break;
		case gml_node.global_aop: l_r = l_c(l__g[4/* val */], undefined); break;
		case gml_node.script_static_set: l_r = l_c(l__g[4/* val */], undefined); break;
		case gml_node.script_static_aop: l_r = l_c(l__g[5/* val */], undefined); break;
		case gml_node.env_set: l_r = l_c(l__g[3/* val */], undefined); break;
		case gml_node.env_aop: l_r = l_c(l__g[4/* val */], undefined); break;
		case gml_node.wait: l_r = l_c(l__g[2/* time */], undefined); break;
		case gml_node.once: l_r = l_c(l__g[2/* loop */], undefined); break;
		case gml_node.return_hx: l_r = l_c(l__g[2/* val */], undefined); break;
		case gml_node.throw_hx: l_r = l_c(l__g[2/* err */], undefined); break;
		case gml_node.undefined_hx: l_r = false; break;
		case gml_node.boolean: l_r = false; break;
		case gml_node.number: l_r = false; break;
		case gml_node.cstring: l_r = false; break;
		case gml_node.other_const: l_r = false; break;
		case gml_node.enum_ctr: l_r = false; break;
		case gml_node.ensure_array_for_local: l_r = false; break;
		case gml_node.ensure_array_for_global: l_r = false; break;
		case gml_node.ident: l_r = false; break;
		case gml_node.self_hx: l_r = false; break;
		case gml_node.other_hx: l_r = false; break;
		case gml_node.global_ref: l_r = false; break;
		case gml_node.script: l_r = false; break;
		case gml_node.native_script: l_r = false; break;
		case gml_node.const: l_r = false; break;
		case gml_node.arg_const: l_r = false; break;
		case gml_node.arg_count: l_r = false; break;
		case gml_node.func_literal: l_r = false; break;
		case gml_node.local_hx: l_r = false; break;
		case gml_node.static_hx: l_r = false; break;
		case gml_node.global_hx: l_r = false; break;
		case gml_node.script_static: l_r = false; break;
		case gml_node.env: l_r = false; break;
		case gml_node.fork: l_r = false; break;
		case gml_node.exit_hx: l_r = false; break;
		case gml_node.break_hx: l_r = false; break;
		case gml_node.continue_hx: l_r = false; break;
		case gml_node.debugger: l_r = false; break;
		case gml_node.bin_op:
			switch (l__g[2/* op */]) {
				case 80:
					var l_a = l__g[3/* a */];
					var l_b = l__g[4/* b */];
					l_r = l_c(l_a, undefined) && l_c(l_b, undefined);
					break;
				case 96: l_r = l_c(l__g[3/* a */], undefined); break;
				default: l_r = gml_node_tools_seek_or2(l__g[3/* a */], l__g[4/* b */], l_c, l_st);
			}
			break;
		case gml_node.array_decl: gml_node_tools_seek_arr(l__g[2/* values */], l_c, l_st); break;
		case gml_node.object_decl: gml_node_tools_seek_arr(l__g[3/* values */], l_c, l_st); break;
		case gml_node.var_decl:
			var l_v = l__g[3/* val */];
			l_r = l_v != undefined && l_c(l_v, undefined);
			break;
		case gml_node.null_co: l_r = l_c(l__g[2/* a */], undefined); break;
		case gml_node.un_op: l_r = l_c(l__g[2/* expr */], undefined); break;
		case gml_node.block: l_r = gml_node_tools_seek_arr(l__g[2/* nodes */], l_c, l_st); break;
		case gml_node.call: l_r = gml_node_tools_seek_1or_arr(l__g[2/* expr */], l__g[3/* args */], l_c, l_st); break;
		case gml_node.call_script_id: l_r = gml_node_tools_seek_1or_arr(l__g[2/* index */], l__g[3/* args */], l_c, l_st); break;
		case gml_node.construct: l_r = gml_node_tools_seek_1or_arr(l__g[2/* ctr */], l__g[3/* args */], l_c, l_st); break;
		case gml_node.call_script_at: l_r = gml_node_tools_seek_1or_arr(l__g[2/* inst */], l__g[4/* args */], l_c, l_st); break;
		case gml_node.call_field: l_r = gml_node_tools_seek_1or_arr(l__g[2/* obj */], l__g[4/* args */], l_c, l_st); break;
		case gml_node.call_func_at: l_r = gml_node_tools_seek_1or_arr(l__g[2/* expr */], l__g[4/* args */], l_c, l_st); break;
		case gml_node.call_script: l_r = gml_node_tools_seek_arr(l__g[3/* args */], l_c, l_st); break;
		case gml_node.call_func: l_r = gml_node_tools_seek_arr(l__g[3/* args */], l_c, l_st); break;
		case gml_node.call_script_with_array:
			var l_x1 = l__g[2/* index */];
			var l_y = l__g[3/* array */];
			l_r = l_c(l_x1, undefined) || l_c(l_y, undefined);
			break;
		case gml_node.if_then:
			var l_c1 = l__g[2/* cond */];
			var l_a = l__g[3/* then */];
			var l_b = l__g[4/* not */];
			l_r = l_c(l_c1, undefined) || l_b != undefined && l_c(l_a, undefined) && l_c(l_b, undefined);
			break;
		case gml_node.ternary:
			var l_c1 = l__g[2/* cond */];
			var l_a = l__g[3/* then */];
			var l_b = l__g[4/* not */];
			l_r = l_c(l_c1, undefined) || l_c(l_a, undefined) && l_c(l_b, undefined);
			break;
		case gml_node.for_hx: l_r = gml_node_tools_seek_or2(l__g[2/* pre */], l__g[3/* cond */], l_c, undefined); break;
		case gml_node.while_hx: l_r = l_c(l__g[2/* cond */], undefined); break;
		case gml_node.with_hx: l_r = l_c(l__g[2/* ctx */], undefined); break;
		case gml_node.do_while: l_r = l_c(l__g[2/* loop */], undefined); break;
		case gml_node.do_until: l_r = l_c(l__g[2/* loop */], undefined); break;
		case gml_node.repeat_hx: l_r = l_c(l__g[2/* times */], undefined); break;
		case gml_node.switch_hx:
			var l__x = l__g[2/* expr */];
			var l__cc = l__g[3/* cases */];
			var l__d = l__g[4/* def */];
			if (l_c(l__x, undefined)) {
				l_r = true;
			} else {
				l_x = l__d;
				if (l_x != undefined && l_c(l_x, undefined)) {
					l_n = array_length(l__cc);
					l_i = 0;
					while (l_i < l_n) {
						if (l_c(l_x, undefined)) l_i++; else break;
					}
					l_r = l_i >= l_n;
				} else l_r = false;
			}
			break;
		case gml_node.try_catch:
			var l_x = l__g[2/* block */];
			var l_e = l__g[4/* catcher */];
			l_r = l_c(l_x, undefined) || l_c(l_e, undefined);
			break;
		case gml_node.set_op: l_r = gml_node_tools_seek_or2(l__g[3/* a */], l__g[4/* b */], l_c, l_st); break;
		case gml_node.in: l_r = gml_node_tools_seek_or2(l__g[2/* fd */], l__g[3/* obj */], l_c, l_st); break;
		case gml_node.env1d: l_r = l_c(l__g[3/* index */], undefined); break;
		case gml_node.env1d_set: l_r = gml_node_tools_seek_or2(l__g[3/* index */], l__g[4/* val */], l_c, l_st); break;
		case gml_node.env1d_aop: l_r = gml_node_tools_seek_or2(l__g[3/* index */], l__g[5/* val */], l_c, l_st); break;
		case gml_node.alarm: l_r = gml_node_tools_seek_or2(l__g[2/* obj */], l__g[3/* index */], l_c, l_st); break;
		case gml_node.alarm_set_hx: l_r = gml_node_tools_seek_or3(l__g[2/* obj */], l__g[3/* index */], l__g[4/* val */], l_c, l_st); break;
		case gml_node.alarm_aop: l_r = gml_node_tools_seek_or3(l__g[2/* obj */], l__g[3/* index */], l__g[5/* val */], l_c, l_st); break;
		case gml_node.ensure_array_for_index: l_r = gml_node_tools_seek_or2(l__g[2/* arr */], l__g[3/* ind */], l_c, l_st); break;
		case gml_node.ensure_array_for_index2d: l_r = gml_node_tools_seek_or3(l__g[2/* arr */], l__g[3/* ind1 */], l__g[4/* ind2 */], l_c, l_st); break;
		case gml_node.index: l_r = gml_node_tools_seek_or2(l__g[2/* arr */], l__g[3/* index */], l_c, l_st); break;
		case gml_node.index_set: l_r = gml_node_tools_seek_or3(l__g[2/* arr */], l__g[3/* index */], l__g[4/* val */], l_c, l_st); break;
		case gml_node.index_aop: l_r = gml_node_tools_seek_or3(l__g[2/* arr */], l__g[3/* index */], l__g[5/* val */], l_c, l_st); break;
		case gml_node.index2d: l_r = gml_node_tools_seek_or3(l__g[2/* arr */], l__g[3/* index1 */], l__g[4/* index2 */], l_c, l_st); break;
		case gml_node.index2d_set: l_r = gml_node_tools_seek_or4(l__g[2/* arr */], l__g[3/* index1 */], l__g[4/* index2 */], l__g[5/* val */], l_c, l_st); break;
		case gml_node.index2d_aop: l_r = gml_node_tools_seek_or4(l__g[2/* arr */], l__g[3/* index1 */], l__g[4/* index2 */], l__g[6/* val */], l_c, l_st); break;
		case gml_node.raw_id: l_r = gml_node_tools_seek_or2(l__g[2/* arr */], l__g[3/* index */], l_c, l_st); break;
		case gml_node.raw_id_set: l_r = gml_node_tools_seek_or3(l__g[2/* arr */], l__g[3/* index */], l__g[4/* val */], l_c, l_st); break;
		case gml_node.raw_id_aop: l_r = gml_node_tools_seek_or3(l__g[2/* arr */], l__g[3/* index */], l__g[5/* val */], l_c, l_st); break;
		case gml_node.raw_id2d: l_r = gml_node_tools_seek_or3(l__g[2/* arr */], l__g[3/* index1 */], l__g[4/* index2 */], l_c, l_st); break;
		case gml_node.raw_id2d_set: l_r = gml_node_tools_seek_or4(l__g[2/* arr */], l__g[3/* index1 */], l__g[4/* index2 */], l__g[5/* val */], l_c, l_st); break;
		case gml_node.raw_id2d_aop: l_r = gml_node_tools_seek_or4(l__g[2/* arr */], l__g[3/* index1 */], l__g[4/* index2 */], l__g[6/* val */], l_c, l_st); break;
		case gml_node.field: l_r = l_c(l__g[2/* obj */], undefined); break;
		case gml_node.field_set: l_r = gml_node_tools_seek_or2(l__g[2/* obj */], l__g[4/* val */], l_c, l_st); break;
		case gml_node.field_aop: l_r = gml_node_tools_seek_or2(l__g[2/* obj */], l__g[5/* val */], l_c, l_st); break;
		case gml_node.env_fd: l_r = l_c(l__g[2/* obj */], undefined); break;
		case gml_node.env_fd_set: l_r = gml_node_tools_seek_or2(l__g[2/* obj */], l__g[4/* val */], l_c, l_st); break;
		case gml_node.env_fd_aop: l_r = gml_node_tools_seek_or2(l__g[2/* obj */], l__g[5/* val */], l_c, l_st); break;
		case gml_node.ds_list: l_r = gml_node_tools_seek_or2(l__g[2/* list */], l__g[3/* index */], l_c, l_st); break;
		case gml_node.ds_list_set_hx: l_r = gml_node_tools_seek_or3(l__g[2/* list */], l__g[3/* index */], l__g[4/* val */], l_c, l_st); break;
		case gml_node.ds_list_aop: l_r = gml_node_tools_seek_or3(l__g[2/* list */], l__g[3/* index */], l__g[5/* val */], l_c, l_st); break;
		case gml_node.ds_map: l_r = gml_node_tools_seek_or2(l__g[2/* map */], l__g[3/* key */], l_c, l_st); break;
		case gml_node.ds_map_set_hx: l_r = gml_node_tools_seek_or3(l__g[2/* map */], l__g[3/* key */], l__g[4/* val */], l_c, l_st); break;
		case gml_node.ds_map_aop: l_r = gml_node_tools_seek_or3(l__g[2/* map */], l__g[3/* key */], l__g[5/* val */], l_c, l_st); break;
		case gml_node.ds_grid: l_r = gml_node_tools_seek_or3(l__g[2/* grid */], l__g[3/* index1 */], l__g[4/* index2 */], l_c, l_st); break;
		case gml_node.ds_grid_set_hx: l_r = gml_node_tools_seek_or4(l__g[2/* grid */], l__g[3/* index1 */], l__g[4/* index2 */], l__g[5/* val */], l_c, l_st); break;
		case gml_node.ds_grid_aop: l_r = gml_node_tools_seek_or4(l__g[2/* grid */], l__g[3/* index1 */], l__g[4/* index2 */], l__g[6/* val */], l_c, l_st); break;
		case gml_node.key_id: l_r = gml_node_tools_seek_or2(l__g[2/* obj */], l__g[3/* key */], l_c, l_st); break;
		case gml_node.key_id_set: l_r = gml_node_tools_seek_or3(l__g[2/* obj */], l__g[3/* key */], l__g[4/* val */], l_c, l_st); break;
		case gml_node.key_id_aop: l_r = gml_node_tools_seek_or3(l__g[2/* obj */], l__g[3/* key */], l__g[5/* val */], l_c, l_st); break;
	}
	if (l_trouble) throw gml_std_haxe_Exception_thrown("Can't seekAll over " + ast_gml_node_tools_ni_get_pos_string(l_q, l_pg) + " " + gml_std_Type_enumConstructor(l_q));
	if (l_st != undefined) ds_list_delete(l_st, 0);
	return false;
}

if (live_enabled) 
function gml_node_tools_seek(l_q, l_st, l_c) {
	// gml_node_tools_seek(q:ast_GmlNode, st:tools_ArrayList<ast_GmlNode>, c:ast_GmlNodeIter)->bool
	/// @ignore
	if (l_q == undefined) return false;
	if (l_st != undefined) ds_list_insert(l_st, 0, l_q);
	var l_result;
	var l__g = l_q;
	if (l__g[0]/* gml_node */ == gml_node.switch_hx) {
		var l_x = l__g[2/* expr */];
		var l_m = l__g[3/* cases */];
		var l_o = l__g[4/* def */];
		if (l_c(l_x, l_st)) {
			l_result = true;
		} else {
			var l_n = array_length(l_m);
			var l_i;
			for (l_i = 0; l_i < l_n; l_i++) {
				var l_w = l_m[l_i].values;
				var l_l = array_length(l_w);
				var l_k;
				for (l_k = 0; l_k < l_l; l_k++) {
					if (l_c(l_w[l_k], l_st)) break;
				}
				if (l_k < l_l || l_c(l_m[l_i].expr, l_st)) break;
			}
			if (l_i < l_n) l_result = true; else l_result = l_o != undefined && l_c(l_o, l_st);
		}
		if (l_st != undefined) ds_list_delete(l_st, 0);
		return l_result;
	}
	var l_inf = ast_gml_node_def_info_array[gml_std_Type_enumIndex(l_q)];
	var l_def = l_q;
	var l_params = l_inf.h_params;
	var l_result1 = false;
	var l_i = 0;
	for (var l__g1 = array_length(l_params); l_i < l__g1; l_i++) {
		var l_v = l_def[l_i + 1];
		var l_result2;
		switch (l_params[l_i].h_type) {
			case 0: l_result2 = l_v != undefined && l_c(l_v, l_st); break;
			case 1:
				var l_arr = l_v;
				var l_found = false;
				var l_i1 = 0;
				for (var l__g3 = array_length(l_arr); l_i1 < l__g3; l_i1++) {
					if (l_c(l_arr[l_i1], l_st)) {
						l_found = true;
						break;
					}
				}
				l_result2 = l_found;
				break;
			default: l_result2 = false;
		}
		if (l_result2) {
			l_result1 = true;
			break;
		}
	}
	l_result = l_result1;
	if (l_st != undefined) ds_list_delete(l_st, 0);
	return l_result;
}

#endregion
