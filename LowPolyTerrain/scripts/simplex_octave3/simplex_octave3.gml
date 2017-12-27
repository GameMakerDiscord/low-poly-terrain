/// @description simplex_octave3(x, y, z, [ARRAY 1D:INT] hash, [ARRAY 1D:1D:INT] gradient, min, max, octaves, persistance, scale)
/// @function simplex_octave3
/// @param x
/// @param  y
/// @param  z
/// @param  [ARRAY 1D:INT] hash
/// @param  [ARRAY 1D:1D:INT] gradient
/// @param  min
/// @param  max
/// @param  octaves
/// @param  persistance
/// @param  scale
/*
    Generates fractal simplex noise at the specified position.
    
    Argument0   -   x position
    Argument1   -   y position
    Argument2   -   z position
    Argument3   -   Array of hash values
    Argument4   -   Corner gradients
    Argument5   -   minimum range of final value
    Argument6   -   maximum range of final value
    Argument7   -   number of samples
    Argument8   -   delta octave intensity [0..1]
    Argument9   -   scale of deltas
    
    Returns     -   Calculated result 
    
    NOTE: https://code.google.com/p/battlestar-tux/source/browse/procedural/simplexnoise.cpp
          https://code.google.com/p/battlestar-tux/source/browse/procedural/simplexnoise.h
          http://www.6by9.net/simplex-noise-for-c-and-python/
*/
 
/*var __total = 0,
    __freq = argument9,
    __amp = 1,
    __maxAmp = 0; // Will keep things between [-1..1]
 
for (var i = 0; i < argument7; ++i)
{
    __total += simplex_raw3(argument0 * __freq, argument1 * __freq, argument2 * __freq, argument3, argument4, -1, 1) * __amp;
    
    __freq *= 2;
    __maxAmp += __amp;
    __amp *= argument8;
}
 
return (__total / __maxAmp) * (argument6 - argument7) / 2 + (argument6 + argument7) / 2 ;*/
