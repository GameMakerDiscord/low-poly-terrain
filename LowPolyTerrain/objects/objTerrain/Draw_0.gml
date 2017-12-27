if( shader_current() == -1 ) {
    shader_set(shTerrainRender);
        
        shader_set_uniform_f(_Clip, Clip[0], Clip[1], Clip[2], Clip[3]);
        shader_set_uniform_f(_Far, objCamera.FarClip / ((RT == RTRGT.PASS_OUT) ? RT_DEPTH_DOWNSCALE : CAMERA_FAR));
        
        // Normalized [0 - 1] (Ambient light, Diffuse light multiplers)
        shader_set_uniform_f(_LightBias, LIGHT_BIAS_X, LIGHT_BIAS_Y);
        shader_set_uniform_f(_LightDir, dir[0], dir[1], dir[2]);
        shader_set_uniform_f(_LightColor, LIGHT_COL_R, LIGHT_COL_G, LIGHT_COL_B);
        //*/
}

d3d_transform_add_scaling(WORLD_SCALE * RANGE, WORLD_SCALE * RANGE, WORLD_SCALE);
    
    vertex_submit(vBuff, mode, -1);
    
d3d_transform_set_identity();

if( shader_current() == shTerrainRender ) {
    shader_reset();
}
