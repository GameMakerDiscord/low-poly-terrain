/// @description  WriteVertexTerrain(float3 P, float3 N, float3 C, Buff);
/// @function  WriteVertexTerrain
/// @param float3 P
/// @param  float3 N
/// @param  float3 C
/// @param  Buff
var P = argument0;
var N = argument1;
var C = argument2;
var _Buf = argument3;

C = vec(colour_get_red(C) / 255, 
        colour_get_green(C) / 255, 
        colour_get_blue(C) / 255);

buffer_write(_Buf, buffer_f32, P[0]); // Position  : 11  : 0
buffer_write(_Buf, buffer_f32, P[1]);           // : 10  : 1
buffer_write(_Buf, buffer_f32, P[2]);           // : 9   : 2
//buffer_write(_Buf, buffer_f32, 5);              // : 8   : 3

buffer_write(_Buf, buffer_f32, N[0]); // Normal    : 7   : 4
buffer_write(_Buf, buffer_f32, N[1]);           // : 6   : 5
buffer_write(_Buf, buffer_f32, N[2]);           // : 5   : 6
//buffer_write(_Buf, buffer_f32, 6);              // : 4   : 7

buffer_write(_Buf, buffer_f32, C[0]); // Color     : 3   : 8
buffer_write(_Buf, buffer_f32, C[1]);           // : 2   : 9
buffer_write(_Buf, buffer_f32, C[2]);           // : 1   : 10
//buffer_write(_Buf, buffer_f32, 7);              // : 0   : 11

