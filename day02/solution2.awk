#!/usr/bin/env gawk -f

function print_array(arr) {
    for (i = 1; i <= length(arr); i++) {
        printf "%s ", arr[i];
    }
    printf "\n";
}

function valid_report(a, total) {
    p = a[1];
    if (a[1] > a[2]) {
        d = 1;
    } else {
        d = 0;
    }

    for (i = 2; i <= total; i++) {
        if (a[i] > p && d) {
            print "  N because " a[i] " > " p " and " d;
            break;
        }
        if (a[i] < p && !d) {
            print "  N because " a[i] " < " p " and " d;
            break;
        }

        if (a[i] == p) {
            print "  N because " a[i] " == " p;
            break;
        }

        if (a[i] > p + 3) {
            print "  N because " a[i] " > " p " + 3";
            break;
        }
        if (a[i] < p - 3) {
            print "  N because " a[i] " < " p " - 3";
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
    printf "full report: ";
    print_array(all);

    if (valid_report(all, n)) { #normal check
        print "Y1";
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
            printf "testing subreport: ";
            print_array(test);
            if (valid_report(test, n - 1)) {
                print "Y2";
                s++;
                break;
            }
        }
    }
}

END {
    print s;
}
