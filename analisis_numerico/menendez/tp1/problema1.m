cr = 0;
i = 1;

do
s = 0;
n = (2 * i) + 1;
for div = 1:(n-1);
if (rem(n,div) == 0);
s = s + div;
endif;
endfor;
if ( s > n );
disp(n);
cr = cr + 1;
endif;
i = i + 1;
until (cr == 5)


