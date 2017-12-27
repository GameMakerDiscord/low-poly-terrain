/// @description  generateColors(BiomColors, Spread, heights, gridCount);
/// @function  generateColors
/// @param BiomColors
/// @param  Spread
/// @param  heights
/// @param  gridCount
var heights = argument2;
var gridSize = argument3;

var colors = alloc(gridSize + 1, gridSize + 1);

for( var i = 0; i <= gridSize; i++ ) {
    for( var j = 0; j <= gridSize; j++ ) {
        colors[i, j] = calculateColour(argument0, argument1, heights[i, j], AMPLITUDE);
    }
}

return colors;
