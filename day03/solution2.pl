#!/usr/bin/perl
use strict;
use warnings;

# define subroutine to check if a number should be printed
# based on whether the last do/don't hit was a do or don't
sub should_print {
    my $pos = $_[0];
    my $dos = $_[1];
    my $donts = $_[2];

    # find the highest number in dos that is less than pos
    my $last_do = 0;
    for my $d (@$dos) {
        if ($d < $pos && $d > $last_do) {
            $last_do = $d;
        }
    }

    # find the highest number in donts that is less than pos
    my $last_dont = 0;
    for my $d (@$donts) {
        if ($d < $pos && $d > $last_dont) {
            $last_dont = $d;
        }
    }

    # if the last do was after the last don't, we should print
    print "last do: $last_do, last dont: $last_dont\n";
    if ($last_do > $last_dont) {
        return 1;
    }
    if ($last_do == 0 && $last_dont == 0) {
        return 1;
    }
    return 0;
}

my $s = 0;

while (my $l = <>) {
    # declare arrays to store the positions of dos and donts
    my @dos;
    my @donts;

    # get dos and don'ts so that we know their positions
    while ($l =~ /do\(\)/g) {
        push @dos, $-[0];
    }
    while ($l =~ /don't\(\)/g) {
        push @donts, $-[0];
    }

    # go over all multiplications and multiply when after a do but ignore those after a don't
    my $ignore = 0;
    while ($l =~ /mul\((\d+),(\d+)\)/g) {
        my $pos = $-[0];
        print "pos: $pos\n";

        if (should_print($pos, \@dos, \@donts)) {
            print "multiplying $1 and $2\n";
            $s += $1 * $2;
        }
    }
}

print "$s\n";
