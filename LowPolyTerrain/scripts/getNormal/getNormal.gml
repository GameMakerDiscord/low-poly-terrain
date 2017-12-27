/// @description  getNormal(a [x y z], b [x2 y2 z2], c [x3 y3 z3]);
/// @function  getNormal
/// @param a [x y z]
/// @param  b [x2 y2 z2]
/// @param  c [x3 y3 z3]
return normalize(cross(sub(argument1, argument0), sub(argument2, argument0)));

