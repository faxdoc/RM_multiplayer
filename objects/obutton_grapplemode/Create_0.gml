//text = "Press to release grapple off";
text = "Grapple detaches when right click is released";

execute_function = function(index_) {
	opreference_tracker.grapple_mode[ index_ ] = true;
}

return_function = function(index_) {
	return opreference_tracker.grapple_mode[ index_ ] ? 0 : 1;
}

