/// @description  generateHeights(gridSize);
/// @function  generateHeights
/// @param gridSize
/// @param heightmap
var gridSize = argument0;
var heights = alloc(gridSize + 1, gridSize + 1);

var r = RANGE; // Range

if( USE_HEIGHTMAP && HEIGHTMAP > -1 ) {
    var w = WORLD_SIZE;
    var h = WORLD_SIZE;
    
    var t_buff = buffer_create(w * h * 4 + 8, buffer_fixed, 1);
    var surf = surface_create(w, h);
    
    // Write heightmap to surface
    surface_set_target(surf);
        
        draw_clear_alpha(0, 0);
        draw_sprite_stretched(HEIGHTMAP, 0, 0, 0, WORLD_SIZE, WORLD_SIZE);
        
    surface_reset_target();
    
    // Write to buffer
    buffer_write(t_buff, buffer_f32, w);
    buffer_write(t_buff, buffer_f32, h);
    buffer_get_surface(t_buff, surf, 0, 8, 0);
    
    // Read heightmap from buffer
    for( var i = 0; i <= w; i++ ) {
        for( var j = 0; j <= h; j++ ) {
            var q = color_get_red(bufferRead(t_buff, i, j)) / 255;
            heights[i, j] = RANGE * (q * 2 - 1);
        }
    }
    
    // Delete buffer and surface
    surface_free(surf);
    buffer_delete(t_buff);
} else {
    for( var i = 0; i <= gridSize; i++ ) {
        for( var j = 0; j <= gridSize; j++ ) {
            if( CURRENT_NOISE == NOISE_SIMPLEX ) {
                heights[i, j] = simplex_octave2(i, j, _hash, _grad, -r, r, OCTAVES, ROUGHNESS, SCALE);
            } else if( CURRENT_NOISE == NOISE_PERLIN ) {
                heights[i, j] = perlin_noise(i, j, OCTAVES, AMPLITUDE, ROUGHNESS);
            }
        }
    }
}

return heights;
