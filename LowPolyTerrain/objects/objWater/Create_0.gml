VERTICES_PER_SQUARE = 3 * 2; // 2 triangles
VERTEX_SIZE_BYTES = 8 + 4; // x, z position + 4 ubytes

WAVE_TIME = 0;

gridCount = WORLD_SIZE;
totalVertexCount = gridCount * gridCount * VERTICES_PER_SQUARE;
byteSize = VERTEX_SIZE_BYTES * totalVertexCount;

_Buf = createWaterMesh(totalVertexCount, byteSize, gridCount);

a = pr_trianglelist;
b = pr_linelist;
mode = a;

vertex_format_begin();
    vertex_format_add_position();
    vertex_format_add_custom(vertex_type_float4, vertex_usage_texcoord);
    vertex_format_add_custom(vertex_type_float2, vertex_usage_texcoord);
vFormat = vertex_format_end();
vBuff = vertex_create_buffer_from_buffer(_Buf, vFormat);
vertex_freeze(vBuff);
buffer_delete(_Buf);

_Height   = shader_get_uniform(shWaterRender, "_Height");
_CamPos   = shader_get_uniform(shWaterRender, "_CamPos");
_WaveTime = shader_get_uniform(shWaterRender, "_WaveTime");
_NearFar  = shader_get_uniform(shWaterRender, "_NearFar");
_Texel    = shader_get_uniform(shWaterRender, "_Texel");
_Far      = shader_get_uniform(shWaterRender, "_Far");

_LightDir = shader_get_uniform(shWaterRender, "_LightDir");
_LightColor = shader_get_uniform(shWaterRender, "_LightColor");
_LightBias = shader_get_uniform(shWaterRender, "_LightBias");

_Reflection = shader_get_sampler_index(shWaterRender, "_ReflectionSampler");
_Refraction = shader_get_sampler_index(shWaterRender, "_RefractionSampler");
_Depth      = shader_get_sampler_index(shWaterRender, "_DepthSampler");
_CausDistortionSamp = shader_get_sampler_index(shWaterRender, "_CausDistortionSamp");
_NormDistortionSamp = shader_get_sampler_index(shWaterRender, "_NormDistortionSamp");
_FoamDistortionSamp = shader_get_sampler_index(shWaterRender, "_FoamDistortionSamp");

dir = normalize(LIGHT_POS);

