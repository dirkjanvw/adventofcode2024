#!/usr/bin/env gawk -f

function search_xmas(arr, rows, columns) {
    count = 0;
    for (i = 1; i <= rows; i++) {
        for (j = 1; j <= columns; j++) {
            if (arr[i, j] != "X") {
                continue;
            } else {
                # left
                if (j > 3) {
                    count += (arr[i, j - 1] == "M" && arr[i, j - 2] == "A" && arr[i, j - 3] == "S");
                }
                # right
                if (j < columns - 2) {
                    count += (arr[i, j + 1] == "M" && arr[i, j + 2] == "A" && arr[i, j + 3] == "S");
                }
                # up
                if (i > 3) {
                    count += (arr[i - 1, j] == "M" && arr[i - 2, j] == "A" && arr[i - 3, j] == "S");
                }
                # down
                if (i < rows - 2) {
                    count += (arr[i + 1, j] == "M" && arr[i + 2, j] == "A" && arr[i + 3, j] == "S");
                }
                # up-left
                if (i > 3 && j > 3) {
                    count += (arr[i - 1, j - 1] == "M" && arr[i - 2, j - 2] == "A" && arr[i - 3, j - 3] == "S");
                }
                # up-right
                if (i > 3 && j < columns - 2) {
                    count += (arr[i - 1, j + 1] == "M" && arr[i - 2, j + 2] == "A" && arr[i - 3, j + 3] == "S");
                }
                # down-left
                if (i < rows - 2 && j > 3) {
                    count += (arr[i + 1, j - 1] == "M" && arr[i + 2, j - 2] == "A" && arr[i + 3, j - 3] == "S");
                }
                # down-right
                if (i < rows - 2 && j < columns - 2) {
                    count += (arr[i + 1, j + 1] == "M" && arr[i + 2, j + 2] == "A" && arr[i + 3, j + 3] == "S");
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
