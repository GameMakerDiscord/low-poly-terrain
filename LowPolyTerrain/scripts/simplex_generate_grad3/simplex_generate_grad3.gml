/// @description simplex_generate_grad3()
/// @function simplex_generate_grad3
/*
    Generates the 3D gradients
    
    Returns -   Array of arrays of points.
 */
var a0, a1, a2, a3, a4, a5,
    a6, a7, a8, a9, a10, a11;
    
a0[0] = 1    a0[1] = 1    a0[2] = 0
a1[0] = -1   a1[1] = 1    a1[2] = 0
a2[0] = 1    a2[1] = -1   a2[2] = 0
a3[0] = -1   a3[1] = -1   a3[2] = 0

a4[0] = 1    a4[1] = 0    a4[2] = 1
a5[0] = -1   a5[1] = 0    a5[2] = 1
a6[0] = 1    a6[1] = 0    a6[2] = -1
a7[0] = -1   a7[1] = 0    a7[2] = -1

a8[0] = 0    a8[1] = 1    a8[2] = 0
a9[0] = 0    a9[1] = -1   a9[2] = 0
a10[0] = 0   a10[1] = 1   a10[2] = -1
a11[0] = 0   a11[1] = -1  a11[2] = -1

var result;

result[11] = a11
result[10] = a10
result[9] = a9
result[8] = a8
result[7] = a7
result[6] = a6
result[5] = a5
result[4] = a4
result[3] = a3
result[2] = a2
result[1] = a1
result[0] = a0
 
return result