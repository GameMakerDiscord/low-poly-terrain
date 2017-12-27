/// @description  map2(x1, ... x inf);
/// @function  map2
/// @param x1
/// @param  ... x inf
var l = ds_map_create(); for( var i = 0; i < argument_count; i++ ) ds_map_add(l, argument[i], true); return l;
