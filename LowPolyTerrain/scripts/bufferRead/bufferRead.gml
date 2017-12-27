/// @desc bufferRead(buff, x, y);
/// @param buff
/// @param x
/// @param y
var buff = argument0;

var w = buffer_peek(buff, 4, buffer_f32);
var offset = 4 * (argument1 * w + argument2) + 8;
return buffer_peek(buff, offset, buffer_u32);
