#region So many buffers!
ReflectionBuff = noone;
RefractionBuff = noone;
DepthBuff = noone;
DiffuseBuff = noone;
DepthBuff2 = noone;
NormalBuff = noone;
NoiseBuff = noone;
WorldPosBuff = noone;
HBAOPass = noone;
HBAOBlurPass = noone;
TempBuff = noone;
#endregion

#region Uniforms
if( HBAO ) {
    _HBAO_DepthSamp    = shader_get_sampler_index(shHBAO, "_DepthSamp" );
    _HBAO_NormalSamp   = shader_get_sampler_index(shHBAO, "_NormalSamp");
    _HBAO_DiffuseSamp  = shader_get_sampler_index(shHBAO, "_DiffuseSamp");
    _HBAO_NoiseSamp    = shader_get_sampler_index(shHBAO, "_NoiseSamp");
    _HBAO_WorldPosSamp = shader_get_sampler_index(shHBAO, "_WorldPosSamp");

    _HBAO_ScreenSize  = shader_get_uniform(shHBAO, "_ScreenSize");
    _HBAO_m_InvProj   = shader_get_uniform(shHBAO, "_m_InvProj");
    _HBAO_m_InvView   = shader_get_uniform(shHBAO, "_m_InvView");
    _HBAO_m_Proj      = shader_get_uniform(shHBAO, "_m_Proj");
    
    _ApplyHBAO_Diffuse = shader_get_sampler_index(shApplyHBAO, "_DiffuseSamp");
}

if( UseBlur ) {
    _Blur_ScreenSize = shader_get_uniform(shBlur, "_ScreenSize");
    _Blur_Type       = shader_get_uniform(shBlur, "_Type");
    _Blur_Radius     = shader_get_uniform(shBlur, "_Radius");
    
    _Bokeh_Stength   = shader_get_uniform(shBokeh, "_Stength");
    _Bokeh_Direction = shader_get_uniform(shBokeh, "_Direction");
    _Bokeh_Samples   = shader_get_uniform(shBokeh, "_Samples");
    _Bokeh_DepthSamp = shader_get_sampler_index(shBokeh, "_DepthSamp");
    
    _DoF_FocalDistance = shader_get_uniform(shDepthOfField, "_FocalDistance");
    _DoF_FocalRange    = shader_get_uniform(shDepthOfField, "_FocalRange");
    _DoF_DepthSamp     = shader_get_sampler_index(shDepthOfField, "_DepthSamp");
    _DoF_BlurSamp      = shader_get_sampler_index(shDepthOfField, "_BlurSamp");
}
#endregion

#region 3D Settings
gpu_set_blendenable(true);
display_reset(8, false);
gpu_set_tex_mip_filter(tf_anisotropic);
gpu_set_tex_mip_enable(mip_on);

gpu_set_texfilter(true);
gpu_set_texrepeat(true);
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);

//gpu_set_cullmode(cull_counterclockwise);
#endregion

if( WindowFull ) {
    var w = display_get_width();
    var h = display_get_height();
    
    __view_set(e__VW.WView, 0, w);
    __view_set(e__VW.HView, 0, h);
    
    surface_resize(application_surface, w, h);
    window_set_size(w, h);
    window_set_position(0, 0);
}

createSkyboxMesh();
