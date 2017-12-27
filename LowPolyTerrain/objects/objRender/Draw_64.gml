// Matrices for surfaces
var m_view = matrix_get(matrix_view);
var m_proj = matrix_get(matrix_projection);

var OUT = DiffuseBuff;

// PostFX pipeline
#region HBAO Pass
// DiffuseBuff, DepthBuff2, NormalBuff, WorldPosBuff
if( HBAO ) {
    OUT = HBAOPass;
    HBAOPass = GenBuffer(HBAOPass);
    NoiseBuff = generateNoise(NoiseBuff);
    
    surface_set_target(HBAOPass);
        
        matrix_set(matrix_view, m_view);        // <------------ OTHERWISE WONT WORK (Thx to Juju)
        matrix_set(matrix_projection, m_proj);
        
        draw_clear_alpha(0, 0);
        
        shader_set(shHBAO);
            
            texture_set_stage(_HBAO_DepthSamp   , surface_get_texture(DepthBuff2  ));
            texture_set_stage(_HBAO_NormalSamp  , surface_get_texture(NormalBuff  ));
            texture_set_stage(_HBAO_NoiseSamp   , surface_get_texture(NoiseBuff   ));
            texture_set_stage(_HBAO_WorldPosSamp, surface_get_texture(WorldPosBuff));
            texture_set_stage(_HBAO_DiffuseSamp , surface_get_texture(DiffuseBuff ));
            
            //shader_set_uniform_f(_HBAO_, );
            shader_set_uniform_f(_HBAO_ScreenSize, __view_get( e__VW.WView, 0 ), __view_get( e__VW.HView, 0 ));
            shader_set_uniform_matrix_array(_HBAO_m_Proj, m_Proj);
            shader_set_uniform_matrix_array(_HBAO_m_InvProj, matrix_inverse(m_Proj));
            shader_set_uniform_matrix_array(_HBAO_m_InvView, matrix_inverse(m_View));
}

draw_surface(DiffuseBuff, 0, 0); // HBAO: Used only for Texcoord

if( HBAO ) {
        shader_reset();
        
    surface_reset_target();
}
#endregion

#region HBAO's Blur Pass (Meh)
var m_view = matrix_get(matrix_view);
var m_proj = matrix_get(matrix_projection);

if( HBAO && HBAO_Blur ) {
    HBAOBlurPass = GenBuffer(HBAOBlurPass);
    
    var shader = shBlur;
    var Pass = HBAOPass;
    repeat( BlurStrength ) {
        // Vertical / Bokeh
        surface_set_target(HBAOBlurPass);
            
            draw_clear_alpha(-1, 0);
            matrix_set(matrix_view, m_view);        // <------------ OTHERWISE WONT WORK
            matrix_set(matrix_projection, m_proj);
            
            shader_set(shader);
                
                shader_set_uniform_f(_Blur_ScreenSize, __view_get( e__VW.WView, 0 ), __view_get( e__VW.HView, 0 ));
                shader_set_uniform_f(_Blur_Type, 0);
                shader_set_uniform_f(_Blur_Radius, BlurSize);
                
                draw_surface(Pass, 0, 0);
                
            shader_reset();
            
        surface_reset_target();
        
        // Horizontal
        surface_set_target(HBAOBlurPass);
            
            draw_clear_alpha(-1, 0);
            matrix_set(matrix_view, m_view);        // <------------ OTHERWISE WONT WORK
            matrix_set(matrix_projection, m_proj);
            
            shader_set(shader);
                
                shader_set_uniform_f(_Blur_ScreenSize, __view_get( e__VW.WView, 0 ), __view_get( e__VW.HView, 0 ));
                shader_set_uniform_f(_Blur_Type, 1);
                shader_set_uniform_f(_Blur_Radius, BlurSize);
                
                draw_surface(HBAOBlurPass, 0, 0);
                
            shader_reset();
            
        surface_reset_target();
        
        Pass = HBAOBlurPass;
    }
    
    OUT = HBAOBlurPass;
}
#endregion

#region Combine HBAO and diffuse buffer
if( HBAO ) {
    surface_set_target(OUT);
        
        draw_clear_alpha(0, 0);
        
        matrix_set(matrix_view, m_view);        // <------------ OTHERWISE WONT WORK
        matrix_set(matrix_projection, m_proj);
        
        shader_set(shApplyHBAO);
            
            texture_set_stage(_ApplyHBAO_Diffuse, surface_get_texture(DiffuseBuff));
            
            draw_surface(OUT, 0, 0);
            
        shader_reset();
        
    surface_reset_target();
}
#endregion

#region DoF Pass (isn't best solution for now)
if( DoF ) {
    TempBuff = GenBuffer(TempBuff);
    
    var shader = shBlur;
    var Pass = OUT;
    
    repeat( BlurStrength ) {
        // Vertical / Bokeh
        surface_set_target(TempBuff);
            
            matrix_set(matrix_view, m_view);        // <------------ OTHERWISE WONT WORK
            matrix_set(matrix_projection, m_proj);
            
            draw_clear_alpha(0, 0);
            
            shader_set(shader);
                
                shader_set_uniform_f(_Blur_ScreenSize, WIDTH, HEIGHT);
                shader_set_uniform_f(_Blur_Type, 0);
                shader_set_uniform_f(_Blur_Radius, BlurSize);
                
                draw_surface(Pass, 0, 0);
                
            shader_reset();
            
        surface_reset_target();
        
        // Horizontal
        surface_set_target(TempBuff);
            
            matrix_set(matrix_view, m_view);        // <------------ OTHERWISE WONT WORK
            matrix_set(matrix_projection, m_proj);
            
            draw_clear_alpha(0, 0);
            
            shader_set(shader);
                
                shader_set_uniform_f(_Blur_ScreenSize, WIDTH, HEIGHT);
                shader_set_uniform_f(_Blur_Type, 1);
                shader_set_uniform_f(_Blur_Radius, BlurSize);
                
                draw_surface(TempBuff, 0, 0);
                
            shader_reset();
            
        surface_reset_target();
        
        Pass = TempBuff;
    }
    
    // DoF
    surface_set_target(OUT);
        
        draw_clear_alpha(0, 0);
        shader_set(shDepthOfField);
            
            texture_set_stage(_DoF_DepthSamp, surface_get_texture(DepthBuff2));
            texture_set_stage(_DoF_BlurSamp , surface_get_texture(TempBuff));
            shader_set_uniform_f(_DoF_FocalDistance, DoF_FocalDistance);
            shader_set_uniform_f(_DoF_FocalRange   , DoF_FocalRange   );
            
            draw_surface(DiffuseBuff, 0, 0);
            
        shader_reset();
        
    surface_reset_target();
}
#endregion

// Output
#region Render OUT buffer
if( RenderOutput ) {
    draw_surface(OUT, 0, 0);
}
#endregion

// Debug
#region Debug surfaces
if( DEBUG ) {
    var buff = [ReflectionBuff, RefractionBuff, DepthBuff, DiffuseBuff, DepthBuff2, NormalBuff, WorldPosBuff, HBAOPass, HBAOBlurPass, TempBuff];
    
    var i = array_length_1d(buff);
    for( var j = 0; j < i; j++ ) {
        if( surface_exists(buff[j]) ) {
            draw_surface_stretched(buff[j], __view_get( e__VW.WView, 0 ) / i * j, 0, __view_get( e__VW.WView, 0 ) / i, __view_get( e__VW.WView, 0 ) / (i * 2));
        }
        
        draw_set_color(c_red);
        draw_rectangle(__view_get( e__VW.WView, 0 ) / i * j, 0, __view_get( e__VW.WView, 0 ), __view_get( e__VW.WView, 0 ) / (i * 2), 1);
        draw_set_color(c_white);
    }
    
    draw_text(0, 16, string_hash_to_newline(trace(fps, fps_real)));
}
#endregion
