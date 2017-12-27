/// @description  normalize(x, y, z);
/// @function  normalize
/// @param x
/// @param  y
/// @param  z

if( argument_count > 1 ) {
    var l = length(argument[0], argument[1], argument[2]);
    return vec(argument[0] / l, argument[1] / l, argument[2] / l);
}

var a = argument[0];
var l = length(a);
return vec(a[0] / l, a[1] / l, a[2] / l);
