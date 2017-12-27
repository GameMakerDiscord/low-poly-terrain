/// @description  list2(x1, ... x inf);
/// @function  list2
/// @param x1
/// @param  ... x inf
var l = ds_list_create(); for( var i = 0; i < argument_count; i++ ) ds_list_add(l, argument[i]); return l;
