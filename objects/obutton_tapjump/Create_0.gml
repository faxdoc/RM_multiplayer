text = "Jump with up key on";
execute_function = function(index_) {
	global.tap_jump[index_] = true;
}

return_function = function( index_ ) {
	return global.tap_jump[ index_ ] ? 1 : 0;
}

