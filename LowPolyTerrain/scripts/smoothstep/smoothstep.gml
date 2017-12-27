/// @description  smoothstep(edge0, edge1, x);
/// @function  smoothstep
/// @param edge0
/// @param  edge1
/// @param  x
var _x = clamp((argument2 - argument0) / (argument1 - argument0), 0, 1);
return sqr(_x) * (3 - 2 * _x);
