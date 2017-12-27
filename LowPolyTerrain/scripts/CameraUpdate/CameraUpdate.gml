/// @description  CameraUpdate(Camera, hsp, vsp, dx, dy, zdt);
/// @function  CameraUpdate
/// @param Camera
/// @param  hsp
/// @param  vsp
/// @param  dx
/// @param  dy
/// @param  zdt
var Camera = argument0;
Camera.x += argument1;
Camera.y += argument2;
Camera.z += argument5;

// TODO: Check for options[smooth mouse]
Camera.DestDir -= argument3;
Camera.DestPitch -= argument4;

// Lock this value in range of -89 up to 89
Camera.DestPitch = clamp(Camera.DestPitch, -89, 89);

with( objRender ) ConvertUpdate( Camera );
