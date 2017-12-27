// Generate simplex noise's hashs
if( CURRENT_NOISE == NOISE_SIMPLEX ) {
    _hash = simplex_generate_hash();
    _grad = simplex_generate_grad3();
}

// Set some other data
BiomColors = BiomColorArray;
Spread = COLOUR_SPREAD;

// Generate data
VERTEX_SIZE_BYTES = (buffer_sizeof(buffer_f32) * 3) * 3; // 3 floats * 3 types (Pososition, Normal, Color)
show_debug_message(VERTEX_SIZE_BYTES);

gridCount = WORLD_SIZE;

global.HeightMapTexture = sprHeightmap;
_Buf = createTerrainMesh(gridCount);

a = pr_trianglelist;
b = pr_linelist;
mode = a;

vertex_format_begin();
    
    vertex_format_add_custom(vertex_type_float3, vertex_usage_position);
    vertex_format_add_custom(vertex_type_float3, vertex_usage_normal);
    vertex_format_add_custom(vertex_type_float3, vertex_usage_colour);
    
vFormat = vertex_format_end();
vBuff = vertex_create_buffer_from_buffer(_Buf, vFormat);
vertex_freeze(vBuff);
buffer_delete(_Buf);

_Clip = shader_get_uniform(shTerrainRender, "_Clip");
_LightDir = shader_get_uniform(shTerrainRender, "_LightDir");
_LightColor = shader_get_uniform(shTerrainRender, "_LightColor");
_LightBias = shader_get_uniform(shTerrainRender, "_LightBias");
_Far = shader_get_uniform(shTerrainRender, "_Far");

dir = normalize(LIGHT_POS);
Clip = vec(0, 0, 0, 0);


