#!/usr/bin/gawk -f

{
    a[FNR] = $1;
    b[$2] += 1;
}

END {
    s = 0;
    for (i = 1; i <= FNR; i++) {
        s += a[i] * b[a[i]];
    }
    print s;
}
