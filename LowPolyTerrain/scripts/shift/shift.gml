/// @description  shift(vec, shift);
/// @function  shift
/// @param vec
/// @param  shift

var v = argument0;
var s = argument1;

var p = modular2(vec(s, s + 1, s + 2), 2);

v[0] = argument0[p[0]];
v[1] = argument0[p[1]];
v[2] = argument0[p[2]];

/*show_debug_message(argument0);
show_debug_message(v);
show_debug_message(p);*/
return v;
