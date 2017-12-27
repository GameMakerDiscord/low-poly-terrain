/// @description  cross(v1, v2);
/// @function  cross
/// @param v1
/// @param  v2

return vec(
    argument0[1] * argument1[2] - argument0[2] * argument1[1], 
    argument0[2] * argument1[0] - argument0[0] * argument1[2], 
    argument0[0] * argument1[1] - argument0[1] * argument1[0], 
);

