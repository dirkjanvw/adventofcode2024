#!/usr/bin/env gawk -f

function search_xmas(arr, rows, columns) {
    count = 0;
    for (i = 2; i < rows; i++) {
        for (j = 2; j < columns; j++) {
            if (arr[i, j] != "A") {
                continue;
            } else {
                if (arr[i - 1, j - 1] == "M" && arr[i - 1, j + 1] == "M" && arr[i + 1, j - 1] == "S" && arr[i + 1, j + 1] == "S") {
                    count++;
                }
                if (arr[i - 1, j - 1] == "S" && arr[i - 1, j + 1] == "M" && arr[i + 1, j - 1] == "S" && arr[i + 1, j + 1] == "M") {
                    count++;
                }
                if (arr[i - 1, j - 1] == "S" && arr[i - 1, j + 1] == "S" && arr[i + 1, j - 1] == "M" && arr[i + 1, j + 1] == "M") {
                    count++;
                }
                if (arr[i - 1, j - 1] == "M" && arr[i - 1, j + 1] == "S" && arr[i + 1, j - 1] == "M" && arr[i + 1, j + 1] == "S") {
                    count++;
                }
            }
        }
    }
    return count;
}

BEGIN {
    FS = "";
    delete a;
}

{
    for (i = 1; i <= NF; i++) {
        a[FNR, i] = $i;
    }
}

END {
    print search_xmas(a, FNR, NF);
}
