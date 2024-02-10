//text = "Jump with up key on";
text = "";
execute_function = function(index_) {
	opreference_tracker.tap_jump[index_] = true;
}

return_function = function( index_ ) {
	return opreference_tracker.tap_jump[ index_ ] ? 0 : 1;
}

