/// @desc generateNoise(buff);
/// @arg buff
var buff = argument0;

// Generate offsets
if( !surface_exists(buff) ) {
    buff = GenBuffer(buff, 64);
    var noiseSize = 64;
    
    surface_set_target(buff);
        
        draw_clear(-1);
        
        var r, g, mag;
        for( var xx = 0; xx < noiseSize; xx++ ){
            for( var yy = 0; yy < noiseSize; yy++ ){
                r = random(2) - 1;
                g = random(2) - 1;
                mag = sqrt(sqr(r) + sqr(g));
                r /= mag;
                g /= mag;
                
                var col = make_color_rgb(floor(((r/2)+.5) * 255), floor(((g/2)+.5) * 255), 127);
                draw_point_color(xx - 1, yy, col);
            }
        }
        
    surface_reset_target();
}

return buff;