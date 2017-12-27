/// @description  ConvertPrepare([xfrom y z], [xto y z], [xup y z], angle, aspect);
/// @function  ConvertPrepare
/// @param [xfrom y z]
/// @param  [xto y z]
/// @param  [xup y z]
/// @param  angle
/// @param  aspect
var from = argument0;
var to = argument1;
var up = argument2;
var angle = argument3;
var aspect = argument4;

var len;

FROM = from;

DELTA = sub(to, from);
len = length(DELTA);

DELTA = normalize(DELTA);
UP = sub(up, mul(DELTA, copy(len, 3)));

len = length(UP);
UP = normalize(UP);

tFOV = tan(angle * pi / 360);
UP = mul(UP, copy(tFOV, 3));

VECTOR = mul(sub(mul(shift(UP, 1), reverse(DELTA)), mul(shift(DELTA, 1), reverse(UP))), copy(aspect, 3));

/*
var mm;
dX = argument3 - argument0;
dY = argument4 - argument1;
dZ = argument5 - argument2;
mm = sqrt(dX*dX + dY*dY + dZ*dZ);
dX /= mm;
dY /= mm;
dZ /= mm;
uX = argument6;
uY = argument7;
uZ = argument8;
mm = uX*dX + uY*dY + uZ*dZ;
uX -= mm*dX;
uY -= mm*dY;
uZ -= mm*dZ;
mm = sqrt(uX*uX + uY*uY + uZ*uZ);
uX /= mm;
uY /= mm;
uZ /= mm;
tFOV = tan(argument9*pi/360);
uX *= tFOV;
uY *= tFOV;
uZ *= tFOV;
vX = uY*dZ - dY*uZ;
vY = uZ*dX - dZ*uX;
vZ = uX*dY - dX*uY;
vX *= argument10;
vY *= argument10;
vZ *= argument10;
