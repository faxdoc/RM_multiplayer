text = "Press to release grapple off";

execute_function = function(index_) {
	global.grapple_mode[ index_ ] = false;
}

return_function = function(index_) {
	return global.grapple_mode[ index_ ] ? 0 : 1;
}

