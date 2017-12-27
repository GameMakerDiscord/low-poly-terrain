/// @description  game_resized();
/// @function  game_resized
return (window_has_focus() && surface_exists(application_surface)) && (abs(surface_get_width(application_surface)-window_get_width()) > 0
     || abs(surface_get_height(application_surface)-window_get_height()) > 0);
