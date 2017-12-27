/// @description  calcCornerPos(col, row);
/// @function  calcCornerPos
/// @param col
/// @param  row
var col = argument0;
var row = argument1;

var vert = alloc(4);
    
    vert[0] = vec(col + 0, row + 0);
    vert[1] = vec(col + 0, row + 1);
    vert[2] = vec(col + 1, row + 0);
    vert[3] = vec(col + 1, row + 1);
    
return vert;
