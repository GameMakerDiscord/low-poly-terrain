/// @desc vertex_buffer_triangle_3D();
/// @arg vertex_buffer_index
/// @arg x1
/// @arg y2
/// @arg z1
/// @arg x2
/// @arg y2
/// @arg z2
/// @arg x3
/// @arg y4
/// @arg z3
/// @arg tex_U1
/// @arg tex_V1
/// @arg tex_U2
/// @arg tex_V2
/// @arg tex_U3
/// @arg tex_V3

var ind, nx, ny, nz;
var za,zb,zc,xa,xb,xc,ya,yb,yc;

ind = argument0;
xa = argument1;
ya = argument2;
za = argument3;

xb = argument4;
yb = argument5;
zb = argument6;

xc = argument7;
yc = argument8;
zc = argument9;

nx = (za-zb)*(yc-yb)-(ya-yb)*(zc-zb);
ny = (xa-xb)*(zc-zb)-(za-zb)*(xc-xb);
nz = (ya-yb)*(xc-xb)-(xa-xb)*(yc-yb);

vertex_position_3d(ind,xa,ya,za);
    vertex_normal(ind,nx,ny,nz);
    vertex_texcoord(ind,argument10, argument11);
    vertex_colour(ind,c_white,1);
    
vertex_position_3d(ind,xb,yb,zb);
    vertex_normal(ind,nx,ny,nz);
    vertex_texcoord(ind,argument12, argument13);
    vertex_colour(ind,c_white,1);

vertex_position_3d(ind,xc,yc,zc);
    vertex_normal(ind,nx,ny,nz);
    vertex_texcoord(ind,argument14, argument15);
    vertex_colour(ind,c_white,1);