/// @description  ConvertWorldToScreen([targetx y z], [xfrom y z]);
/// @function  ConvertWorldToScreen
/// @param [targetx y z]
/// @param  [xfrom y z]
var P = sub(argument0, FROM);
var len = sum2(mul(DELTA, P));

if( len == 0 ) return vec(0, -100, argument0[2]);
P = divide(P, copy(len, 3));

var len1 = sum2(mul(P, VECTOR)) / sqr((__view_get( e__VW.WView, 0 ) / __view_get( e__VW.HView, 0 )) * tan(45 * pi / 360));
var len2 = sum2(mul(P, UP)) / sqr(tan(45 * pi / 360));

return vec((len1 + 1) / 2 * __view_get( e__VW.WView, 0 ), (1 - len) / 2 * __view_get( e__VW.HView, 0 ), argument0[2]);

/*
var pX, pY, pZ, mm;
pX = argument0 - argument3;
pY = argument1 - argument4;
pZ = argument2 - argument5;
mm = pX*dX + pY*dY + pZ*dZ;
     
if( mm > 0 ) {
    pX /= mm;
    pY /= mm;
    pZ /= mm;
} else {
    return vec(0, -100, argument2);
}

mm = (pX*vX + pY*vY + pZ*vZ) / sqr((view_wview/view_hview)*tan(45*pi/360));
x_2d = (mm+1)/2*view_wview;
mm = (pX*uX + pY*uY + pZ*uZ) / sqr(tan(45*pi/360));
y_2d = (1-mm)/2*view_hview;

return vec(x_2d, y_2d, argument2);
