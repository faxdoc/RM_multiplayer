text = "Jump with up key off";
execute_function = function(index_) {
	global.tap_jump[index_] = false;
}

return_function = function( index_ ) {
	return global.tap_jump[ index_ ] ? 0 : 1;
}

