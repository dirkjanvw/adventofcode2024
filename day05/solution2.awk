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

function make_correct(arr) {
    for (i = 1; i <= length(arr); i++) {
        for (j = i + 1; j <= length(arr); j++) {
            if (!is_correct(arr[i], arr[j])) {
                t = arr[i];
                arr[i] = arr[j];
                arr[j] = t;
            }
        }
    }
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
                incorrects[$0];
                next;
            }
        }
    }
}

END {
    for (incorrect in incorrects) {
        n = split(incorrect, order, ",");
        make_correct(order);
        m = int(n / 2) + 1;
        s += order[m];
    }
    print s;
}
