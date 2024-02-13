text = "";
text_alt = [ "Grapple detaches","when right click","is pressed" ];

execute_function = function(index_) {
	opreference_tracker.grapple_mode[ index_ ] = false;
}

return_function = function(index_) {
	return opreference_tracker.grapple_mode[ index_ ] ? 1 : 0;
}
//text = "Press to release grapple on";

