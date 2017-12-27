/// @description simplex_raw2(x, y, [ARRAY 1D:INT] hash, [ARRAY 1D:1D:INT] gradient, min, max)
/// @function simplex_raw2
/// @param x
/// @param  y
/// @param  [ARRAY 1D:INT] hash
/// @param  [ARRAY 1D:1D:INT] gradient
/// @param  min
/// @param  max
/*
    Calculates the simplex noise for a specified position.
    Assumes a size of 256!
    
    Argument0   -   x position
    Argument1   -   y position
    Argument2   -   Array of hash values
    Argument3   -   Corner gradients
    Argument4   -   minimum range of final value
    Argument5   -   maximum range of final value
    
    NOTE: https://code.google.com/p/battlestar-tux/source/browse/procedural/simplexnoise.cpp
 */
var result = 0,
    //Noise contributions from the three corners:
    n0, n1, n2,
    //Skew input space to determine current simplex cell
    f2 = 0.5 * (sqrt(3.0) - 1.0);
    //Hairy factor for 2D
var s = (argument0 + argument1) * f2,
    i = floor(argument0 + s), // Treat as int
    j = floor(argument1 + s), // Treat as int
    g2 = (3.0 - sqrt(3.0)) / 6.0;
 
var t = (i + j) * g2,
//Unskew cell origin back to x / y
    X0 = i - t,
    Y0 = j - t;
//x / y distances from the cell origin
var x0 = argument0 - X0,
    y0 = argument1 - Y0;
 
var i1, j1;
if (x0 > y0)
{
    i1 = 1;
    j1 = 0;
}
else
{
    i1 = 0;
    j1 = 1;
}
    
var x1 = x0 - i1 + g2,
    y1 = y0 - j1 + g2,
    x2 = x0 - 1.0 + 2.0 * g2,
    y2 = y0 - 1.0 + 2.0 * g2;
 
//Work out hashed gradient indices of the three simplex corners:
var ii = i & 255,
    jj = j & 255;
var gi0 = argument2[@ ii + argument2[@ jj]] % 12,
    gi1 = argument2[@ ii + i1 + argument2[@ jj + j1]] % 12,
    gi2 = argument2[@ ii + 1 + argument2[@ jj + 1]] % 12
 
//Calculate contribution of ea. corner:
var t0 = 0.5 - sqr(x0) - sqr(y0);

if (t0 < 0)
    n0 = 0;
else
{
    t0 *= t0;
    n0 = sqr(t0) * simplex_dot2(argument3[@ gi0], x0, y0);
}
 
var t1 = 0.5 - sqr(x1) - sqr(y1);
if (t1 < 0)
    n1 = 0;
else
{
    t1 *= t1;
    n1 = sqr(t1) * simplex_dot2(argument3[@ gi1], x1, y1);
}
 
var t2 = 0.5 - sqr(x2) - sqr(y2);
if (t2 < 0)
    n2 = 0.0;
else
{
    t2 *= t2;
    n2 = sqr(t2) * simplex_dot2(argument3[@ gi2], x2, y2);
}
 
//Scale result between [-1..1]
result = 70 * (n0 + n1 + n2);
 
//Scale between whatever we like:
return result * (argument5 - argument4) / 2 + (argument5 + argument4) / 2;
