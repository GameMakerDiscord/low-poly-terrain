/// @description  game_resize(w, h, pw, ph);
/// @function  game_resize
/// @param w
/// @param  h
/// @param  pw
/// @param  ph
var w = argument0;
var h = argument1;
var pw = argument2;
var ph = argument3;

// Main surface
surface_resize(application_surface, w, h);

// GUI
display_set_gui_size(w, h);

// Window
window_set_size(w, h);
window_center();

// View
__view_set( e__VW.WView, 0, w );
__view_set( e__VW.HView, 0, h );
__view_set( e__VW.WPort, 0, w );
__view_set( e__VW.HPort, 0, h );

// Camera
with( objCamera ) {
    DestDir = dir;
    DestPitch = pitch;
}

// FBOs
/*if( instance_exists(objRender) && id == objRender.id && init ) {
    fboResizeBuffers(FBOMain);
    fboResizeBuffers(FBOEffects);
}

// 
m3d_projection_destroy(global.PROJECTION);
global.PROJECTION = m3d_projection_create(0, 0, view_wview, view_hview);*/

// 
show_debug_message("Game resized "+trace("w", w, "h", h)+" From "+trace("w", pw, "h", ph));

