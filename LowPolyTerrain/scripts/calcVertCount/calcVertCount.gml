/// @description  calcVertCount(len);
/// @function  calcVertCount
/// @param len
var len = argument0;

var bot2rows = 2 * len;
var topCnt = (len - 2) * (len - 1) * 2;

return 3 * 2 * sqr(len - 1); //topCnt + bot2rows;
