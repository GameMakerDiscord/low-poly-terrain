/// @desc perlin_interpolate(a, b);
/// @param a
/// @param b
/// @param blend
var f = (1 - cos(argument2 * pi)) * .5;
return argument0 * (1 - f) + argument1 * f;
