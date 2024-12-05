#!/usr/bin/env gawk -f

function is_correct(a, b) {
    for (rule in rules) {
        split(rule, r, "|");
        if (r[1] == b && r[2] == a) {
            return 0;
        }
    }
    return 1;
}

BEGIN {
    FS = ",";
}

NF == 1 {
    rules[$1];
}

NF > 1 {
    for (i = 1; i <= NF; i++) {
        for (j = i + 1; j <= NF; j++) {
            if (!is_correct($i, $j)) {
                next;
            }
        }
    }

    m = int(NF / 2) + 1;
    s += $m;
}

END {
    print s;
}
