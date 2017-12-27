/// @description  createWaterMesh(totalVertexCount, byteSize, gridCount);
/// @function  createWaterMesh
/// @param totalVertexCount
/// @param  byteSize
/// @param  gridCount
var totalVertexCount = argument0;
var byteSize = argument1;
var gridCount = argument2;
var _Buf = buffer_create(byteSize, buffer_grow, 1);
buffer_seek(_Buf, buffer_seek_start, 0);

for( var r = 0; r < gridCount; r++ ) {
    for( var c = 0; c < gridCount; c++ ) {
        storeGridSquare(c, r, gridCount, _Buf);
    }
}

return _Buf;
