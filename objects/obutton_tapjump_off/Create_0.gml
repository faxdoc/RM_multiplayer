text = "Jump with up key off";
execute_function = function(index_) {
	opreference_tracker.tap_jump[index_] = false;
}

return_function = function( index_ ) {
	return opreference_tracker.tap_jump[ index_ ] ? 0 : 1;
}

