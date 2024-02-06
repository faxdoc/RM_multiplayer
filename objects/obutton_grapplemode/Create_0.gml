text = "Press to release grapple on";

execute_function = function(index_) {
	global.grapple_mode[ index_ ] = true;
}

return_function = function(index_) {
	return global.grapple_mode[ index_ ] ? 1 : 0;
}

