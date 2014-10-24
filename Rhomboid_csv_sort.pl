## This is /u/Rhomboid's code from over at /r/Perl
## Just saving this great piece of code!

#!/usr/bin/perl
use strict;
use warnings;
use v5.10;

my @order;

while(<>) {
    my @fields = split /, *| *\n/;

    @order = sort { $fields[$a] cmp $fields[$b] } 0..$#fields unless @order;

    s/^0+(?=\d+$)// for @fields;   

    say join ',', map $fields[$_], @order;

