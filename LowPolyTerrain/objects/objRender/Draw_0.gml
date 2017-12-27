global.RENDER_TARGET = RTRGT.PASS_BUFF;
#region Reflection pass
ReflectionBuff = GenBuffer(ReflectionBuff);
surface_set_target(ReflectionBuff);
    
    draw_clear_alpha(0, 0);
    CameraReflect( objCamera );
    
    with( objTerrain ) {
        Clip = vec(0, 0, 1, -(WATER_HEIGHT + OFFSET) * WORLD_SCALE * RANGE);
        event_perform(ev_draw, 0);
    }
    
surface_reset_target();
#endregion

#region Refraction / Depth pass
RefractionBuff = GenBuffer(RefractionBuff);
DepthBuff = GenBuffer(DepthBuff);

surface_set_target_ext(0, RefractionBuff);
surface_set_target_ext(1, DepthBuff);
    
    draw_clear_alpha(0, 0);
    CameraSet( objCamera );
    
    with( objTerrain ) {
        Clip = vec(0, 0, -1, (WATER_HEIGHT + OFFSET) * WORLD_SCALE * RANGE);
        event_perform(ev_draw, 0);
    }
    
surface_reset_target();
#endregion

// Main pass
global.RENDER_TARGET = RTRGT.PASS_OUT;
#region Skybox
if( SKYBOX ) {
    // Set camera
    CameraSet( objCamera );
    
    // Render skybox
    var m_world = matrix_build(
        objCamera.x, objCamera.y, objCamera.z + objCamera.eyeLevel, 
        0, 0, 0, 
        RANGE * WORLD_SIZE, RANGE * WORLD_SIZE, RANGE * WORLD_SIZE
    );
    
    matrix_set(matrix_world, m_world);
        
        vertex_submit(model_skybox_left, pr_trianglelist, global.texture_skybox_left);
        vertex_submit(model_skybox_right, pr_trianglelist, global.texture_skybox_right);
        vertex_submit(model_skybox_front, pr_trianglelist, global.texture_skybox_front);
        vertex_submit(model_skybox_back, pr_trianglelist, global.texture_skybox_back);
        vertex_submit(model_skybox_top, pr_trianglelist, global.texture_skybox_top);
        vertex_submit(model_skybox_bottom, pr_trianglelist, global.texture_skybox_bottom);
        
    matrix_set(matrix_world, matrix_build_identity());
}
#endregion

#region GBUffer pass
DepthBuff2   = GenBuffer(DepthBuff2);
DiffuseBuff  = GenBuffer(DiffuseBuff);
NormalBuff   = GenBuffer(NormalBuff);
WorldPosBuff = GenBuffer(WorldPosBuff);

surface_set_target_ext(0, DiffuseBuff);
surface_set_target_ext(1, DepthBuff2);
surface_set_target_ext(2, NormalBuff);
surface_set_target_ext(3, WorldPosBuff);
    
    draw_clear_alpha(0, 0);
    
    // Set camera
    CameraSet( objCamera );
    
    // Render water
    with( objWater ) {
        gpu_set_cullmode(cull_clockwise);
        event_perform(ev_draw, 0);
        gpu_set_cullmode(cull_counterclockwise);
    }
    
    // Render terrain
    with( objTerrain ) {
        Clip = vec(0, 0, 0, 0);
        event_perform(ev_draw, 0);
    }
    
surface_reset_target();
#endregion

global.RENDER_TARGET = RTRGT.PASS_BUFF;

// Debug input
#region Keys
if( _DEBUG_ ) {
    var SPACE = keyboard_check_pressed(vk_space);
    with( objTerrain ) {
        if( SPACE ) {
            mode = a * (mode == b) + b * (mode == a);
        }
    }

    with( objWater ) {
        if( SPACE ) {
            mode = a * (mode == b) + b * (mode == a);
        }
    }
}
#endregion

