/// @description  storeTriangle(cornerPos, buff, left, textcoord);
/// @function  storeTriangle
/// @param cornerPos
/// @param  buff
/// @param  left
/// @param  textcoord
var cornerPos = argument0;
var buff = argument1;
var left = argument2;

var index0 = check(left, 0, 2);
var index1 = 1;
var index2 = check(left, 2, 3);

// Write position
WriteVertex(buff, cornerPos[index0], getIndicators(index0, cornerPos, index1, index2), argument3);
WriteVertex(buff, cornerPos[index1], getIndicators(index1, cornerPos, index2, index0), argument3);
WriteVertex(buff, cornerPos[index2], getIndicators(index2, cornerPos, index0, index1), argument3);
