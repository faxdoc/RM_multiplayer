if (!instance_exists(orandom) ) exit;
if ( instance_position( device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id ) ) {
	if ( mouse_check_button_pressed( mb_left ) ) {
		url_open("https://store.steampowered.com/app/1772830/Rusted_Moss/");
	}
	image_index = 1;
} else {
	image_index = 0;
}









