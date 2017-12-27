/// @description  game_resize_auto();
/// @function  game_resize_auto
if( game_resized() ) game_resize(window_get_width(), window_get_height(), surface_get_width(application_surface), surface_get_height(application_surface));

