/// @description  alloc( n, [n] );
/// @function  alloc
/// @param  n
/// @param  [n] 
var a = -1;
if( argument_count == 1 ) { // 1 argument
    for( var i = argument[0]; i > 0; i-- ) {
        a[i] = 0;
    }
} else if( argument_count == 2 ) { // 2 arguments
    for( var i = argument[0]; i > 0; i-- ) {
        for( var j = argument[1]; j > 0; j-- ) {
            a[i, j] = 0;
        }
    }
}

return a;
