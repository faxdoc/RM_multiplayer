text = "Press to release grapple on";

execute_function = function(index_) {
	opreference_tracker.grapple_mode[ index_ ] = false;
}

return_function = function(index_) {
	return opreference_tracker.grapple_mode[ index_ ] ? 0 : 1;
}

