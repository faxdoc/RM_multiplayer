text = "Jump with up key on";
execute_function = function(index_) {
	opreference_tracker.tap_jump[index_] = true;
}

return_function = function( index_ ) {
	return opreference_tracker.tap_jump[ index_ ] ? 1 : 0;
}

