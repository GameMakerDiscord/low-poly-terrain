/// @desc perlin_noise(x, y, OCTAVES, AMPLITUDE, ROUGHNESS);
/// @param x
/// @param y
/// @param OCTAVES
/// @param AMPLITUDE
/// @param ROUGHNESS
var total = 0;
var d = power(2, argument2 - 1);
for( var i = 0; i < argument2; i++ ) {
    var freq = power(2, i) / d;
    var amp = power(argument4, i) * argument3;
    total += perlin_interpolated(argument0 * freq, argument1 * freq) * amp;
}

return total;