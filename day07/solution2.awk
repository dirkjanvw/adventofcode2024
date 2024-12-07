#!/usr/bin/env gawk -f

function print_totals() {
    printf "=> ";
    for (j = 1; j <= all_combinations; j++) {
        printf "%d ", totals[j];
    }
    print "";
}

{
    split($1, a, ":");
    result = a[1];

    all_combinations = 3 ** (NF - 2);
    delete totals;
    for (i = 1; i <= all_combinations; i++) {
        totals[i] = $2;
    }
    #print_totals();

    for (i = 3; i <= NF; i++) {
        no = i - 2;
        for (j = 1; j <= all_combinations; j++) {
            len_part = all_combinations / 3 ** no;
            #print j, no, len_part, int((j-1) / len_part) % 3;
            if (int((j-1) / len_part) % 3 == 2) {
                totals[j] += $i;
            } else if (int((j-1) / len_part) % 3 == 1) {
                totals[j] *= $i;
            } else if (int((j-1) / len_part) % 3 == 0) {
                totals[j] = int(totals[j] "" $i);
            }
        }
        #print_totals();
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
