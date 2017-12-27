/// @desc Creates the vertex format we will use for all vertex buffer primitives and models

    vertex_format_begin();
    vertex_format_add_position_3d();
    vertex_format_add_normal();
    vertex_format_add_textcoord();
    vertex_format_add_colour();
    vf = vertex_format_end();
    
    return vf;
