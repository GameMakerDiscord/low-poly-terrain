/// scr_create_skybox_model(ind,x1,y1,z1,x2,y2,z2);

  var ind, x1, y1, z1, x2, y2, z2, tex;
  x1 = argument0;
  y1 = argument1;
  z1 = argument2;
  x2 = argument3;
  y2 = argument4;
  z2 = argument5;

/*
  U_left = 0;
  V_left = 0.5;
  
  U_right = 0.5;
  V_right = 0.5;
  
  U_front = 0.25;
  V_front = 0.5;
  
  U_back = 0.25;
  V_back = 0;

  U_top = 0.5;
  V_top = 0;
  
  U_bottom = 0;
  V_bottom = 0;
*/

vertex_format_begin();
    
    vertex_format_add_position_3d();
    vertex_format_add_normal();
    vertex_format_add_textcoord();
    vertex_format_add_colour();
    
vertex_format = vertex_format_end();;

//Left
model_skybox_left = vertex_create_buffer();
vertex_begin(model_skybox_left, vertex_format);
	vertex_buffer_triangle_3D(model_skybox_left, x1,y2,z1, x1,y2,z2, x1,y1,z2, 0,1, 0,0, 1,0);
	vertex_buffer_triangle_3D(model_skybox_left, x1,y1,z2, x1,y1,z1, x1,y2,z1, 1,0, 1,1, 0,1);    
vertex_end(model_skybox_left);
vertex_freeze(model_skybox_left);

//Right
model_skybox_right = vertex_create_buffer();
vertex_begin(model_skybox_right, vertex_format);
	vertex_buffer_triangle_3D(model_skybox_right, x2,y1,z1, x2,y1,z2, x2,y2,z2, 0,1, 0,0, 1,0);
	vertex_buffer_triangle_3D(model_skybox_right, x2,y2,z2, x2,y2,z1, x2,y1,z1, 1,0, 1,1, 0,1);      
vertex_end(model_skybox_right);
vertex_freeze(model_skybox_right);	

//Front
model_skybox_front = vertex_create_buffer();
vertex_begin(model_skybox_front, vertex_format);
	vertex_buffer_triangle_3D(model_skybox_front, x2,y2,z1, x2,y2,z2, x1,y2,z2, 0,1, 0,0, 1,0);
	vertex_buffer_triangle_3D(model_skybox_front, x1,y2,z2, x1,y2,z1, x2,y2,z1, 1,0, 1,1, 0,1);
vertex_end(model_skybox_front);
vertex_freeze(model_skybox_front);
  
//Back
model_skybox_back = vertex_create_buffer();
vertex_begin(model_skybox_back, vertex_format);
	vertex_buffer_triangle_3D(model_skybox_back, x1,y1,z1, x1,y1,z2, x2,y1,z2, 0,1, 0,0, 1,0);
    vertex_buffer_triangle_3D(model_skybox_back, x2,y1,z2, x2,y1,z1, x1,y1,z1, 1,0, 1,1, 0,1);
vertex_end(model_skybox_back);
vertex_freeze(model_skybox_back);

//Bottom
model_skybox_bottom = vertex_create_buffer();
vertex_begin(model_skybox_bottom, vertex_format);
	vertex_buffer_triangle_3D(model_skybox_bottom, x1,y2,z1, x1,y1,z1, x2,y1,z1, 0,1, 0,0, 1,0);
	vertex_buffer_triangle_3D(model_skybox_bottom, x2,y1,z1, x2,y2,z1, x1,y2,z1, 1,0, 1,1, 0,1);
vertex_end(model_skybox_bottom);
vertex_freeze(model_skybox_bottom);

//Top
model_skybox_top = vertex_create_buffer();
vertex_begin(model_skybox_top, vertex_format);
	vertex_buffer_triangle_3D(model_skybox_top, x2,y1,z2, x1,y1,z2, x1,y2,z2, 1,0, 0,0, 0,1);
    vertex_buffer_triangle_3D(model_skybox_top, x1,y2,z2, x2,y2,z2, x2,y1,z2, 0,1, 1,1, 1,0);	
vertex_end(model_skybox_top);
vertex_freeze(model_skybox_top);
;