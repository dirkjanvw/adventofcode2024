#!/usr/bin/perl
use strict;
use warnings;

my $s = 0;

while (my $l = <>) {
    while ($l =~ /mul\((\d+),(\d+)\)/g) {
        $s += $1 * $2;
    }
}

print "$s\n";
