/// @description  trace(x1, ... x inf);
/// @function  trace
/// @param x1
/// @param  ... x inf
var s = string(argument[0]); for( var i = 1; i < argument_count; i++ ) s += ", " + string(argument[i]); return s;
