/// @desc perlin_interpolated(x, y);
/// @param x
/// @param y
var X = floor(argument0);
var fracX = argument0 - X;
var Y = floor(argument1);
var fracY = argument1 - Y;

var v1 = perlin_smooth(X, Y);
var v2 = perlin_smooth(X + 1, Y);
var v3 = perlin_smooth(X, Y + 1);
var v4 = perlin_smooth(X + 1, Y + 1);
var i1 = perlin_interpolate(v1, v2, fracX);
var i2 = perlin_interpolate(v3, v4, fracX);
return perlin_interpolate(i1, i2, fracY);
