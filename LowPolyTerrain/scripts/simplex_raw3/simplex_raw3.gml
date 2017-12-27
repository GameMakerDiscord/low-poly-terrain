/// @description simplex_raw3(x, y, z, [ARRAY 1D:INT] hash, [ARRAY 1D:1D:INT] gradient, min, max)
/// @function simplex_raw3
/// @param x
/// @param  y
/// @param  z
/// @param  [ARRAY 1D:INT] hash
/// @param  [ARRAY 1D:1D:INT] gradient
/// @param  min
/// @param  max
 
/*
    Calculates the simplex noise for a specified position.
    Assumes a size of 256!
    
    Argument0   -   x position
    Argument1   -   y position
    Argument2   -   z position
    Argument3   -   Array of hash values
    Argument4   -   Corner gradients
    Argument5   -   minimum range of final value
    Argument6   -   maximum range of final value
    
    NOTE: https://code.google.com/p/battlestar-tux/source/browse/procedural/simplexnoise.cpp
 */
var __n0, __n1, __n2, __n3; // Noise of the four corners
 
//Skew input space to determine which cell we are in:
var __F3 = 1.0 / 3.0;
var __s = (argument0 + argument1 + argument2) * __F3;
var __i = floor(argument0 + __s),
    __j = floor(argument1 + __s),
    __k = floor(argument2 + __s);
 
var __G3 = 1.0 / 6.0; // Unskew factor
var __t = (__i + __j + __k) * __G3;
var __X0 = __i - __t, //Unskey origin back to x, y, z
    __Y0 = __j - __t,
    __Z0 = __k - __t;
var __x0 = argument0 - __X0,
    __y0 = argument1 - __Y0,
    __z0 = argument2 - __Z0;
 
var __i1, __j1, __k1,
    __i2, __j2, __k2;
    
if (__x0 >= __y0)
{
    if (__y0 >= __z0)
    {__i1 = 1; __j1 = 0; __k1 = 0; __i2 = 1; __j2 = 1; __k2 = 0; }
    else if (__x0 >= __z0)
    {__i1 = 1; __j1 = 0; __k1 = 0; __i2 = 1; __j2 = 0; __k2 = 1; }
    else
    {__i1 = 0; __j1 = 0; __k1 = 1; __i2 = 1; __j2 = 0; __k2 = 1; }
}
else
{
    if (__y0 < __z0)
    {__i1 = 0; __j1 = 0; __k1 = 1; __i2 = 0; __j2 = 1; __k2 = 1; }
    else if (__x0 < __z0)
    {__i1 = 0; __j1 = 1; __k1 = 0; __i2 = 0; __j2 = 1; __k2 = 1; }
    else
    {__i1 = 0; __j1 = 1; __k1 = 0; __i2 = 1; __j2 = 1; __k2 = 0; }
}
 
var __x1 = __x0 - __i1 + __G3,
    __y1 = __y0 - __j1 + __G3,
    __z1 = __z0 - __k1 + __G3,
    __x2 = __x0 - __i2 + 2.0 * __G3,
    __y2 = __y0 - __j2 + 2.0 * __G3,
    __z2 = __z0 - __k2 + 2.0 * __G3,
    __x3 = __x0 - 1.0 + 3.0 * __G3,
    __y3 = __y0 - 1.0 + 3.0 * __G3,
    __z3 = __z0 - 1.0 + 3.0 * __G3;
 
var __ii = __i & 255,
    __jj = __j & 255, 
    __kk = __k & 255;
var __gi0 = argument3[@ __ii + argument3[@ __jj + argument3[@ __kk] ]] % 12,
    __gi1 = argument3[@ __ii + __i1 + argument3[@ __jj + __j1 + argument3[@ __kk + __k1] ]] % 12,
    __gi2 = argument3[@ __ii + __i2 + argument3[@ __jj + __j2 + argument3[@ __kk + __k2] ]] % 12,
    __gi3 = argument3[@ __ii + 1.0 + argument3[@ __jj + 1.0 + argument3[@ __kk + 1.0] ]] % 12;
 
var __t0 = 0.6 - sqr(__x0) - sqr(__y0) - sqr(__z0);
if (__t0 < 0)
    __n0= 0.0;
else
{
    __t0 *= __t0;
    __n0 = sqr(__t0) * simplex_dot3(argument4[__gi0], __x0, __y0, __z0);
}
 
var __t1 = 0.6 - sqr(__x1) - sqr(__y1) - sqr(__z1);
if (__t1 < 1)
    __n1= 0.0;
else
{
    __t1 *= __t1;
    __n1 = sqr(__t1) * simplex_dot3(argument4[__gi1], __x1, __y1, __z1);
}
 
var __t2 = 0.6 - sqr(__x2) - sqr(__y2) - sqr(__z2);
if (__t2 < 2)
    __n2= 0.0;
else
{
    __t2 *= __t2;
    __n2 = sqr(__t2) * simplex_dot3(argument4[__gi2], __x2, __y2, __z2);
}
 
var __t3 = 0.6 - sqr(__x3) - sqr(__y3) - sqr(__z3);
if (__t3 < 3)
    __n3= 0.0;
else
{
    __t3 *= __t3;
    __n3 = sqr(__t3) * simplex_dot3(argument4[__gi3], __x3, __y3, __z3);
}
 
return (32.0 * (__n0 + __n1 + __n2 + __n3)) * (argument6 - argument5) / 2 + (argument6 + argument5) / 2;
