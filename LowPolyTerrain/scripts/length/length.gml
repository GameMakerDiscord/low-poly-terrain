/// @description  length(x, y, z);
/// @function  length
/// @param x
/// @param  y
/// @param  z

if( argument_count > 1 ) {
    return sqrt(sqr(argument[0]) + sqr(argument[1]) + sqr(argument[2]));
}

var a = argument[0];
return sqrt(sqr(a[0]) + sqr(a[1]) + sqr(a[2]));
