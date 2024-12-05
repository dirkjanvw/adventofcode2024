#!/usr/bin/env gawk -f

function print_array(arr) {
    for (i in arr) {
        print arr[i];
    }
    print "";
}

function copy_array(arr, brr) {
    delete brr;
    for (i in arr) {
        brr[i] = arr[i];
    }
}

function transpose_array(arr) {
    delete crr;
    for (i in arr) {
        n = split(arr[i], brr, "");
        for (j = 1; j <= n; j++) {
            crr[j] = crr[j] brr[j];
        }
    }
    for (i in crr) {
        arr[i] = crr[i];
    }
}

function create_dots(number) {
    dots = "";
    for (i = 1; i <= number; i++) {
        dots = dots ".";
    }
    return dots;
}

function shift_array(arr) {
    delete brr;
    for (i in arr) {
        brr[i] = arr[i];
    }
    total = i;
    for (j in brr) {
        arr[j] = create_dots(total - j) brr[j] create_dots(j - 1);
    }
}

function search_xmas(arr) {
    t = 0;
    for (i in arr) {
        while (match(arr[i], /(XMAS|SAMX)/)) {
            t++;
            arr[i] = substr(arr[i], RSTART + RLENGTH - 2);
        }
    }
    return t;
}

{
    a[FNR] = $1;
}

END {
    copy_array(a, b);
    copy_array(a, c);
    copy_array(a, d);

    transpose_array(b);
    transpose_array(d);

    shift_array(c);
    transpose_array(c);

    shift_array(d);
    transpose_array(d);

    #print_array(a);
    #print_array(b);
    #print_array(c);
    #print_array(d);

    s = search_xmas(a);
    s += search_xmas(b);
    s += search_xmas(c);
    s += search_xmas(d);

    print s;
}
