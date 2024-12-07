#!/usr/bin/env gawk -f

{
    split($1, a, ":");
    result = a[1];

    all_combinations = 2 ** (NF - 2);

    for (i = 1; i <= all_combinations; i++) {
        totals[i] = $2;
    }

    for (i = 3; i <= NF; i++) {
        no = i - 2;
        for (j = 1; j <= all_combinations; j++) {
            len_part = all_combinations / 2 ** no;
            if (int((j-1) / len_part) % 2) {
                totals[j] += $i;
            } else {
                totals[j] *= $i;
            }
        }
    }

    for (i in totals) {
        if (totals[i] == result) {
            s += result;
            next;
        }
    }
}

END {
    print s;
}
