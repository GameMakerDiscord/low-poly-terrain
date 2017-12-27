/// @description  pack(arrays);
/// @function  pack
/// @param arrays
var a, j = 0;

for( var q = 0; q < argument_count; q++ ) {
    for( var i = 0; i < array_length_1d(argument[q]); i++ ) {
        a[j] = array_get(argument[q], i);
        j++;
    }
}

return a;
