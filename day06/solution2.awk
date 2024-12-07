#!/usr/bin/env gawk -f

function print_o() {
    for (x = 1; x <= FNR; x++) {
        for (y = 1; y <= NF; y++) {
            printf "%s", o[x, y] == 1 ? "#" : ".";
        }
        print "";
    }
    print "";
}

function traverse_path() {
    xpos = xori;
    ypos = yori;
    direction = 0;
    count = 0;
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
        }

        # check if stuck in loop by artificial means
        if (count > FNR * NF) {
            return 1;
        }

        count++;
    }
    return 0;
}

BEGIN {
    FS = "";
    delete o;
    xori = xpos = 0;
    yori = ypos = 0;
    direction = 0; # 0 = up, 1 = right, 2 = down, 3 = left
}

{
    for (i = 1; i <= NF; i++) {
        o[FNR, i] = ($i == "#") ? 1 : 0;

        if ($i == "^") {
            xori = xpos = i;
            yori = ypos = FNR;
        }
    }
}

END {
    for (i = 1; i <= FNR; i++) {
        for (j = 1; j <= NF; j++) {
            print i, j, o[i, j];
            if (o[i, j] == 1 || i == yori && j == xori) {
                continue;
            }
            o[i, j] = 1;
            #print_o();
            s += traverse_path();
            o[i, j] = 0;
        }
    }
    print s;
}
