// GMLive.gml (c) YellowAfterlife, 2017+
// PLEASE DO NOT FORGET to remove paid extensions from your project when publishing the source code!
// And if you are using git, you can exclude GMLive by adding
// `scripts/GMLive*` and `extensions/GMLive/` lines to your `.gitignore`.
// Feather disable all

#region gml.seek_set_op

if (live_enabled) 
function gml_seek_set_op_resolve_set_op_rfn(l_q, l_st) {
	// gml_seek_set_op_resolve_set_op_rfn(q:ast_GmlNode, st:tools_ArrayList<ast_GmlNode>)->bool
	/// @ignore
	var l__g = l_q;
	switch (l__g[0]) {
		case gml_node.index_set:
			if (gml_node_tools_equals(gml_seek_set_op_resolve_set_op_xw, l__g[2/* arr */])) {
				gml_seek_set_op_resolve_set_op_safe = true;
				return true;
			}
			break;
		case gml_node.index_aop:
			if (gml_node_tools_equals(gml_seek_set_op_resolve_set_op_xw, l__g[2/* arr */])) {
				gml_seek_set_op_resolve_set_op_safe = true;
				return true;
			}
			break;
		case gml_node.index2d_set:
			if (gml_node_tools_equals(gml_seek_set_op_resolve_set_op_xw, l__g[2/* arr */])) {
				gml_seek_set_op_resolve_set_op_safe = true;
				return true;
			}
			break;
		case gml_node.index2d_aop:
			if (gml_node_tools_equals(gml_seek_set_op_resolve_set_op_xw, l__g[2/* arr */])) {
				gml_seek_set_op_resolve_set_op_safe = true;
				return true;
			}
			break;
		case gml_node.set_op:
			var l_x2 = l__g[3/* a */];
			var l_v2 = l__g[4/* b */];
			if (gml_node_tools_equals(gml_seek_set_op_resolve_set_op_xw, l_x2)) {
				var l__g1 = l_v2;
				gml_seek_set_op_resolve_set_op_safe = (l__g1[0] == 6);
				return true;
			}
			break;
	}
	return gml_node_tools_seek_all(l_q, l_st, gml_seek_set_op_resolve_set_op_rfn, gml_program_seek_inst);
}

if (live_enabled) 
function gml_seek_set_op_proc(l_q, l_st) {
	// gml_seek_set_op_proc(q:ast_GmlNode, st:ast_GmlNodeList)->bool
	/// @ignore
	var l__g = l_q;
	if (l__g[0]/* gml_node */ == gml_node.set_op) {
		var l_d = l__g[1/* d */];
		var l_o = l__g[2/* op */];
		var l_x = l__g[3/* a */];
		var l_v = l__g[4/* b */];
		var l_xu = gml_node_tools_unpack(l_x);
		var l__g = l_xu;
		switch (l__g[0]) {
			case gml_node.local_hx:
				var l_s = l__g[2/* name */];
				if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.local_aop, l_d, l_s, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.local_set, l_d, l_s, l_v]);
				break;
			case gml_node.static_hx:
				var l_s = l__g[2/* name */];
				if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.static_aop, l_d, l_s, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.static_set, l_d, l_s, l_v, false]);
				break;
			case gml_node.global_hx:
				var l_s = l__g[2/* name */];
				if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.global_aop, l_d, l_s, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.global_set, l_d, l_s, l_v]);
				break;
			case gml_node.arg_const: break;
			case gml_node.arg_index: break;
			case gml_node.field:
				var l_x1 = l__g[2/* obj */];
				var l_s = l__g[3/* field */];
				if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.field_aop, l_d, l_x1, l_s, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.field_set, l_d, l_x1, l_s, l_v]);
				break;
			case gml_node.alarm:
				var l_x1 = l__g[2/* obj */];
				var l_i = l__g[3/* index */];
				if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.alarm_aop, l_d, l_x1, l_i, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.alarm_set_hx, l_d, l_x1, l_i, l_v]);
				break;
			case gml_node.index:
				var l_xd = l__g[1/* d */];
				var l_xw = l__g[2/* arr */];
				var l__g1 = l_x;
				switch (l__g1[0]) {
					case gml_node.index:
						var l_xi = l__g1[3/* index */];
						if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.index_aop, l_xd, l_xw, l_xi, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.index_set, l_xd, l_xw, l_xi, l_v]);
						break;
					case gml_node.index2d:
						var l_i1 = l__g1[3/* index1 */];
						var l_i2 = l__g1[4/* index2 */];
						if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.index2d_aop, l_xd, l_xw, l_i1, l_i2, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.index2d_set, l_xd, l_xw, l_i1, l_i2, l_v]);
						break;
				}
				gml_seek_set_op_resolve_set_op_safe = false;
				gml_seek_set_op_resolve_set_op_xw = l_xw;
				gml_node_tools_seek_all_out(l_q, l_st, gml_seek_set_op_resolve_set_op_rfn, 0, gml_program_seek_inst);
				var l_expr = l_xw;
				while (l_expr != undefined) {
					var l__g1 = l_expr;
					switch (l__g1[0]) {
						case gml_node.local_hx:
							gml_std_haxe_enum_tools_setTo(l_expr, [gml_node.ensure_array_for_local, l__g1[1/* d */], l__g1[2/* name */]]);
							l_expr = undefined;
							break;
						case gml_node.global_hx:
							gml_std_haxe_enum_tools_setTo(l_expr, [gml_node.ensure_array_for_global, l__g1[1/* d */], l__g1[2/* name */]]);
							l_expr = undefined;
							break;
						case gml_node.field:
							gml_std_haxe_enum_tools_setTo(l_expr, [gml_node.ensure_array_for_field, l__g1[1/* d */], l__g1[2/* obj */], l__g1[3/* field */]]);
							l_expr = undefined;
							break;
						case gml_node.index:
							var l_x2 = l__g1[2/* arr */];
							gml_std_haxe_enum_tools_setTo(l_expr, [gml_node.ensure_array_for_index, l__g1[1/* d */], l_x2, l__g1[3/* index */]]);
							l_expr = l_x2;
							break;
						case gml_node.index2d:
							var l_x3 = l__g1[2/* arr */];
							gml_std_haxe_enum_tools_setTo(l_expr, [gml_node.ensure_array_for_index2d, l__g1[1/* d */], l_x3, l__g1[3/* index1 */], l__g1[4/* index2 */]]);
							l_expr = l_x3;
							break;
						default: l_expr = undefined;
					}
				}
				break;
			case gml_node.index2d:
				var l_xd = l__g[1/* d */];
				var l_xw = l__g[2/* arr */];
				var l__g1 = l_x;
				switch (l__g1[0]) {
					case gml_node.index:
						var l_xi = l__g1[3/* index */];
						if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.index_aop, l_xd, l_xw, l_xi, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.index_set, l_xd, l_xw, l_xi, l_v]);
						break;
					case gml_node.index2d:
						var l_i1 = l__g1[3/* index1 */];
						var l_i2 = l__g1[4/* index2 */];
						if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.index2d_aop, l_xd, l_xw, l_i1, l_i2, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.index2d_set, l_xd, l_xw, l_i1, l_i2, l_v]);
						break;
				}
				gml_seek_set_op_resolve_set_op_safe = false;
				gml_seek_set_op_resolve_set_op_xw = l_xw;
				gml_node_tools_seek_all_out(l_q, l_st, gml_seek_set_op_resolve_set_op_rfn, 0, gml_program_seek_inst);
				var l_expr = l_xw;
				while (l_expr != undefined) {
					var l__g1 = l_expr;
					switch (l__g1[0]) {
						case gml_node.local_hx:
							gml_std_haxe_enum_tools_setTo(l_expr, [gml_node.ensure_array_for_local, l__g1[1/* d */], l__g1[2/* name */]]);
							l_expr = undefined;
							break;
						case gml_node.global_hx:
							gml_std_haxe_enum_tools_setTo(l_expr, [gml_node.ensure_array_for_global, l__g1[1/* d */], l__g1[2/* name */]]);
							l_expr = undefined;
							break;
						case gml_node.field:
							gml_std_haxe_enum_tools_setTo(l_expr, [gml_node.ensure_array_for_field, l__g1[1/* d */], l__g1[2/* obj */], l__g1[3/* field */]]);
							l_expr = undefined;
							break;
						case gml_node.index:
							var l_x2 = l__g1[2/* arr */];
							gml_std_haxe_enum_tools_setTo(l_expr, [gml_node.ensure_array_for_index, l__g1[1/* d */], l_x2, l__g1[3/* index */]]);
							l_expr = l_x2;
							break;
						case gml_node.index2d:
							var l_x3 = l__g1[2/* arr */];
							gml_std_haxe_enum_tools_setTo(l_expr, [gml_node.ensure_array_for_index2d, l__g1[1/* d */], l_x3, l__g1[3/* index1 */], l__g1[4/* index2 */]]);
							l_expr = l_x3;
							break;
						default: l_expr = undefined;
					}
				}
				break;
			case gml_node.env:
				var l_av = l__g[2/* v */];
				var l_f = l_av.h_flags;
				if ((l_f & 1) == 0) {
					if ((l_f & 2) != 0) {
						var l_k = [gml_node.number, l_d, 0, undefined];
						if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.env1d_aop, l_d, l_av, l_k, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.env1d_set, l_d, l_av, l_k, l_v]);
					} else if (l_o != -1) {
						gml_std_haxe_enum_tools_setTo(l_q, [gml_node.env_aop, l_d, l_av, l_o, l_v]);
					} else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.env_set, l_d, l_av, l_v]);
				} else return gml_program_seek_inst.h_error("`" + l_av.h_name + "` is read-only", l__g[1/* d */]);
				break;
			case gml_node.script_static: if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.script_static_aop, l_d, l__g[2/* scr */], l__g[3/* name */], l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.script_static_set, l_d, l__g[2/* scr */], l__g[3/* name */], l_v]); break;
			case gml_node.env_fd:
				var l_av = l__g[3/* v */];
				if ((l_av.h_flags & 1) == 0) {
					if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.env_fd_aop, l_d, l__g[2/* obj */], l_av, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.env_fd_set, l_d, l__g[2/* obj */], l_av, l_v]);
				} else return gml_program_seek_inst.h_error("`" + l_av.h_name + "` is read-only", l__g[1/* d */]);
				break;
			case gml_node.env1d:
				var l_av = l__g[2/* v */];
				if ((l_av.h_flags & 1) == 0) {
					if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.env1d_aop, l_d, l_av, l__g[3/* index */], l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.env1d_set, l_d, l_av, l__g[3/* index */], l_v]);
				} else return gml_program_seek_inst.h_error("`" + l_av.h_name + "` is read-only", l__g[1/* d */]);
				break;
			case gml_node.ds_list:
				var l_x1 = l__g[2/* list */];
				var l_k = l__g[3/* index */];
				if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.ds_list_aop, l_d, l_x1, l_k, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.ds_list_set_hx, l_d, l_x1, l_k, l_v]);
				break;
			case gml_node.ds_map:
				var l_x1 = l__g[2/* map */];
				var l_k = l__g[3/* key */];
				if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.ds_map_aop, l_d, l_x1, l_k, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.ds_map_set_hx, l_d, l_x1, l_k, l_v]);
				break;
			case gml_node.ds_grid:
				var l_x1 = l__g[2/* grid */];
				var l_i = l__g[3/* index1 */];
				var l_k = l__g[4/* index2 */];
				if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.ds_grid_aop, l_d, l_x1, l_i, l_k, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.ds_grid_set_hx, l_d, l_x1, l_i, l_k, l_v]);
				break;
			case gml_node.raw_id:
				var l_x1 = l__g[2/* arr */];
				var l_k = l__g[3/* index */];
				if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.raw_id_aop, l_d, l_x1, l_k, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.raw_id_set, l_d, l_x1, l_k, l_v]);
				break;
			case gml_node.raw_id2d:
				var l_x1 = l__g[2/* arr */];
				var l_i = l__g[3/* index1 */];
				var l_k = l__g[4/* index2 */];
				if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.raw_id2d_aop, l_d, l_x1, l_i, l_k, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.raw_id2d_set, l_d, l_x1, l_i, l_k, l_v]);
				break;
			case gml_node.key_id:
				var l_x1 = l__g[2/* obj */];
				var l_k = l__g[3/* key */];
				if (l_o != -1) gml_std_haxe_enum_tools_setTo(l_q, [gml_node.key_id_aop, l_d, l_x1, l_k, l_o, l_v]); else gml_std_haxe_enum_tools_setTo(l_q, [gml_node.key_id_set, l_d, l_x1, l_k, l_v]);
				break;
			default: return gml_program_seek_inst.h_error(("Expression (" + g_gml_node_constructors[l_xu[0]] + ") is not settable"), gml_std_haxe_enum_tools_getParameter(l_x, 0));
		}
	}
	return gml_node_tools_seek(l_q, l_st, gml_program_seek_func);
}

#endregion
