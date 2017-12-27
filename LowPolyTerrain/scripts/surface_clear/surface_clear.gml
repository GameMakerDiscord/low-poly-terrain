/// @description  surface_clear(id, c, a);
/// @function  surface_clear
/// @param id
/// @param  c
/// @param  a
var c = 0, a = 0;

if( argument_count > 1 ) c = argument[1];
if( argument_count > 2 ) a = argument[2];

surface_set_target(argument[0]);
    
    draw_clear_alpha(c, a);
    
surface_reset_target();

