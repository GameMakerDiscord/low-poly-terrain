/// @description  string_compare(string1, string2);
/// @function  string_compare
/// @param string1
/// @param  string2
var s1=string(argument0), s2=string(argument1), n1=string_length(s1), n2=string_length(s2), d, diff, i, j;

if s1="" { s1="string1"; }
if s2="" { s2="string2"; }

for(i=0;i<=n1;i++) {d[i,0]=i}
for(j=0;j<=n2;j++) {d[0,j]=j}

for(i=1;i<=n1;i++)
{
    for(j=1;j<=n2;j++)
    {
        diff=!(string_copy(s1,i,1)==string_copy(s2,j,1));
        d[i,j]=min(d[i-1,j]+1,d[i,j-1]+1,d[i-1,j-1]+diff);
    }
}

return d[n1, n2];
