/// @description  View around, and walking
var cx = __view_get( e__VW.WView, 0 ) / 2;
var cy = __view_get( e__VW.HView, 0 ) / 2;

var dx = cx - window_mouse_get_x();
var dy = cy - window_mouse_get_y();

if( !window_has_focus() ) { exit; }

if( os_type != os_uwp ) {
    window_mouse_set(cx, cy);
} else {
    display_mouse_set(cx + window_get_x(), cy + window_get_y());
}

dir += dx / 10;
pitch += dy / 10;

var move1 = (keyboard_check(vk_up) || keyboard_check(ord("W")))
         - (keyboard_check(vk_down) || keyboard_check(ord("S")));

var move2 = (keyboard_check(vk_right) || keyboard_check(ord("D")))
         - (keyboard_check(vk_left) || keyboard_check(ord("A")));

spd = lerp(spd, m_spd * max(abs(move1), abs(move2)), .2);

x += lengthdir_x(abs(move1) * spd, dir) * move1;
y += lengthdir_y(abs(move1) * spd, dir) * move1;
z += lengthdir_z(abs(move1) * spd, pitch) * move1;

x += lengthdir_x(abs(move2) * spd, dir - 90 * move2);
y += lengthdir_y(abs(move2) * spd, dir - 90 * move2);

moving = max(abs(move1), abs(move2));

