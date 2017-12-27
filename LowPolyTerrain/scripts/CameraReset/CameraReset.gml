/// @description  CameraReset([angle]);
/// @function  CameraReset
/// @param [angle]
var angle = 0; if( argument_count > 1 ) angle = argument[0];
d3d_set_projection_ortho(0, 0, __view_get( e__VW.WView, 0 ), __view_get( e__VW.HView, 0 ), angle);

