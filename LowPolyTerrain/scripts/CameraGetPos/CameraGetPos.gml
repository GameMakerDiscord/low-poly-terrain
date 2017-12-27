/// @description  CameraGetPos();
/// @function  CameraGetPos
/*var vx = lengthdir_x(lengthdir_x(1, objCamera.pan), objCamera.tilt);
var vy = lengthdir_x(lengthdir_y(1, objCamera.pan), objCamera.tilt);
var vz = lengthdir_y(1, objCamera.tilt);

return vec(
    objCamera.parent.x + vx * objCamera.distance, 
    objCamera.parent.y + vy * objCamera.distance, 
    objCamera.parent.z + vz * objCamera.distance
);
