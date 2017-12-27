/// @description  CameraGetTanAspect(Field Of View FOV);
/// @function  CameraGetTanAspect
/// @param Field Of View FOV
return vec(tan(degtorad(argument0) / 2) * (__view_get( e__VW.WView, 0 ) / __view_get( e__VW.HView, 0 )), -tan(degtorad(argument0 / 2)));
