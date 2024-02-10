//text = "Jump with up key off";
text = "";
execute_function = function(index_) {
	opreference_tracker.tap_jump[index_] = false;
}

return_function = function( index_ ) {
	return opreference_tracker.tap_jump[ index_ ] ? 1 : 0;
}

