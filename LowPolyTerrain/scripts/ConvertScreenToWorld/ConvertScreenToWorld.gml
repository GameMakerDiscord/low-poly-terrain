/// @description  ConvertScreenToWorld(x, y);
/// @function  ConvertScreenToWorld
/// @param x
/// @param  y
// The script returns the 3d x and y coordinates at z = 0
var screenx = 2 * argument0/__view_get( e__VW.WView, 0 )-1;
var screeny = 1 - 2 * argument1/__view_get( e__VW.HView, 0 );

var M = sum(sum(DELTA, mul(UP, copy(screeny, 3))), mul(VECTOR, copy(screeny, 3)));
if( M[2] < 0 ) M[2] = 1;

return vec(FROM[0] - FROM[2] * M[0] / M[2], 
           FROM[1] - FROM[2] * M[1] / M[2], 
           0);

/*
screenx = 2*argument0/view_wview-1;
screeny = 1-2*argument1/view_hview;
mX = dX + uX*screeny + vX*screenx;
mY = dY + uY*screeny + vY*screenx;
mZ = dZ + uZ*screeny + vZ*screenx;

if( mZ != 0 ) return vec(argument2 - argument4 * mX / mZ, argument3 - argument4 * mY / mZ, 0);
return vec(argument2 - argument4 * mX, argument3 - argument4 * mY, 0);
