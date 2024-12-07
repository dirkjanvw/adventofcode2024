#!/usr/bin/env gawk -f

function count_array(arr, rows, cols) {
    count = 0;
    for (i = 1; i <= rows; i++) {
        for (j = 1; j <= cols; j++) {
            count += arr[i, j];
        }
    }
    return count;
}


BEGIN {
    FS = "";
    delete o;
    delete x;
    xpos = 0;
    ypos = 0;
    direction = 0; # 0 = up, 1 = right, 2 = down, 3 = left
}

{
    for (i = 1; i <= NF; i++) {
        o[FNR, i] = ($i == "#") ? 1 : 0;

        if ($i == "^") {
            x[FNR, i] = 1;
            xpos = i;
            ypos = FNR;
        } else {
            x[FNR, i] = 0;
        }
    }
}

END {
    while (xpos > 0 && xpos < NF && ypos > 0 && ypos < FNR) {
        # calculate new position
        if (direction == 0) {
            newy = ypos - 1;
            newx = xpos;
        } else if (direction == 1) {
            newy = ypos;
            newx = xpos + 1;
        } else if (direction == 2) {
            newy = ypos + 1;
            newx = xpos;
        } else if (direction == 3) {
            newy = ypos;
            newx = xpos - 1;
        }

        # check if we can move
        if (o[newy, newx] == 1) {
            direction = (direction + 1) % 4;
        } else {
            ypos = newy;
            xpos = newx;
            x[ypos, xpos] = 1;
        }
    }

    print count_array(x, FNR, NF);
}
