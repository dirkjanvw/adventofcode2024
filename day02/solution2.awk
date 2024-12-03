#!/usr/bin/env gawk -f

function valid_report(a, total) {
    p = a[1];
    if (a[1] > a[2]) {
        d = 1;
    } else {
        d = 0;
    }

    for (i = 2; i <= total; i++) {
        if (a[i] > p && d) {
            break;
        }
        if (a[i] < p && !d) {
            break;
        }

        if (a[i] == p) {
            break;
        }

        if (a[i] > p + 3) {
            break;
        }
        if (a[i] < p - 3) {
            break;
        }

        p = a[i];

        if (i == total) {
            return 1;
        }
    }
}

{
    n = split($0, all, " ");

    if (valid_report(all, n)) { #normal check
        s++;
    } else { #remove each column once separately and check again (one mistake is allowed namely)
        for (j = 1; j <= NF; j++) {
            pos = 1;
            for (x = 1; x <= n; x++) {
                if (x == j) {
                    continue;
                }
                test[pos++] = all[x];
            }
            if (valid_report(test, n - 1)) {
                s++;
                break;
            }
        }
    }
}

END {
    print s;
}
