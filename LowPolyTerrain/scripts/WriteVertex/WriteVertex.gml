/// @description  WriteVertex(buffer, float2 pos, ubyte4 corners, textcoord);
/// @function  WriteVertex
/// @param buffer
/// @param  float2 pos
/// @param  float4 corners
/// @param  float2 textcoord
buffer_write(argument0, buffer_f32, argument1[0]);
buffer_write(argument0, buffer_f32, argument1[1]);

buffer_write(argument0, buffer_f32, argument2[0] * .5 + .5);
buffer_write(argument0, buffer_f32, argument2[1] * .5 + .5);
buffer_write(argument0, buffer_f32, argument2[2] * .5 + .5);
buffer_write(argument0, buffer_f32, argument2[3] * .5 + .5); // From [-1, 1] to [0, 1]

buffer_write(argument0, buffer_f32, argument3[0]);
buffer_write(argument0, buffer_f32, argument3[1]);
