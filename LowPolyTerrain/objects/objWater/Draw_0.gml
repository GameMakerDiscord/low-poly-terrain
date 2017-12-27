WAVE_TIME += WAVE_SPEED;

var cam = camera_get_active();

shader_set(shWaterRender);
    
    shader_set_uniform_f(_Height, WATER_HEIGHT);
    shader_set_uniform_f(_CamPos, objCamera.x, objCamera.y, objCamera.z);
    shader_set_uniform_f(_WaveTime, WAVE_TIME);
    shader_set_uniform_f(_NearFar, objCamera.NearClip, objCamera.FarClip / CAMERA_FAR);
    shader_set_uniform_f(_Far, objCamera.FarClip / ((RT == RTRGT.PASS_OUT) ? RT_DEPTH_DOWNSCALE : 1));
    shader_set_uniform_f(_Texel, 1 / camera_get_view_width(cam), 1 / camera_get_view_height(cam));
    
    // Normalized [0 - 1] (Ambient light, Diffuse light multiplers)
    shader_set_uniform_f(_LightBias, LIGHT_BIAS_X, LIGHT_BIAS_Y);
    shader_set_uniform_f(_LightDir, dir[0], dir[1], dir[2]);
    shader_set_uniform_f(_LightColor, LIGHT_COL_R, LIGHT_COL_G, LIGHT_COL_B);
    
    texture_set_stage(_Reflection, surface_get_texture(objRender.ReflectionBuff));
    texture_set_stage(_Refraction, surface_get_texture(objRender.RefractionBuff));
    texture_set_stage(_Depth, surface_get_texture(objRender.DepthBuff));
    texture_set_stage(_CausDistortionSamp, sprite_get_texture(sprWaterCaustic, 0));
    texture_set_stage(_NormDistortionSamp, sprite_get_texture(sprWaterNormal, 0));
    texture_set_stage(_FoamDistortionSamp, sprite_get_texture(sprWaterFoam, 0));
    
    //d3d_transform_add_translation(0, WATER_HEIGHT, 0);
    d3d_transform_add_scaling(WORLD_SCALE * RANGE, WORLD_SCALE * RANGE, WORLD_SCALE * RANGE);
        
        vertex_submit(vBuff, mode, -1);
        
    d3d_transform_set_identity();
    
shader_reset();

