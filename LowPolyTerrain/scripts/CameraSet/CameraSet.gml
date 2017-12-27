/// @description  CameraSet( CameraID );
/// @function  CameraSet
/// @param  CameraID 
with( argument0 ) {
    var f = (sin(current_time / 200) * 90 + 90);
    var vz = 0;
    var vy = 0;
    
    if( moving ) {
        // Enable bobling
        vy = lerp(ly, lengthdir_y(2 + (FOV2 > 0), f), .4) * VIEW_BOBBLE;
        vz = lerp(lz, lengthdir_x(1 + (FOV2 > 0), f), .4) * VIEW_BOBBLE;
    } else {
        // Slowly stop bobling
        vy = lerp(ly, 0, .1) * VIEW_BOBBLE;
        vz = lerp(lz, 0, .1) * VIEW_BOBBLE;
    }
    
    ly = vy;
    lz = vz;
    
    var pZ = z;
    var p = pitch;
    if( reflected ) {
        pZ = z - 2 * (z - WATER_HEIGHT * WORLD_SCALE * RANGE);
        p = -pitch;
    }
    
    d3d_set_projection_ext(
        x, y, pZ + eyeLevel, 
        x + lengthdir_x(32, dir), 
        y + lengthdir_y(32, dir) + vy, 
        pZ + eyeLevel + lengthdir_z(32, p) + vz, 
        0, 0, 1, FOV + FOV2, __view_get( e__VW.WView, 0 ) / __view_get( e__VW.HView, 0 ), 
        NearClip, FarClip
    );
}

m_Proj = matrix_get(matrix_projection);
m_View = matrix_get(matrix_view);