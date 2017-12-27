/// @description  storeGridSquare(col, row, gridSize, buff);
/// @function  storeGridSquare
/// @param col
/// @param  row
/// @param  gridSize
/// @param  buff
var c = argument0;
var r = argument1;
var m = argument2;
var b = argument3;

var uv = [c / m, r / m];

var cornerPos = calcCornerPos(c, r);
storeTriangle(cornerPos, b, true , uv);
storeTriangle(cornerPos, b, false, uv);

