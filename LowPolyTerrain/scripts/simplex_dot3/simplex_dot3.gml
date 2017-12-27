/// @description simplex_dot3([ARRAY 1D:INT] vec, x, y, z)
/// @function simplex_dot3
/// @param [ARRAY 1D:INT] vec
/// @param  x
/// @param  y
/// @param  z
/*
    3D dot product.
    
    Argument0   -   1D array of 3 vector values
    Argument1   -   x val
    Argument2   -   y val
    Argument3   -   z val
    
    Returns     -   Result
 */
 
return (argument0[@ 0] * argument1) + (argument0[@ 1] * argument2) + (argument0[@ 2] * argument3)
