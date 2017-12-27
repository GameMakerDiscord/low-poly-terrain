/// @desc perlin_interpolated(x, y);
/// @param x
/// @param y
var X = argument0;
var Y = argument1;

var corners = (
    perlin_get_noise(X - 1, Y - 1) + 
    perlin_get_noise(X + 1, Y - 1) + 
    perlin_get_noise(X - 1, Y + 1) + 
    perlin_get_noise(X + 1, Y + 1)
) / 16;

var sides = (
    perlin_get_noise(X + 1, Y) + 
    perlin_get_noise(X - 1, Y) + 
    perlin_get_noise(X, Y + 1) + 
    perlin_get_noise(X, Y - 1)
) / 8;

var center = perlin_get_noise(X, Y) / 4;
return center + corners + sides;
