/// @description  getIndicators(curVert, vertPos, v1, v2);
/// @function  getIndicators
/// @param curVert
/// @param  vertPos
/// @param  v1
/// @param  v2
var curVert = argument0;
var vertPos = argument1;
var v1 = argument2;
var v2 = argument3;

var cvp = pack(vertPos[curVert], [0]);
var v1p = vertPos[v1];
var v2p = vertPos[v2];

var offset1 = sub(pack(v1p, [0]), cvp);
var offset2 = sub(pack(v2p, [0]), cvp);

return vec(offset1[0], offset1[1], offset2[0], offset2[1]);

