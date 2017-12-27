/// @description  calculateColour(BiomColors, Spread, height, amplitude);
/// @function  calculateColour
/// @param BiomColors
/// @param  Spread
/// @param  height
/// @param  amplitude
var BiomColors = argument0;
var Spread = argument1;
var halfSpread = Spread / 2;
var part = 1 / (array_length_1d(BiomColors) - 1);

var height = argument2;
var amp = argument3;

var val = height / (amp * 2) + .5;
val = clamp((val - halfSpread) / Spread, 0, .9999);
var fBiom = floor(val / part);
var blend = (val - (fBiom * part)) * (1 / part);

return merge_colour(BiomColors[fBiom], BiomColors[fBiom + 1], blend);

