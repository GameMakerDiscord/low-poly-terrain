/// @description  map3(x1, ... x inf);
/// @function  map3
/// @param x1
/// @param  ... x inf
var l = ds_map_create(); for( var i = 0; i < argument_count; i += 2 ) ds_map_add(l, argument[i], argument[i+1]); return l;
