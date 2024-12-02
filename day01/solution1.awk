#!/usr/bin/gawk -f

{
    a[FNR] = $1;
    b[FNR] = $2;
}

END {
    n = asort(a);
    asort(b);

    s = 0;
    for (i = 1; i <= n; i++) {
        d = b[i] - a[i];
        if (d < 0) {
            s -= d;
        } else {
            s += d;
        }
    }
    print s;
}
