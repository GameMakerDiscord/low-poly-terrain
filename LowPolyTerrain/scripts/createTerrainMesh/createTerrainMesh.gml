/// @description  createTerrainMesh(gridCount);
/// @function  createTerrainMesh
/// @param gridCount
var gridCount = argument0;

var heights = generateHeights(gridCount); // Generate heights
var colors  = generateColors(BiomColors, Spread, heights, gridCount); // Generate colors

// Generate mesh
var len = array_height_2d(heights);
var vertCount = calcVertCount(len); // Get number of vertices
var byteSize = VERTEX_SIZE_BYTES * vertCount;
var _Buf = buffer_create(byteSize, buffer_grow, 1); // Create buffer
buffer_seek(_Buf, buffer_seek_start, 0);

var lastRow = alloc(len - 1);
for( var i = 0; i < len - 1; i++ ) {
    for( var j = 0; j < array_length_2d(heights, i) - 1; j++ ) {
        var P0 = vec(i + 0, j + 0, heights[i + 0, j + 0]);
        var P1 = vec(i + 1, j + 0, heights[i + 1, j + 0]);
        var P2 = vec(i + 0, j + 1, heights[i + 0, j + 1]);
        var P3 = vec(i + 1, j + 1, heights[i + 1, j + 1]);
        
        var N0 = getNormal(P0, P1, P2);
        var N1 = getNormal(P1, P3, P2);
        
        // Left triangle
        WriteVertexTerrain(P0, N0, colors[i + 0, j + 0], _Buf);
        WriteVertexTerrain(P1, N0, colors[i + 1, j + 0], _Buf);
        WriteVertexTerrain(P2, N0, colors[i + 0, j + 1], _Buf);
        
        // Right triangle
        WriteVertexTerrain(P1, N1, colors[i + 1, j + 0], _Buf);
        WriteVertexTerrain(P3, N1, colors[i + 1, j + 1], _Buf);
        WriteVertexTerrain(P2, N1, colors[i + 0, j + 1], _Buf);
    }
}

// Return data
return _Buf;

