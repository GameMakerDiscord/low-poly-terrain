/// @description simplex_generate_hash()
/// @function simplex_generate_hash
/*
    Generates a 512-size hash with 256 uniqe values,
    each repeated once (to avoid out-of-bounds.
    
    Returns -   Array of hash values
 */
 
var __final;
__final[512] = 0;
 
for (var i = 0; i < 256; ++i)
    __final[i] = i;
 
//Randomize hash by swapping:
//Use different seeds for different simplex results:
for (var i = 0; i < 256; ++i)
{
    var __j = irandom(255),
        __s = __final[i];
    __final[i] = __final[__j];
    __final[__j] = __s;
}
 
for (var i = 0; i < 256; ++i)
    __final[255 + i] = __final[i];
 
return __final;
