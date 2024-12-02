#!/usr/bin/gawk -f

{
    p = $1;
    if ($1 > $2) {
        d = 1;
    } else {
        d = 0;
    }

    for (i = 2; i <= NF; i++) {
        if ($i > p && d) {
            break;
        }
        if ($i < p && !d) {
            break;
        }

        if ($i == p) {
            break;
        }

        if ($i > p + 3) {
            break;
        }
        if ($i < p - 3) {
            break;
        }

        p = $i;

        if (i == NF) {
            s++;
        }
    }
}

END {
    print s;
}
