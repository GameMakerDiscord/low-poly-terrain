/// @description  GenBuffer(surf, [w], [h]);
/// @function  GenBuffer
/// @param surf
/// @param [w]
/// @param [h]
var s = argument[0];

if( !surface_exists(s) ) {
    var q = (argument_count == 1);
    var z = (argument_count == 3);
    
    return surface_create(q ? __view_get( e__VW.WView, 0 ) : argument[1], 
                          q ? __view_get( e__VW.HView, 0 ) : (z ? argument[2] : argument[1]));
}

return s;
